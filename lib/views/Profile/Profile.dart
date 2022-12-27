import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Components/Auth%20Components/ProfileMenu.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/States.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubits/ButtomNavigationBarCubit/navigationCubit.dart';
import 'package:xeats/controllers/Dio/Cache_Helper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/Splash%20Screen/Splach%20Screen.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => Xeatscubit()..GettingUserData(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = Xeatscubit.get(context);
            var navcubit = NavBarCubitcubit.get(context);
            return ConditionalBuilder(
              fallback: (context) => Center(child: Loading()),
              condition: cubit.EmailInforamtion != null,
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: appBar(context, subtitle: 'Your', title: 'Profile'),
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height / 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: width / 10),
                                child: Text.rich(
                                  TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: "Name: ${cubit.FirstName}\n",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue),
                                      ),
                                      TextSpan(
                                        text:
                                            "Email: ${cubit.EmailInforamtion}\n",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue),
                                      ),
                                      TextSpan(
                                        text: "Wallet: ${cubit.wallet} \n",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue),
                                      ),
                                      TextSpan(
                                        text:
                                            "Phonenumber: ${cubit.PhoneNumber} \n",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: height / 20),
                                  ProfileMenu(
                                    text: "My Orders",
                                    icon: "assets/icons/receipt.svg",
                                    press: () {},
                                  ),
                                  SizedBox(height: height / 20),
                                  ProfileMenu(
                                    text: 'About Us',
                                    press: () async {
                                      // var url = Uri.parse(
                                      //     "https://www.x-eats.com/about_us");
                                      // if (await canLaunchUrl(url))
                                      //   await launchUrl(url);
                                      // else
                                      //   throw "Could not launch $url";
                                    },
                                    icon: "assets/icons/other.svg",
                                  ),
                                  SizedBox(height: height / 20),
                                  ProfileMenu(
                                    text: 'Sign Out',
                                    press: () {
                                      cubit.signOut(context);
                                    },
                                    icon: "assets/icons/Log out.svg",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    selectedLabelStyle: GoogleFonts.poppins(),
                    backgroundColor: Colors.white,
                    items: navcubit.bottomitems,
                    currentIndex: 2,
                    onTap: (index) {
                      if (index == 2) {
                        Navigator.pop(context);
                      } else if (index == 0) {
                        Navigation(context, Layout());
                      } else {
                        Navigation(context, const Restaurants());
                      }
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
