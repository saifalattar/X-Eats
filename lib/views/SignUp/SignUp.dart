import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeats/controllers/AuthCubit/States.dart';
import 'package:xeats/controllers/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/controllers/Components/Global%20Components/defaultFormField.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/CompleteProfile/Complete_Profile.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

import '../../controllers/Cubit.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

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
                key: cubit.signup_formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Signup",
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
                        // SocialAuth(),
                        DefaultFormField(
                            isPassword: false,
                            prefix: Icons.email_outlined,
                            controller: cubit.email,
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your Email'
                                : null),
                        SizedBox(
                          height: 15.h,
                        ),
                        DefaultFormField(
                            prefix: Icons.lock_open,
                            controller: cubit.password,
                            label: 'Password',
                            suffix: cubit.isPassword_signup
                                ? Icons.visibility
                                : Icons.visibility_off,
                            type: TextInputType.visiblePassword,
                            isPassword: cubit.isPassword_signup,
                            suffixpressed: () {
                              cubit.changepasswordVisablitySignup();
                            },
                            validator: (value) => value!.isEmpty
                                ? 'Please Enter your Password'
                                : null),
                        SizedBox(
                          height: 15.h,
                        ),
                        DefaultFormField(
                            prefix: Icons.lock_open,
                            controller: cubit.signup_confirm_password,
                            label: 'Confirm Password',
                            suffix: cubit.isPassword_confirm_signup
                                ? Icons.visibility
                                : Icons.visibility_off,
                            type: TextInputType.visiblePassword,
                            isPassword: cubit.isPassword_confirm_signup,
                            suffixpressed: () {
                              cubit.changepasswordVisablityConfirmSignup();
                            },
                            validator: (value) =>
                                value!.isEmpty || value != cubit.password.text
                                    ? 'Password Doesn\'t match'
                                    : null),
                        SizedBox(
                          height: 15.h,
                        ),
                        DefaultButton(
                            function: (() {
                              NavigateAndRemov(context, Complete_Profile());
                            }),
                            text: 'Sign Up'),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              'Already have an account?',
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavigateAndRemov(context, SignIn());
                                },
                                child: Text(
                                  'Sign in',
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
