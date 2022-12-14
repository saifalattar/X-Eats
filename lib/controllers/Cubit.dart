import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/ItemClass.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';
import 'package:xeats/views/CategoryView/categoryView.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

import 'Components/Categories Components/CategoryCard.dart';
import 'Components/Global Components/loading.dart';

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

  // bool ShowLabel = true;
  // bool ShowLabel2 = true;
  // bool ShowLabel3 = true;
  // bool ShowLabel4 = true;

  ////////////////////////////////////////////////

  ///////////////////////////////////////////////

  // user data retrieved after logging in

  static Xeatscubit get(context) => BlocProvider.of(context);

  // int? userId = 1, cartId = 7; // for testing 224, 209

  String BASEURL = "https://www.x-eats.com";

  static List<dynamic> EmailInList = [];

//This Function Will Call when user Sign In Succefuly
  Future<List> getEmail(
    context, {
    // The Function Will Get The email of user and take it as EndPoint to show his information
    String? email,
  }) async {
    await DioHelper.getdata(url: "get_user_by_id/$email", query: {})
        .then((value) async {
      //EmailInformationList
      EmailInList = value.data['Names'];
      print(EmailInList[0]);
      SharedPreferences userInf = await SharedPreferences.getInstance();
      userInf.setString('EmailInf', EmailInList[0]['email']);
      userInf.setInt("Id", EmailInList[0]['id']);
      emit(SuccessGetInformation());
    }).catchError((onError) {
      emit(FailgetInformation());
      print(FailgetInformation());
    });
    return EmailInList;
  }

//-------------------- Function Separated to get his email if his email null then it will go to login if not then it will go to home page
  String? EmailInforamtion;
  int? idInformation;
  int? cartID;

  Future<void> Email() async {
    SharedPreferences User = await SharedPreferences.getInstance();
    EmailInforamtion = User.getString('EmailInf');
    idInformation = User.getInt('Id');
    emit(SuccessEmailProfile());
    print(SuccessEmailProfile());
  }

  void signOut(context) async {
    SharedPreferences userInformation = await SharedPreferences.getInstance();
    userInformation.clear();
    Navigation(context, SignIn());
  }

  static List<dynamic> cartList = [];
  Future<List> getCart() async {
    await DioHelper.getdata(url: "get_carts_by_id/admin@admin.com", query: {})
        .then((value) async {
      //EmailInformationList
      cartList = value.data['Names'];
      print(cartList);
      SharedPreferences userCartID = await SharedPreferences.getInstance();
      userCartID.setInt("cartIDSaved", cartList[0]['id']);
      emit(SuccessGetInformation());
    }).catchError((onError) {
      emit(FailgetInformation());
      print(FailgetInformation());
    });
    return cartList;
  }

//-------------------- Function Separated to get his email if his email null then it will go to login if not then it will go to home page

  Future<void> CartData() async {
    SharedPreferences cart = await SharedPreferences.getInstance();
    cartID = cart.getInt('cartIDSaved');
    emit(SuccessEmailProfile());
    print(SuccessEmailProfile());
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

  static List<dynamic> new_products = [];
  void NewProducts() {
    DioHelper.getdata(url: 'get_products_new_products/', query: {})
        .then((value) {
      new_products = value.data['Names'];
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
    });
  }

  static List<dynamic> getposters = [];
  void getPoster() {
    DioHelper.getdata(url: 'get_poster/', query: {}).then((value) {
      getposters = value.data['Names'];
      print(getposters);
      emit(ProductsSuccess());
    }).catchError((error) {
      print(ProductsFail(error.toString()));
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

  // function to add item to the cart
  void addToCart(
      {int? id,
      String? productId,
      String? quantity,
      String? price,
      String? totalPrice,
      String? restaurantId,
      String? timeShift}) async {
    print(productId);
    await Dio()
        .post("$BASEURL/get_cartItems/",
            data: {
              "user": id,
              "cart": 7,
              "product": productId,
              "price": price,
              "quantity": quantity,
              "totalOrderItemPrice": totalPrice,
              "Restaurant": restaurantId,
              "order_shift": "25"
            },
            options: Options(
                headers: {'Content-type': 'application/json; charset=UTF-8'}))
        .then((value) async {
      await Dio()
          .post("$BASEURL/get_carts/", data: {
            "id": 7.toString(),
            "total_price": FoodItem.getSubtotal().toString(),
            "total_after_delivery":
                (FoodItem.deliveryFee + FoodItem.getSubtotal()).toString(),
            "user": id.toString()
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

  Future<List<Widget>> getCartItems(
    context, {
    // The Function Will Get The email of user and take it as EndPoint to show his information
    int? users,
  }) async {
    FoodItem.CartItems.clear();
    List<Map> items = [];
    Map itemImages = {};

    await Dio().get("$BASEURL/get_cartItems/").then((value) async {
      for (var i in value.data["Names"]) {
        if (i["user"] == users && i["cart"] == 7 && i["ordered"] == false) {
          items.add({
            "product": i["product"],
            "qty": i["quantity"],
            "cartItemID": i["id"]
          });
        }
      }
      print(email);
      for (var i in items) {
        FoodItem? theItem;
        await Dio()
            .get("$BASEURL/get_products_by_id/${i["product"]}")
            .then((value) async {
          print(i["product"]);

          theItem = FoodItem(
              id: i["product"],
              quantity: i["qty"],
              cartItemId: i["cartItemID"].toString(),
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
          print(value.data);
          if (!itemImages.containsKey(value.data["Names"][0]["category"])) {
            print("1111");
            await Dio()
                .get(
                    "$BASEURL/get_category_by_id/${value.data["Names"][0]["category"]}")
                .then((v2) {
              print("2222");
              theItem!.itemImage = v2.data["Names"][0]["image"];
              itemImages.addAll({
                value.data["Names"][0]["category"]: v2.data["Names"][0]["image"]
              });
            });
          } else {
            theItem!.itemImage = itemImages[value.data["Names"][0]["category"]];
          }
        }).catchError((onError) {
          print(onError);
        });
        print("caaaaaaaaaaaaaaaaaaaaaaaaaaaaart");

        print("caaaaaaaaaaaaaaaaaaaaaaaaaaaaart");
        FoodItem.CartItems.add(theItem!);
      }
    }).catchError((onError) => print(onError));
    return FoodItem.CartItems;
  }

  // a function to confirm and checkout
  void confirmOrder(
    context, {
    int? id,
  }) async {
    await Dio()
        .post("$BASEURL/get_orders/", data: {
          "user": id,
          "total_price_after_delivery":
              FoodItem.deliveryFee + FoodItem.getSubtotal(),
          "paid": false,
          "totalPrice": FoodItem.getSubtotal(),
          "cart": 7
        })
        .then((value) => print(value))
        .catchError((onError) => print(onError));
  }

  void deleteCartItem(BuildContext context, String cartItemId) async {
    await Dio().delete("$BASEURL/delete_cartItems/$cartItemId").then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(
                Icons.done,
                color: Colors.white,
              ),
              Text(
                "Item deleted successfully",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )));
    }).catchError((onError) {
      print(onError);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              Text(
                "Something error happened try again !!",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )));
    });
  }

  Future<Widget> getCurrentCategories(
    BuildContext context, {
    required String? restaurantId,
  }) async {
    Widget result = Container();
    await Dio()
        .get("$BASEURL/get_category_of_restaurants/$restaurantId")
        .then((value) {
      result = ListView.separated(
          itemBuilder: ((context, index) {
            if (value.data["Names"][index] == null) {
              return Loading();
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: CategoryCard(
                  press: () {
                    Navigation(
                      context,
                      CategoriesView(
                        restaurantId,
                        value.data["Names"][index]["id"].toString(),
                        value.data["Names"][index]["display_name"].toString(),
                      ),
                    );
                  },
                  category: value.data["Names"][index]['display_name'],
                  image: DioHelper.dio!.options.baseUrl +
                      value.data["Names"][index]['image'],
                  description: "",
                ),
              );
            }
            // "${value.data["Names"][index]["display_name"]}")),
          }),
          separatorBuilder: ((context, index) {
            return SizedBox(
              child: Divider(),
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
              id: value.data["Names"][index]["id"],
              description: value.data["Names"][index]["description"],
              creationDate: value.data["Names"][index]["created"],
              restaurant: value.data["Names"][index]["Restaurant"],
              category: value.data["Names"][index]["category"],
              isBestOffer: value.data["Names"][index]["Best_Offer"],
              isMostPopular: value.data["Names"][index]["Most_Popular"],
              isNewProduct: value.data["Names"][index]["New_Products"],
            ).productsOfCategory(context);
          },
          separatorBuilder: ((context, index) {
            return Divider();
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
