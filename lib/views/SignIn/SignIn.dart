// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeats/controllers/Bloc/AuthCubit/DataCubit/States.dart';
import 'package:xeats/controllers/Bloc/AuthCubit/DataCubit/cubit.dart';

import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/SignUp/SignUp.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xff0986d3),
          body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(150.r))),
            child: SafeArea(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: cubit.signin_formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",
                            style: TextStyle(
                              fontFamily: 'UberMoveTextBold',
                              fontSize: 25.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 9, 134, 211),
                            )),
                        Center(
                          child: Image(
                            image: AssetImage('assets/Images/First.png'),
                            width: width / 2,
                            height: width / 2,
                          ),
                        ),
                        SocialAuth(),
                        defultformfield(
                            prefix: Icons.email_outlined,
                            controller: cubit.signin_email,
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your Email'
                                : null),
                        SizedBox(
                          height: 15.h,
                        ),
                        defultformfield(
                            prefix: Icons.lock_open,
                            controller: cubit.signin_password,
                            label: 'Password',
                            suffix: cubit.isPassword_lpgin
                                ? Icons.visibility
                                : Icons.visibility_off,
                            type: TextInputType.visiblePassword,
                            isPassword: cubit.isPassword_lpgin,
                            suffixpressed: () {
                              cubit.changepasswordVisablityLogin();
                            },
                            validator: (value) => value!.isEmpty
                                ? 'Please Enter your Password'
                                : null),
                        SizedBox(
                          height: 15.h,
                        ),
                        defultbutton(
                            function: (() {
                              cubit.signin(context);
                            }),
                            text: 'Sign In'),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavigateAndRemov(context, Signup());
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 15.sp),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
