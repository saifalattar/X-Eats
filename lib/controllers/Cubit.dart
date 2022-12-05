// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';

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

  void changepasswordVisablity() {
    isPassword = !isPassword;
    emit(SuperXeatsOff(isPassword));
  }

  void changebottomnavindex(int index) {
    currentindex = index;

    emit(ChangeSuccefully());
  }

  void changepasswordVisablity1() {
    isPassword1 = !isPassword1;
    emit(SuperXeatsOff(isPassword1));
  }



  void showwLabel1() {
    ShowLabel = !ShowLabel;
    emit(ShoowLabel());
  }

  void showwLabel2() {
    ShowLabel2 = !ShowLabel2;
    emit(ShoowLabel());
  }

  void showwLabel3() {
    ShowLabel3 = !ShowLabel3;
    emit(ShoowLabel());
  }

  void showwLabel4() {
    ShowLabel4 = !ShowLabel4;
    emit(ShoowLabel());
  }

  List<dynamic> Search = [];

  void Searchbar(String value) {
    DioHelper.getdata(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'ba69be2f050f4f0ca5aa36c5c9c28420',
      },
    ).then((value) {
      Search = value.data['articles'];
    }).catchError((error) {
      print(error.toString());
    });
  }
}
