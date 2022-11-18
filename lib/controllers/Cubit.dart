import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';

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
  String? Value;
  var Gender;
  static Xeatscubit get(context) => BlocProvider.of(context);

  void changepasswordVisablity() {
    isPassword = !isPassword;
    emit(SuperXeatsOff(isPassword));
    print(isPassword);
  }

  void changepasswordVisablity1() {
    isPassword1 = !isPassword1;
    emit(SuperXeatsOff(isPassword1));
    print(isPassword1);
  }

  void changegender() {
    Gender = Value;
  }
}
