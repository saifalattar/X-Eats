import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
import 'package:xeats/views/Verification/Verification.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
  static AuthCubit get(context) => BlocProvider.of(context);

  //----------------Signin form Variables ------------------------//

  bool isPassword_lpgin = true;
  TextEditingController signin_email = TextEditingController();
  TextEditingController signin_password = TextEditingController();

  //----------------Signup form Variables ------------------------//

  TextEditingController password = TextEditingController();
  TextEditingController signup_confirm_password = TextEditingController();
  bool isPassword_signup = true;
  bool isPassword_confirm_signup = true;

  //---------------Complete Profile Form Variables---------------//

  TextEditingController datecontroller = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController nu_id = TextEditingController();
  String? Value;
  String? ValueTitle;
  String? Gender;
  String? title;

  //---------------Complete Profile Methods-------------//

  void changegender() {
    Gender = Value;
    emit(ChangeGenderState());
  }

  void changetitle() {
    title = ValueTitle;
  }

  Future<void> CreateUser(
    context, {
    String? first_name,
    String? email,
    String? last_name,
    String? PhoneNumber,
    String? password,
    String? title,
    String? school,
    String? nu_id,
  }) async {
    await DioHelper.PostData(data: {
      "password": password,
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "title": title,
      "nu_id": nu_id,
      "school": school,
      "PhoneNumber": PhoneNumber,
    }, url: "create_users_API/")
        .then((value) async {
      SharedPreferences Auth = await SharedPreferences.getInstance();

      Auth.setString("token", value.data['token'])
          .then((value) => NavigateAndRemov(context, Verify()))
          .catchError((error) {
        print(error.toString());
      });
    });
  }

  List<dynamic> user = [];

  Future<void> login(
    context, {
    String? email,
    String? password,
  }) async {
    await DioHelper.PostData(data: {
      "password": password,
      "email": email,
    }, url: "login_users_API/")
        .then((value) async {
      user = value.data['Names'];
      print(user);
    });
  }

  //-------------Show password method-------------------//

  void changepasswordVisablityLogin() {
    isPassword_lpgin = !isPassword_lpgin;
    emit(ShowPassState());
  }

  void changepasswordVisablitySignup() {
    isPassword_signup = !isPassword_signup;
    emit(ShowPassState());
  }

  void changepasswordVisablityConfirmSignup() {
    isPassword_confirm_signup = !isPassword_confirm_signup;
    emit(ShowPassState());
  }
}
