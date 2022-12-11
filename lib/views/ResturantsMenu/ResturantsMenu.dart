import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/TopPage.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

class ResturantsMenu extends StatelessWidget {
  ResturantsMenu({super.key, required this.data});
  var data;

  String title1 = "Shawrma Frakh";
  String title2 = "Meals";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(width);
    print(height);
    return BlocProvider(
      create: (context) => Xeatscubit(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Xeatscubit.get(context);
          return DefaultTabController(
            length: 5,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      SafeArea(child: TopPage()),
                      // Container(
                      //   width: width,
                      //   height: height / 5,
                      //   decoration: BoxDecoration(
                      //       color: Colors.blue,
                      //       borderRadius: BorderRadius.circular(12)),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(35.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Discover',
                      //           style: GoogleFonts.kanit(
                      //               fontWeight: FontWeight.bold, fontSize: 35),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: height / 6.3,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      height: height / 5,
                                      width: width / 2.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.amber,
                                          border: Border.all(
                                              width: 20, color: Colors.white)),
                                      child: Image(
                                        image: NetworkImage(
                                            DioHelper.dio!.options.baseUrl +
                                                data['image']),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 45,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: height / 7.56),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  data['Name'],
                                  style: GoogleFonts.kanit(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: width / 7,
                                    height: height / 13,
                                    child: const Image(
                                        image: AssetImage(
                                      'assets/Images/First.png',
                                    )),
                                  ),
                                  SizedBox(
                                    width: width / 72,
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    'X-Eats Delivery',
                                    style: GoogleFonts.kanit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ]),
                    SizedBox(
                      height: height / 75.6,
                    ),
                    SizedBox(
                      height: height / 21.7,
                      width: width,
                      child: TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Text(
                              "Shawrma Frakh",
                              style: GoogleFonts.kanit(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Tab(
                              child: Text(
                            "Meals",
                            style: GoogleFonts.kanit(
                              color: Colors.black,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Meals",
                            style: GoogleFonts.kanit(
                              color: Colors.black,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Meals",
                            style: GoogleFonts.kanit(
                              color: Colors.black,
                            ),
                          )),
                          Tab(
                              child: Text(
                            "Meals",
                            style: GoogleFonts.kanit(
                              color: Colors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 37.8,
                    ),
                    Container(
                      height: height / 2.3,
                      width: width,
                      child: TabBarView(children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/Shawrma.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Shawrma Frakh",
                                          style:
                                              GoogleFonts.kanit(fontSize: 20),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        'EGP:35.00',
                                        style: GoogleFonts.kanit(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width / 3,
                                  height: height / 6.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/Shawrma.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: width / 18,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: height / 6.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Shawrma Frakh",
                                            style:
                                                GoogleFonts.kanit(fontSize: 20),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          'EGP:35.00',
                                          style: GoogleFonts.kanit(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width / 3,
                                  height: height / 6.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/Shawrma.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: width / 18,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: height / 6.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Shawrma Frakh",
                                            style:
                                                GoogleFonts.kanit(fontSize: 20),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          'EGP:35.00',
                                          style: GoogleFonts.kanit(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width / 3,
                                  height: height / 6.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/Shawrma.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: width / 18,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: height / 6.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Shawrma Frakh",
                                            style:
                                                GoogleFonts.kanit(fontSize: 20),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          'EGP:35.00',
                                          style: GoogleFonts.kanit(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width / 3,
                                  height: height / 6.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/Shawrma.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: width / 18,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: height / 6.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Shawrma Frakh",
                                            style:
                                                GoogleFonts.kanit(fontSize: 20),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          'EGP:35.00',
                                          style: GoogleFonts.kanit(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: GoogleFonts.kanit(),
                backgroundColor: Colors.white,
                items: cubit.bottomitems,
                currentIndex: 1,
                onTap: (index) {
                  if (index == 1) {
                    Navigator.pop(context);
                  } else if (index == 0) {
                    Navigation(context, Layout());
                  } else {
                    Navigation(context, Layout());
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
