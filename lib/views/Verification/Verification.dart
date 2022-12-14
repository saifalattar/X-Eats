import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/States.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Auth%20Components/Otp.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/LoginSuccess/loginSuccess.dart';

import '../../controllers/Cubit.dart';

class Verify extends StatelessWidget {
  Verify({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff0986d3),
            elevation: 0,
          ),
          backgroundColor: Color(0xff0986d3),
          body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.r),
                    topLeft: Radius.circular(70.r))),
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
                        Center(
                          child: Image(
                            image: AssetImage('assets/Images/password.png'),
                            width: width / 2,
                            height: width / 2,
                          ),
                        ),
                        Center(
                          child: Text("Verification Code",
                              style: TextStyle(
                                fontFamily: 'UberMoveTextBold',
                                fontSize: 30.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 9, 134, 211),
                              )),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Center(
                          child: Text(
                            'Please type the verification code sent to your e-mail',
                            style: TextStyle(fontSize: 15.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: OTP(
                                  context: context,
                                  action: TextInputAction.next,
                                  controller: Xeatscubit.get(context).XeatOtp1,
                                  type: TextInputType.phone,
                                ),
                              ),
                              SizedBox(
                                width: 26.w,
                              ),
                              Expanded(
                                child: OTP(
                                  context: context,
                                  action: TextInputAction.next,
                                  controller: Xeatscubit.get(context).XeatOtp2,
                                  type: TextInputType.phone,
                                ),
                              ),
                              SizedBox(
                                width: 26.w,
                              ),
                              Expanded(
                                child: OTP(
                                  context: context,
                                  action: TextInputAction.next,
                                  controller: Xeatscubit.get(context).XeatOtp3,
                                  type: TextInputType.phone,
                                ),
                              ),
                              SizedBox(
                                width: 26.w,
                              ),
                              Expanded(
                                child: OTP(
                                  context: context,
                                  action: TextInputAction.done,
                                  controller: Xeatscubit.get(context).XeatOtp4,
                                  type: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Resend Code',
                              style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.w600,
                                  textStyle: TextStyle(color: Colors.blue)),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultButton(
                          text: 'Verify now',
                          function: () {
                            Navigation(context, LoginSuccess());
                          },
                        ),
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
