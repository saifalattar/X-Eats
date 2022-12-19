import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Components/Auth%20Components/ProfileMenu.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/States.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Dio/Cache_Helper.dart';
import 'package:xeats/controllers/States.dart';
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
            var lastname = cubit.LastName;
            var Wallet = cubit.wallet;
            var userId = cubit.idInformation;
            var firstName = cubit.FirstName ?? 'Loading..';

            return SafeArea(
              child: ConditionalBuilder(
                fallback: (context) => Center(child: Loading()),
                condition: Email != null,
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: appBar(context, subtitle: 'Your', title: 'Profile'),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
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
                                  text: "Email: ${cubit.EmailInforamtion}\n",
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
                              ],
                            ),
                          ),
                        ),
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
                                  text: 'Sign Out',
                                  press: () {
                                    cubit.signOut(context);
                                  },
                                  icon: "assets/icons/Log out.svg",
                                )
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
                },
              ),
            );
          }),
    );
  }
}
