import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Categories%20Components/CategoryCard.dart';
import 'package:xeats/controllers/Components/General%20Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Cubits/RestauratsCubit/RestaurantsStates.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/views/CategoryView/categoryView.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';

class RestuarantsCubit extends Cubit<RestuarantsStates> {
  RestuarantsCubit() : super(SuperRestuarantsStates());
  static RestuarantsCubit get(context) => BlocProvider.of(context);

  String BASEURL = "https://www.x-eats.com";
//--------- Get The All Resturants Inside The resturants Menu Widget --------/////////////
  Future<Widget> getRestaurantCategories(
    BuildContext context, {
    required String? restaurantId,
    required String? image,
    required String? restaurantName,
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
                          category: value.data["Names"][index]['display_name'],
                          categoryId:
                              value.data["Names"][index]['id'].toString(),
                          image: value.data["Names"][index]["image"],
                          restaurantName: restaurantName,
                          restaurantID: restaurantId),
                    );
                  },
                  category:
                      value.data["Names"][index]['display_name'].toString(),
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Text("Something error try again later !!"),
        backgroundColor: Colors.red,
      ));
    });
    return result;
  }

  TextEditingController searchRestaurantsController = TextEditingController();
  var RestuarantsUI;
  //---------Display The UI result of searching about resturants--------/////
  Future getListOfRestuarants(
    BuildContext context, {
    required List<dynamic>? Restuarantsdata,
    required List<int>? RestaurantId,
    required List<String>? imageOfRestaurant,
    required List<String>? restaurant_nameFromSearching,
  }) async {
    await Dio()
        .get("$BASEURL/get_restaurants")
        .then((value) {})
        .catchError((onError) {});
    RestuarantsUI = Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Restaurants Founded',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (imageOfRestaurant![index] == null) {
              return Loading();
            } else {
              return InkWell(
                onTap: () {
                  Navigation(
                      context,
                      ResturantsMenu(
                        data: Restuarantsdata![index],
                        RestaurantId: RestaurantId[index],
                      ));
                },
                child: Row(children: [
                  Container(
                    height: 130.h,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(74, 158, 158, 158)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Image.network(
                          'https://www.x-eats.com' + imageOfRestaurant[index],
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Loading(),
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(children: [
                            Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                '${restaurant_nameFromSearching![index]}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(' 4.1'),
                            Text(' (100+)')
                          ]),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Icon(Icons.timer_sharp),
                                Text(
                                  ' 45 mins',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Icon(Icons.delivery_dining_outlined),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  'X-Eats Delivery',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            }
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: RestaurantId!.length,
        )
      ],
    );
    return RestuarantsUI;
  }

  List<int> RestaurantId = [];
  List<dynamic> Restuarantsdata = [];
  //---------- Search for the resturants id and take it to put it in search on list function -----///////////
  Future GetIdOfResutarant(
    BuildContext context,
  ) async {
    await Dio().get("$BASEURL/get_restaurants").then((value) async {
      for (var i = 0; i < value.data["Names"].length; i++) {
        if (value.data["Names"][i]["Name"]
            .toString()
            .toLowerCase()
            .contains(searchRestaurantsController.text.toLowerCase())) {
          if (value.data["Names"][i]["id"] is int) {
            RestaurantId.add(value.data["Names"][i]["id"]);
            Restuarantsdata.add(value.data["Names"][i]);
            print(RestaurantId);
          }
        }
      }
    });
    emit(RestaurantIdSuccefull());
  }

//---------- Clear The ID Because Searching more than once
  Future<void> clearRestaurantId() async {
    imageOfRestaurant.clear();
    restaurant_nameFromSearching.clear();
    RestaurantId.clear();
    emit(ClearRestaurantsIdState());
  }

  List<String> restaurant_nameFromSearching = [];

  List<String> imageOfRestaurant = [];
  //----------- Loop For the Id that get it from Searching and put it into a List to display in GetList Function-----/////////
  Future<void> SearchOnListOfRestuarant(
    BuildContext context,
  ) async {
    for (var i = 0; i < RestaurantId.length; i++) {
      await Dio()
          .get("$BASEURL/get_restaurants_by_id/${RestaurantId[i]}")
          .then((value) async {
        imageOfRestaurant.add(value.data["Names"][0]["image"]);
        restaurant_nameFromSearching.add(value.data["Names"][0]["Name"]);
      }).catchError((e) {
        print("The error is $e");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text("Something error try again later !!"),
          backgroundColor: Colors.red,
        ));
      });
      emit(SearhOnRestaurantSuccessfull());
    }
  }

//-------------------- Function Separated to get his email if his email null then it will go to login if not then it will go to home page
  static List<dynamic> ResturantsList = [];
  static Map currentRestaurant = {};
  //------- Displaying All the restaurants on home page
  void GetResturants() async {
    emit(RestaurantsListLoading());
    DioHelper.getdata(
      url: 'get_restaurants/',
      query: {},
    ).then((value) {
      ResturantsList = value.data['Names'];
      emit(RestaurantsListSuccess());
    }).catchError((error) {
      emit(RestaurantsListFail(error.toString()));
    });
  }

//----- Knowing the avalable order restuarants that allowed to user to show
  Future<void> getCurrentAvailableOrderRestauant(context) async {
    await Dio()
        .get(
            "$BASEURL/get_user_cartItems/${AuthCubit.get(context).EmailInforamtion}")
        .then((value) async {
      if (value.data["Names"].length == 0) {
        currentRestaurant = {};
      } else {
        var dataFromApi = await Dio().get(
            "$BASEURL/get_restaurants_by_id/${value.data["Names"][0]["Restaurant"]}");
        currentRestaurant = dataFromApi.data["Names"][0];
      }
    });
  }

  Future<String?> getRestaurantName(String id) async {
    String? restaurantName;
    await Dio().get("$BASEURL/get_restaurants_by_id/$id").then((value) {
      restaurantName = value.data["Names"][0]["Name"].toString();
    }).catchError((onError) {
      restaurantName = onError.response!.statusCode.toString();
    });
    return restaurantName;
  }
}
