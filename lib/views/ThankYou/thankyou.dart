import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Layout/Layout.dart';

import '../../controllers/Components/Global Components/loading.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({
    Key? key,
    required this.press,
  }) : super(key: key);
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => Xeatscubit()..GettingUserData(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        builder: ((context, state) {
          var cubit = Xeatscubit.get(context);
          return Scaffold(
            appBar: appBar(context,
                subtitle: "Thank You", title: "${cubit.FirstName}"),
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.3,
                  image: AssetImage("assets/Images/055.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: height / 1.9),
                  Image(
                    image: AssetImage(
                      "assets/Images/success.png",
                    ),
                    height: height / 5,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Loading(),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      "Order is send Sucessfully",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: height / 200),
                  Center(),
                  Spacer(),
                  SizedBox(
                    width: width / 1.3,
                    child: ElevatedButton(
                        onPressed: () {
                          NavigateAndRemov(context, Layout());
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 9, 134, 211)),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Back to Home Page",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        }),
        listener: ((context, state) {}),
      ),
    );
  }
}
