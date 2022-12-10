// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeats/controllers/AuthCubit/States.dart';
import 'package:xeats/controllers/AuthCubit/cubit.dart';

import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/SignUp/SignUp.dart';

class LoginSuccess extends StatelessWidget {
  LoginSuccess({super.key});

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
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                          fontFamily: 'UberMoveTextBold',
                          fontSize: 25.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 9, 134, 211),
                        ),
                      ),
                      Center(
                        child: Image(
                          image: AssetImage('assets/Images/01.webp'),
                          width: width,
                          height: width,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Welcome To X-Eats',
                          style: TextStyle(
                            fontFamily: 'UberMoveTextBold',
                            fontSize: 25.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            'We are so glad to see you using the First Version of our app, hope you enjoy it & we are looking forward to have many updates & have all your love & support support & always remember.. EAT MORE, PAY LESS.',
                            style: TextStyle(
                                fontFamily: 'UberMoveTextBold',
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage('assets/Images/First.png'),
                                  width: width / 3,
                                  height: width / 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    'X-Eats Team',
                                    style: TextStyle(
                                        fontFamily: 'UberMoveTextBold',
                                        fontSize: 14.0.sp,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 9, 134, 211)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Let's GO !",
                    style: TextStyle(
                        fontFamily: 'UberMoveTextBold',
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 9, 134, 211)),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigation(context, Xeatscubit().Screens[0]);
                },
                backgroundColor: Colors.black,
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        );
      },
    );
  }
}
