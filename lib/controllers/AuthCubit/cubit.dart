import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/AuthCubit/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/HomePage/HomePage.dart';

import '../../views/Verification/Verification.dart';

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
  TextEditingController signup_password = TextEditingController();
  TextEditingController signup_confirm_password = TextEditingController();
  bool isPassword_signup = true;
  bool isPassword_confirm_signup = true;
  //---------------Complete Profile Form Variables---------------//
  GlobalKey<FormState> complee_profile_formkey = GlobalKey<FormState>();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController signup_email = TextEditingController();
  TextEditingController Firstname = TextEditingController();
  TextEditingController Lastname = TextEditingController();
  String? Value;
  var Gender;
  //---------------Complete Profile Methods-------------//
  void changegender() {
    Gender = Value;
  }
  void Validate_Cpmplete_profile(BuildContext context){
      if (complee_profile_formkey.currentState!.validate()) {
        Navigation(context, Verify());
      }
  }
  //-------------Show password method-------------------//
  void changepasswordVisablityLogin() {
    isPassword_lpgin=!isPassword_lpgin;
    emit(ShowPassState());
  }
  void changepasswordVisablitySignup() {
    isPassword_signup=!isPassword_signup;
    emit(ShowPassState());
  }
  void changepasswordVisablityConfirmSignup() {
    isPassword_signup=!isPassword_signup;
    emit(ShowPassState());
  }
  //---------------signin method---------------------//
void signin(BuildContext context){
    if(signin_formkey.currentState!.validate()){
      Navigation(context, HomePage());
    }
}

}