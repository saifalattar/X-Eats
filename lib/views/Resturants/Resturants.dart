import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';

class Resturantss extends StatelessWidget {
  const Resturantss({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: width,
            height: height / 5,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Discover',
                    style: GoogleFonts.kanit(
                        fontWeight: FontWeight.w500, fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: height / 3.8,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/Images/Tahrir.jpg'))),
                ),
                SizedBox(
                  height: height / 30,
                ),
                InkWell(
                  onTap: () {
                    Navigation(context, ResturantsMenu());
                  },
                  child: Ink(
                    height: height / 3.8,
                    width: width / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Images/Salama.jpg'))),
                  ),
                ),
                SizedBox(height: height / 30),
                InkWell(
                  onTap: () {
                    Navigation(context, ResturantsMenu());
                  },
                  child: Ink(
                    height: height / 3.8,
                    width: width / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Images/karmElsham.png'))),
                  ),
                ),
                SizedBox(height: height / 30),
                InkWell(
                  onTap: () {
                    Navigation(context, ResturantsMenu());
                  },
                  child: Ink(
                    height: height / 3.8,
                    width: width / 1.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Images/karmElsham.png'))),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
