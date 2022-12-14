// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  Future init(context) async {
    Xeatscubit.get(context).Email();
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (Xeatscubit.get(context).EmailInforamtion != null) {
        Navigation(context, Layout());
      } else {
        Navigation(context, SignIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage('assets/Images/First.png'),
                    width: 300,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SpinKitRotatingCircle(
                    color: Colors.blue,
                    size: 50.0,
                  )
                ],
              ),
            ),
          );
        });
  }
}
