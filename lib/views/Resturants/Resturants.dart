// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';

class Resturantss extends StatelessWidget {
  const Resturantss({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> result = InternetConnectionChecker().hasConnection;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
        create: (context) => Xeatscubit()..GetResturants(),
        child: BlocConsumer<Xeatscubit, XeatsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = Xeatscubit.get(context);
            var data_from_api = Xeatscubit.ResturantsList;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    width: width,
                    height: height / 5,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)),
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
                        ListView.separated(
                          separatorBuilder: ((context, index) =>
                              SizedBox(height: height / 45)),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
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
                                    image: NetworkImage(
                                      'https://www.x-eats.com' +
                                          data_from_api[index]['image'],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: data_from_api.length,
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        ));
  }
}
