// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:xeats/controllers/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/views/Boarding/Boarding.dart';
import 'package:xeats/views/Cart/cart.dart';
import 'package:xeats/views/CheckOut/CheckOut.dart';
import 'package:xeats/views/CompleteProfile/Complete_Profile.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
import 'package:xeats/views/SignUp/SignUp.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Verification/Verification.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => Xeatscubit()
                ..GetProducts()
                ..getCartItems()
                ..getPoster()
                ..GetResturants()
                ..get_users()),
          BlocProvider(
              create: (context) => AuthCubit()
                ..login(context)
                ..CreateUser(context))
        ],
        child: ScreenUtilInit(
          designSize: const Size(415, 900),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'X-EATS',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme:
                    Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              ),
              home: child,
            );
          },
          child: Layout(),
        ));
  }
}
