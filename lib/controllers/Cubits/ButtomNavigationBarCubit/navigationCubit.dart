import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/ItemClass.dart';
import 'package:xeats/controllers/Cubits/ButtomNavigationBarCubit/NavStates.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';
import 'package:xeats/views/CategoryView/categoryView.dart';

class NavBarCubitcubit extends Cubit<NavBarCubitStates> {
  NavBarCubitcubit() : super(SuperNavBarCubitStates());
  bool isPassword = true;
  bool isPassword1 = true;
  // var Password = TextEditingController();
  // var Password1 = TextEditingController();
  var XeatOtp1 = TextEditingController();
  var XeatOtp2 = TextEditingController();
  var XeatOtp3 = TextEditingController();
  var XeatOtp4 = TextEditingController();
  var XeatOtp5 = TextEditingController();
  var email = TextEditingController();
  var Firstname = TextEditingController();
  // var Lastname = TextEditingController();
  // var Phone = TextEditingController();
  // var datecontroller = TextEditingController();

  // bool ShowLabel = true;
  // bool ShowLabel2 = true;
  // bool ShowLabel3 = true;
  // bool ShowLabel4 = true;

  int currentindex = 0;
  List<Widget> Screens = [
    HomePage(),
    Resturantss(),
    Profile(),
  ];

  ////////////////////////////////////////////////

  ///////////////////////////////////////////////

  // user data retrieved after logging in

  int? userId = 191, cartId = 189; // for testing 224, 209

  //////////////////////////////////////
  ///// Base url ///////////
  String BASEURL = "https://www.x-eats.com";

  static NavBarCubitcubit get(context) => BlocProvider.of(context);

  void changebottomnavindex(int index) {
    currentindex = index;

    emit(ChangeSuccefully());
  }

  List<BottomNavigationBarItem> bottomitems = const [
    BottomNavigationBarItem(
      backgroundColor: Color.fromRGBO(4, 137, 204, 1),
      icon: Icon(
        Icons.home_filled,
        color: Colors.black,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        backgroundColor: Color.fromRGBO(4, 137, 204, 1),
        icon: Icon(
          Icons.restaurant,
          color: Colors.black,
        ),
        label: 'Resturants'),
    BottomNavigationBarItem(
        backgroundColor: Color.fromRGBO(4, 137, 204, 1),
        icon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        label: 'Profile'),
  ];
}
