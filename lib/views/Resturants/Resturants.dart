// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';

import '../../controllers/Components/Products Components/NewProducts.dart';

class Resturantss extends StatelessWidget {
  const Resturantss({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => Xeatscubit()..NewProducts(),
        child: BlocConsumer<Xeatscubit, XeatsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = Xeatscubit.get(context);
            var data_from_api = Xeatscubit.ResturantsList;
            var newProducts = Xeatscubit.new_products;

            var Connection = false;

            return Scaffold(
              appBar: appBar(context, subtitle: 'X-Eats', title: 'Restaurants'),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'New Products',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              child: Row(
                                children: [
                                  ...List.generate(
                                    newProducts.length,
                                    (index) {
                                      return FutureBuilder(
                                          future: cubit.gettingCategoryImages(
                                              newProducts[index]["category"]
                                                  .toString()),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              return GestureDetector(
                                                child: NewProducts(
                                                    title: newProducts[index]
                                                        ["name"],
                                                    Colors: Colors.white,
                                                    image: snapshot.data
                                                        .toString(),
                                                    Navigate: () => {}),

                                                // },
                                              );
                                            } else {
                                              return Loading();
                                            }
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Restaurants',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ConditionalBuilder(
                          condition:
                              data_from_api.isNotEmpty && Connection == false,
                          fallback: (context) => Center(child: Loading()),
                          builder: (context) => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (data_from_api[index]['image'] == null) {
                                return Loading();
                              } else {
                                return InkWell(
                                  onTap: () {
                                    Navigation(
                                        context,
                                        ResturantsMenu(
                                            data: data_from_api[index]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(children: [
                                      Container(
                                        height: 130.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  74, 158, 158, 158)),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Image.network(
                                              'https://www.x-eats.com' +
                                                  data_from_api[index]['image'],
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child: Loading(),
                                                );
                                              },
                                            )),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: height / 7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    '${data_from_api[index]['Name']}',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    )),
                                              ]),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(children: const [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                Text(' 4.1'),
                                                Text(' (100+)')
                                              ]),
                                              Row(
                                                children: [
                                                  const Icon(Icons.timer_sharp),
                                                  Text(
                                                    ' 45 mins',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    width: 25.w,
                                                  ),
                                                  Icon(Icons
                                                      .delivery_dining_outlined),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Text(
                                                    'EGP 10',
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              }
                            },
                            separatorBuilder: ((context, index) => Dividerr()),
                            itemCount: data_from_api.length,
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
