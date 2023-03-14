import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Components/Product%20Class/Products_Class.dart';
import 'package:xeats/controllers/Cubits/ProductsCubit/ProductsStates.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(SuperProductsStates());
  static ProductsCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  String BASEURL = "https://www.x-eats.com";

  List<dynamic> MostSold = [];
  Map itemImages = {};

  void GetMostSoldProducts() {
    DioHelper.getdata(url: 'get_products_mostSold_products/', query: {})
        .then((value) async {
      MostSold = value.data['Names'];
      var data;
      ProductClass? theItem;

      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  List<dynamic> new_products = [];
  void NewProducts() {
    DioHelper.getdata(url: 'get_products_new_products/', query: {})
        .then((value) {
      new_products = value.data['Names'];
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  List<dynamic> getposters = [];
  void getPoster() {
    DioHelper.getdata(url: 'get_poster/', query: {}).then((value) {
      getposters = value.data['Names'];
      print(getposters);
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  List<String> EnglishName = [];
  List<String> ArabicName = [];
  Future<void> ClearProductsId() async {
    ProductId.clear();
    EnglishName.clear();
    ArabicName.clear();
    price.clear();
    id.clear();
    restaurant.clear();
    description.clear();
    isBestOffer.clear();
    isMostPopular.clear();
    isNewProduct.clear();
    creationDate.clear();
    emit(ClearProductId());
  }

// Displaying the UI when Searching on product
  var data;
  Future getListOfProducts(
    BuildContext context, {
    required String? CatId,
    required String? image,
    required String? category,
    required String? restaurantName,
  }) async {
    await Dio()
        .get("$BASEURL/get_products_of_restaurant_by_category/$id/$CatId")
        .then((value) {})
        .catchError((onError) {});
    data = Expanded(
      child: ListView.separated(
          separatorBuilder: ((context, index) {
            return Divider();
          }),
          itemBuilder: (context, index) {
            return ProductClass(
              itemImage: image,
              englishName: EnglishName[index],
              arabicName: ArabicName[index],
              price: price[index],
              id: id[index],
              description: description[index],
              creationDate: creationDate[index],
              restaurant: restaurant[index],
              isBestOffer: isBestOffer[index],
              isMostPopular: isMostPopular[index],
              isNewProduct: isNewProduct[index],
            ).Search(context,
                image: image,
                category: category,
                CatId: CatId,
                restaurantName: restaurantName,
                price: price[index]);
          },
          itemCount: ProductId.length),
    );

    return data;
  }

  List<double> price = [];
  List<int> id = [];
  List<int> restaurant = [];
  List<String> creationDate = [];
  List<String> description = [];
  List<bool> isBestOffer = [];
  List<bool> isMostPopular = [];
  List<bool> isNewProduct = [];
  List<String> restaurant_name = [];
  List<int> category = [];
  List<String> category_name = [];
  List<String> image = [];
  Future<void> SearchOnListOfProduct(
    BuildContext context,
  ) async {
    for (var i = 0; i < ProductId.length; i++) {
      await Dio()
          .get("$BASEURL/get_products_by_id/${ProductId[i]}")
          .then((value) async {
        image.add(value.data["Names"][0]["image"]);
        restaurant_name.add(value.data["Names"][0]["restaurant_name"]);
        category_name.add(value.data["Names"][0]["category_name"]);
        category.add(value.data["Names"][0]["category"]);
        isNewProduct.add(value.data["Names"][0]["New_Products"]);
        isMostPopular.add(value.data["Names"][0]["Most_Popular"]);
        isBestOffer.add(value.data["Names"][0]["Best_Offer"]);
        creationDate.add(value.data["Names"][0]["created"]);
        description.add(value.data["Names"][0]["description"]);
        restaurant.add(value.data["Names"][0]["Restaurant"]);
        id.add(value.data["Names"][0]["id"]);
        price.add(value.data["Names"][0]["price"]);
        EnglishName.add(value.data["Names"][0]["name"]);
        ArabicName.add(value.data["Names"][0]["ArabicName"]);
      }).catchError((e) {
        print("The error is $e");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text("Something error try again later !!"),
          backgroundColor: Colors.red,
        ));
      });
      emit(SearhOnProductSuccessfull());
    }
  }

  List<int> ProductId = [];

  Future GetIdOfProducts(
    BuildContext context, {
    required String? id,
  }) async {
    await Dio()
        .get("$BASEURL/get_products_by_restaurant_id/$id")
        .then((value) async {
      for (var i = 0; i < value.data["Names"].length; i++) {
        if (value.data["Names"][i]["name"]
                .toString()
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            value.data["Names"][i]["ArabicName"]
                .toString()
                .toLowerCase()
                .contains(searchController.text.toLowerCase())) {
          if (value.data["Names"][i]["id"] is int) {
            ProductId.add(value.data["Names"][i]["id"]);
            print(ProductId);
          }
        }
      }
    });
    emit(ProductIdSuccefull());
  }

  Future getCurrentProducts(
    BuildContext context, {
    required String? id,
    required String? CatId,
    required String? image,
    required String? category,
    required String? restaurantName,
  }) async {
    var data;
    await Dio()
        .get("$BASEURL/get_products_of_restaurant_by_category/$id/$CatId")
        .then((value) async {
      data = Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ProductClass(
                itemImage: image,
                englishName: value.data["Names"][index]["name"],
                arabicName: value.data["Names"][index]["ArabicName"],
                price: value.data["Names"][index]["price"],
                id: value.data["Names"][index]["id"],
                description: value.data["Names"][index]["description"],
                creationDate: value.data["Names"][index]["created"],
                restaurant: value.data["Names"][index]["Restaurant"],
                isBestOffer: value.data["Names"][index]["Best_Offer"],
                isMostPopular: value.data["Names"][index]["Most_Popular"],
                isNewProduct: value.data["Names"][index]["New_Products"],
              ).productsOfCategory(context,
                  image: image,
                  category: category,
                  CatId: CatId,
                  restaurantName: restaurantName,
                  price: value.data["Names"][index]["price"]);
            },
            separatorBuilder: ((context, index) {
              return Divider();
            }),
            itemCount: value.data["Names"].length),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text("Something error try again later !!"),
        backgroundColor: Colors.red,
      ));
    });
    return data;
  }
}
