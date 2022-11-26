import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
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
            return Scaffold(
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
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
                                        Weight: 180,
                                        Height: 180,
                                        data: "Shawrma Frakh" + "\n",
                                        Colors: Colors.white,
                                        image: const Image(
                                          image: AssetImage(
                                            'assets/Images/Shawrma.png',
                                          ),
                                        ),
                                        Navigate: () =>
                                            Navigation(context, SignIn()),
                                      ),
                                      Resturants(
                                        Weight: 180,
                                        Height: 180,
                                        data: "Shawrma Frakh" + "\n",
                                        Colors: Colors.white,
                                        image: const Image(
                                          image: AssetImage(
                                            'assets/Images/Shawrma.png',
                                          ),
                                        ),
                                        Navigate: () =>
                                            Navigation(context, SignIn()),
                                      ),
                                      //
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Dividerr(),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "The Next Order",
                                      style: GoogleFonts.kanit(
                                        color: Colors.blue,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 35,
                                      width: width / 1.3,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 3,
                                            color: Colors.blue,
                                            style: BorderStyle.solid),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "11:00 AM",
                                            style: GoogleFonts.kanit(
                                                color: DateTime.now()
                                                                .hour
                                                                .toInt() >
                                                            15 &&
                                                        DateTime.now()
                                                                .hour
                                                                .toInt() <
                                                            10
                                                    ? Colors.white
                                                    : Colors.blue),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "1:00 PM",
                                            style: GoogleFonts.kanit(
                                                color: DateTime.now()
                                                                .hour
                                                                .toInt() >
                                                            11 &&
                                                        DateTime.now()
                                                                .hour
                                                                .toInt() <
                                                            13
                                                    ? Colors.white
                                                    : Colors.blue),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "3:00 PM",
                                            style: GoogleFonts.kanit(
                                                color: DateTime.now()
                                                                .hour
                                                                .toInt() >
                                                            13 &&
                                                        DateTime.now()
                                                                .hour
                                                                .toInt() <
                                                            15
                                                    ? Colors.white
                                                    : Colors.blue),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Dividerr(),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              'Resturants',
                                              style: GoogleFonts.kanit(
                                                  fontSize: 30),
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
                                                        context, SignIn()),
                                                  ),
                                                  //
                                                  Resturants(
                                                    data: "Koshry" +
                                                        "\n Eltahrir",
                                                    Colors:
                                                        const Color.fromARGB(
                                                            255, 5, 95, 9),
                                                    image: const Image(
                                                      image: AssetImage(
                                                        'assets/Images/Tahrir.jpg',
                                                      ),
                                                    ),
                                                    Navigate: () => Navigation(
                                                        context, SignIn()),
                                                  ),

                                                  Resturants(
                                                    data: "Salama " +
                                                        "\nElmotmiz",
                                                    Colors:
                                                        const Color.fromARGB(
                                                            255, 109, 17, 11),
                                                    image: const Image(
                                                      image: AssetImage(
                                                        'assets/Images/Salama.jpg',
                                                      ),
                                                    ),
                                                    Navigate: () => Navigation(
                                                        context, SignIn()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
