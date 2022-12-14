import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/Cart/Cart.dart';

AppBar appBar(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return AppBar(
    foregroundColor: Colors.white,
    backgroundColor: Colors.white,
    actions: [
      Container(
        color: Colors.transparent,
        width: width,
        height: height / 13,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivering to',
                          style: GoogleFonts.kanit(
                              fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          'Shiekh Zayed (Nile University)',
                          style: GoogleFonts.kanit(
                              fontSize: 13, color: Colors.black),
                        ),
                      ]),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigation(context, Cart());
                },
                icon: Icon(Icons.shopping_cart,
                    color: const Color.fromARGB(255, 9, 134, 211)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
