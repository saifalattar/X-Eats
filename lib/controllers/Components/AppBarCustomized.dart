import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/views/Cart/Cart.dart';

AppBar appBar(BuildContext context, {String? subtitle, String? title}) {
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subtitle!.length < 3
                          ? FutureBuilder(
                              builder: (ctx, AsyncSnapshot ss) {
                                print(ss.connectionState);
                                if (ss.hasData) {
                                  return Text(
                                    ss.data ?? 'to',
                                    style: GoogleFonts.poppins(
                                        fontSize: 11, color: Colors.grey),
                                  );
                                } else {
                                  return const SpinKitDualRing(
                                    color: Colors.black,
                                    size: 10,
                                  );
                                }
                              },
                              future: Xeatscubit.get(context)
                                  .getRestaurantName(subtitle.toString()),
                            )
                          : Text(
                              subtitle ?? 'to',
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: Colors.grey),
                            ),
                      Text(
                        title ?? 'Giza',
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: Colors.black),
                      ),
                    ]),
              ),
              IconButton(
                onPressed: () {
                  Navigation(context, const Cart());
                },
                icon: const Icon(Icons.shopping_cart,
                    color: Color.fromARGB(255, 9, 134, 211)),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
