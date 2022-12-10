import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/DiscountBanner.dart';
import 'package:xeats/controllers/Components/search.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => Xeatscubit(),
        child: BlocConsumer<Xeatscubit, XeatsStates>(
          builder: ((context, state) {
            var cubit = Xeatscubit.get(context);
            return Scaffold(
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height / 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SearchField(),
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          width: width,
                          height: height / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivering to',
                                    style: GoogleFonts.kanit(fontSize: 15),
                                  ),
                                  Text(
                                    'User (Zayed-Nile University)',
                                    style: GoogleFonts.kanit(fontSize: 20),
                                  ),
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: DiscountBanner(),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Resturants',
                                  style: GoogleFonts.kanit(fontSize: 30),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Resturants(
                                        data: "Karm" + "\nElsham",
                                        Colors: Colors.amber,
                                        image: const Image(
                                          image: AssetImage(
                                            'assets/Images/karmElsham.png',
                                          ),
                                        ),
                                        Navigate: () => Navigation(
                                            context, Xeatscubit().Screens[1]),
                                      ),
                                      //
                                      Resturants(
                                          data: "Koshry" + "\n Eltahrir",
                                          Colors: const Color.fromARGB(
                                              255, 5, 95, 9),
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Tahrir.jpg',
                                            ),
                                          ),
                                          Navigate: () => {}),

                                      Resturants(
                                          data: "Salama " + "\nElmotmiz",
                                          Colors: const Color.fromARGB(
                                              255, 109, 17, 11),
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Salama.jpg',
                                            ),
                                          ),
                                          Navigate: () => {}),
                                      Resturants(
                                          data: "Koshry" + "\n Eltahrir",
                                          Colors: const Color.fromARGB(
                                              255, 5, 95, 9),
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Tahrir.jpg',
                                            ),
                                          ),
                                          Navigate: () => {}
                                          // Navigation(context, SignIn()),
                                          ),
                                      Resturants(
                                        data: "Karm" + "\nElsham",
                                        Colors: Colors.amber,
                                        image: const Image(
                                          image: AssetImage(
                                            'assets/Images/karmElsham.png',
                                          ),
                                        ),
                                        Navigate: () => Navigation(
                                            context, ResturantsMenu()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Most Ordered',
                                  style: GoogleFonts.kanit(fontSize: 30),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Resturants(
                                          Weight: width / 2.0,
                                          Height: height / 4.2,
                                          data: "Shawrma Frakh" + "\n",
                                          Colors: Colors.white,
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Shawrma.png',
                                            ),
                                          ),
                                          Navigate: () => {}),
                                      Resturants(
                                          Weight: width / 2.0,
                                          Height: height / 4.2,
                                          data: "Shawrma Frakh" + "\n",
                                          Colors: Colors.white,
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Shawrma.png',
                                            ),
                                          ),
                                          Navigate: () => {}),
                                      Resturants(
                                          Weight: width / 2.0,
                                          Height: height / 4.2,
                                          data: "Shawrma Frakh" + "\n",
                                          Colors: Colors.white,
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Shawrma.png',
                                            ),
                                          ),
                                          Navigate: () => {}),
                                      //
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            );
          }),
          listener: ((context, state) {}),
        ));
  }
}
