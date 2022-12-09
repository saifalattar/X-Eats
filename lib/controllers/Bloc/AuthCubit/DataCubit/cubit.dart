import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Bloc/AuthCubit/DataCubit/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Verification/Verification.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
  static AuthCubit get(context) => BlocProvider.of(context);

  //----------------Signin form Variables ------------------------//
  GlobalKey<FormState> signin_formkey = GlobalKey<FormState>();
  bool isPassword_lpgin = true;
  TextEditingController signin_email = TextEditingController();
  TextEditingController signin_password = TextEditingController();
  //----------------Signup form Variables ------------------------//
  GlobalKey<FormState> signup_formkey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController signup_confirm_password = TextEditingController();
  bool isPassword_signup = true;
  bool isPassword_confirm_signup = true;
  //---------------Complete Profile Form Variables---------------//
  GlobalKey<FormState> complee_profile_formkey = GlobalKey<FormState>();
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

  Future<void> CreateUser(context,
      {String? first_name,
      String? email,
      String? last_name,
      String? PhoneNumber,
      String? password,
      String? title,
      String? school,
      String? nu_id}) async {
    await DioHelper.PostData(data: {
      "password": password,
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "title": title,
      "nu_id": nu_id,
      "school": school,
      "PhoneNumber": PhoneNumber,
    }, url: "get_users/")
        .then((value) async {
      SharedPreferences Auth = await SharedPreferences.getInstance();
      Auth.setString("token", value.data['token'])
          .then((value) => NavigateAndRemov(context, Verify()))
          .catchError((error) {
        print(error.toString());
      });
    });
  }

  void Validate_Cpmplete_profile(BuildContext context) {
    if (complee_profile_formkey.currentState!.validate()) {
      CreateUser(context,
          email: email.text,
          first_name: first_name.text,
          last_name: last_name.text);
    }
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

  //---------------signin method---------------------//
  void signin(BuildContext context) {
    if (signin_formkey.currentState!.validate()) {
      Navigation(context, Layout());
    }
  }

  void signup(BuildContext context) {
    if (signup_formkey.currentState!.validate()) {
      Navigation(context, Layout());
    }
  }
}
