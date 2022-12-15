// ignore_for_file: non_constant_identifier_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
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
    Xeatscubit.get(context).GettingUserData();
    Future.delayed(Duration(seconds: 7)).then((value) {
      if (Xeatscubit.get(context).EmailInforamtion != null) {
        Navigation(context, Layout());
      } else {
        Navigation(context, SignIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    init(context);
    return BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Image(
                    image: AssetImage('assets/Images/logo.png'),
                    width: width,
                    height: height / 2,
                  ),
                ),
                SizedBox(
                  height: height / 6,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultTextStyle(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 45,
                        color: Color.fromRGBO(4, 137, 204, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            'Eat More',
                          ),
                          WavyAnimatedText('Pay Less'),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
