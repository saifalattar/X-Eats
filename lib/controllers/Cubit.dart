import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/ItemClass.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';
import 'package:xeats/views/ResturantsMenu/categoryView.dart';

class Xeatscubit extends Cubit<XeatsStates> {
  Xeatscubit() : super(SuperXeats());
  bool isPassword = true;
  bool isPassword1 = true;
  var Password = TextEditingController();
  var Password1 = TextEditingController();
  var XeatOtp1 = TextEditingController();
  var XeatOtp2 = TextEditingController();
  var XeatOtp3 = TextEditingController();
  var XeatOtp4 = TextEditingController();
  var XeatOtp5 = TextEditingController();
  var email = TextEditingController();
  var Firstname = TextEditingController();
  var Lastname = TextEditingController();
  var Phone = TextEditingController();
  var datecontroller = TextEditingController();
  bool ShowLabel = true;
  bool ShowLabel2 = true;
  bool ShowLabel3 = true;
  bool ShowLabel4 = true;
  int currentindex = 0;
  List<Widget> Screens = [
    HomePage(),
    Resturantss(),
    Profile(),
  ];

  ////////////////////////////////////////////////

  ///////////////////////////////////////////////

  // user data retrieved after logging in

  int? userId = 224, cartId = 209; // for testing 224, 209

  //////////////////////////////////////
  ///// Base url ///////////
  String BASEURL = "https://x-eats.com";

  List<BottomNavigationBarItem> bottomitems = const [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(
        Icons.home_outlined,
        color: Color.fromARGB(193, 0, 0, 0),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(
          Icons.restaurant,
          color: Colors.black,
        ),
        label: 'Resturants'),
    BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        label: 'Profile'),
  ];

  static Xeatscubit get(context) => BlocProvider.of(context);

  void changebottomnavindex(int index) {
    currentindex = index;

    emit(ChangeSuccefully());
  }

  void changepasswordVisablity1() {
    isPassword1 = !isPassword1;
    emit(SuperXeatsOff(isPassword1));
  }

  static List<dynamic> Get_Category = [];
  void GetCategory() {
    DioHelper.getdata(url: 'get_category/', query: {}).then((value) {
      Get_Products = value.data['Names'];

      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  static List<dynamic> Get_Products = [];

  void GetProducts() {
    DioHelper.getdata(url: 'get_products/', query: {}).then((value) {
      Get_Products = value.data['Names'];
      print(Get_Products);
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  static List<dynamic> MostSold = [];
  void GetMostSoldProducts() {
    DioHelper.getdata(url: 'get_products_mostSold_products/', query: {})
        .then((value) {
      MostSold = value.data['Names'];
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  static List<dynamic> getimages = [];

  void getPoster() {
    DioHelper.getdata(url: 'get_poster/', query: {}).then((value) {
      getimages = value.data['Names'];
      print(getimages);
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  static List<dynamic> users = [];

  get_users() async {
    DioHelper.getdata(
      url: 'get_user_by_id/',
      query: {},
    ).then((value) {
      users = value.data['Names'];
      print(users);
    }).catchError((error) {
      print(error);
    });
  }

  static List<dynamic> ResturantsList = [];

  void GetResturants() async {
    emit(ProductsLoading());
    DioHelper.getdata(
      url: 'get_restaurants/',
      query: {},
    ).then((value) {
      ResturantsList = value.data['Names'];
      emit(ProductsSuccess());
    }).catchError((error) {
      emit(ProductsFail(error.toString()));
    });
  }

  Map k = {
    "user": 115,
    "cart": 113,
    "orderId": 273,
    "ordered": true,
    "paid": false,
    "product": 165,
    "price": 100.0,
    "quantity": 1,
    "created": "2022-12-08T13:25:07.395263+02:00",
    "totalOrderItemPrice": 100,
    "Restaurant": 6,
    "order_shift": "1:00 PM"
  };

  // function to add item to the cart
  void addToCart(
      {String? productId,
      String? quantity,
      String? price,
      String? totalPrice,
      String? restaurantId,
      String? timeShift}) async {
    await Dio()
        .post("$BASEURL/get_cartItems/",
            data: {
              "user": userId,
              "cart": cartId,
              "product": productId,
              "price": price,
              "quantity": quantity,
              "totalOrderItemPrice": totalPrice,
              "Restaurant": restaurantId,
              "order_shift": timeShift
            },
            options: Options(
                headers: {'Content-type': 'application/json; charset=UTF-8'}))
        .then((value) async {
      await Dio()
          .put("$BASEURL/get_carts/", data: {
            "id": cartId.toString(),
            "total_price": FoodItem.getSubtotal().toString(),
            "total_after_delivery":
                (FoodItem.deliveryFee + FoodItem.getSubtotal()).toString(),
            "user": userId.toString()
          })
          .then((value) => print("Added to cart "))
          .catchError((onError) {
            print("Errooooooooooooor");
            print(onError.response.data);
          });
    }).catchError((onError) => print(onError));
  }

  // function to get the food data(image, name in arabic and english, price , category. ...) by (productId)
  void getProductById({required String id}) async {
    await Dio()
        .get("$BASEURL/get_products/$id")
        .then((value) => print(value.data))
        .catchError((onError) => print(onError));
  }

  Future<List<Widget>> getCartItems() async {
    FoodItem.CartItems.clear();
    List<Map> items = [];
    Map itemImages = {};
    Map resImages = {};
    await Dio().get("$BASEURL/get_cartItems/").then((value) async {
      for (var i in value.data["Names"]) {
        if (i["user"] == userId &&
            i["cart"] == cartId &&
            i["ordered"] == false) {
          items.add({"product": i["product"], "qty": i["quantity"]});
        }
      }
      print(items);
      for (var i in items) {
        FoodItem? theItem;
        await Dio()
            .get("$BASEURL/get_products/${i["product"]}")
            .then((value) async {
          theItem = FoodItem(
              id: i["product"],
              quantity: i["qty"],
              englishName: value.data["Names"][0]["name"],
              arabicName: value.data["Names"][0]["ArabicName"],
              productSlug: value.data["Names"][0]["productslug"],
              restaurant: value.data["Names"][0]["Restaurant"],
              description: value.data["Names"][0]["description"],
              price: double.parse(value.data["Names"][0]["price"].toString()) *
                  double.parse(i["qty"].toString()),
              category: value.data["Names"][0]["category"],
              isBestOffer: value.data["Names"][0]["Best_Offer"],
              isMostPopular: value.data["Names"][0]["Most_Popular"],
              isNewProduct: value.data["Names"][0]["New_Products"],
              creationDate: value.data["Names"][0]["created"]);
          if (!itemImages.containsKey(value.data["Names"][0]["category"])) {
            print("1111");
            await Dio()
                .get(
                    "$BASEURL/get_category/${value.data["Names"][0]["category"]}")
                .then((v2) {
              theItem!.itemImage = v2.data["Names"][0]["image"];
              itemImages.addAll({
                value.data["Names"][0]["category"]: v2.data["Names"][0]["image"]
              });
            });
          } else {
            theItem!.itemImage = itemImages[value.data["Names"][0]["category"]];
          }

          if (!resImages.containsKey(value.data["Names"][0]["Restaurant"])) {
            print(2222);
            await Dio()
                .get(
                    "$BASEURL/get_restaurants/${value.data["Names"][0]["Restaurant"]}")
                .then((v3) {
              theItem!.restaurantImage = v3.data["Names"][0]["image"];
              resImages.addAll({
                value.data["Names"][0]["Restaurant"]: v3.data["Names"][0]
                    ["image"]
              });
            });
          } else {
            theItem!.restaurantImage =
                resImages[value.data["Names"][0]["Restaurant"]];
          }
        });
        FoodItem.CartItems.add(theItem!);
      }
    }).catchError((onError) => print(onError));
    return FoodItem.CartItems;
  }

  // a function to confirm and checkout
  void confirmOrder() async {
    await Dio()
        .post("$BASEURL/get_orders/", data: {
          "user": userId,
          "total_price_after_delivery":
              FoodItem.deliveryFee + FoodItem.getSubtotal(),
          "paid": false,
          "totalPrice": FoodItem.getSubtotal(),
          "cart": cartId
        })
        .then((value) => print(value))
        .catchError((onError) => print(onError));
  }

  Future<Widget> getCurrentCategories(BuildContext context,
      {required String? restaurantId}) async {
    Widget result = Container();
    await Dio()
        .get("$BASEURL/get_category_of_restaurants/$restaurantId")
        .then((value) {
      result = ListView.separated(
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                Navigation(
                    context,
                    CategoriesView(
                        restaurantId,
                        value.data["Names"][index]["id"].toString(),
                        value.data["Names"][index]["display_name"].toString()));
              },
              child: SizedBox(
                height: 100,
                child: Card(
                  child: Center(
                      child: Text(
                          "${value.data["Names"][index]["display_name"]}")),
                ),
              ),
            );
          }),
          separatorBuilder: ((context, index) {
            return SizedBox(
              height: 20,
            );
          }),
          itemCount: value.data["Names"].length);
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something error try again later !!"),
        backgroundColor: Colors.red,
      ));
    });
    return result;
  }

  Future getCurrentProducts(BuildContext context,
      {required String? id, required String? CatId}) async {
    var data;
    await Dio()
        .get("$BASEURL/get_products_of_restaurant_by_category/$id/$CatId")
        .then((value) async {
      data = ListView.separated(
          itemBuilder: (context, index) {
            return FoodItem(
              englishName: value.data["Names"][index]["name"],
              arabicName: value.data["Names"][index]["ArabicName"],
              price: value.data["Names"][index]["price"],
              id: value.data["Names"][index]["category"],
              description: value.data["Names"][index]["description"],
              creationDate: value.data["Names"][index]["created"],
              restaurant: value.data["Names"][index]["Restaurant"],
              category: value.data["Names"][index]["category"],
              isBestOffer: value.data["Names"][index]["Best_Offer"],
              isMostPopular: value.data["Names"][index]["Most_Popular"],
              isNewProduct: value.data["Names"][index]["New_Products"],
            ).itemCard(context);
          },
          separatorBuilder: ((context, index) {
            return const SizedBox(
              height: 20,
            );
          }),
          itemCount: value.data["Names"].length);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something error try again later !!"),
        backgroundColor: Colors.red,
      ));
    });
    return data;
  }
}
