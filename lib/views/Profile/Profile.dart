import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Components/Auth%20Components/ProfileMenu.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/States.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Dio/Cache_Helper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
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
            var Email = cubit.EmailInforamtion;
            var userId = cubit.idInformation;

            return SafeArea(
              child: FutureBuilder(
                future: cubit.getEmail(
                  context,
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.hasData) {
                    return Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   width: double.infinity,
                          //   margin: EdgeInsets.all(20),
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: 20.h,
                          //     vertical: 15.w,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Text.rich(
                          //     TextSpan(
                          //       style: TextStyle(color: Colors.black),
                          //       children: [
                          //         TextSpan(
                          //           text:
                          //               "Name: ${snapshot.data[0]['FirstName']} ${snapshot.data[0]['LastName']} \n",
                          //           style: TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.lightBlue),
                          //         ),
                          //         TextSpan(
                          //           text:
                          //               "Email: ${snapshot.data[0]['email']}\n",
                          //           style: TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.lightBlue),
                          //         ),
                          //         TextSpan(
                          //           text:
                          //               "Wallet: ${snapshot.data[0]['wallet']} \n",
                          //           style: TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.lightBlue),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  // UserDetails(),
                                  SizedBox(height: 20),
                                  ProfileMenu(
                                    text: "My Orders",
                                    icon: "assets/icons/receipt.svg",
                                    press: () {},
                                  ),
                                  ProfileMenu(
                                    text: "Log Out",
                                    icon: "assets/icons/Log out.svg",
                                    press: () {
                                      cubit.signOut(context);
                                      // Navigation(context, SignIn());
                                    },
                                  ),
                                ],
                              ),

                              // Text(
                              //     "The Name Of User is: ${snapshot.data[0]['email']}"),
                              // SizedBox(
                              //   height: 50,
                              // ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       cubit.signOut(context);
                              //     },
                              //     child: Text('SignOut'))
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(child: Loading());
                },
              ),
            );
          }),
    );
  }
}
