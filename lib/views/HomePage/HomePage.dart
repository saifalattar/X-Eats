import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/DiscountBanner.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Components/Products%20Components/ProductView.dart';
import 'package:xeats/controllers/Components/Restaurant%20Components/RestaurantView.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Cart/cart.dart';
import 'package:xeats/views/ResturantsMenu/ResturantsMenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-5674432343391353/7700576837",
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            print('Ad failed to load: $error');
          },
        ),
        request: AdRequest());
    final BannerAd bannerAd2 = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-5674432343391353/4883815579",
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (Ad ad) => print('Ad loaded.'),
          // Called when an ad request failed.
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // Dispose the ad here to free resources.
            print('Ad failed to load: $error');
          },
        ),
        request: AdRequest());
    bannerAd.load();
    bannerAd2.load();

    return BlocProvider(
        create: (context) => Xeatscubit()
          ..GetMostSoldProducts()
          ..getPoster()
          ..GetResturants()
          ..GettingUserData()
          ..CartData(),
        child: BlocConsumer<Xeatscubit, XeatsStates>(
          builder: ((context, state) {
            var cubit = Xeatscubit.get(context);
            var product_api = Xeatscubit.MostSold;
            var category_api = Xeatscubit.Get_Category;
            var restaurant_api = Xeatscubit.ResturantsList;
            var userEmail = cubit.EmailInforamtion;
            var userId = cubit.idInformation;
            var FirstName = cubit.FirstName ?? Loading();
            var LastName = cubit.LastName ?? ' ';
            // var PhoneNumber = cubit.PhoneNumber ?? ' ';
            var Wallet = cubit.wallet ?? 100;

            var cart = cubit.cartID;

            return Scaffold(
              appBar: appBar(context,
                  subtitle: 'Delivering to', title: 'Nile University, Giza'),
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          builder: (context, snapshot) {
                            return Container();
                          },
                          future: Xeatscubit.get(context)
                              .getCurrentAvailableOrderRestauant(),
                        ),
                        SizedBox(
                          height: height / 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, bottom: 12),
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "Welcome," + " " + '${FirstName}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: ConditionalBuilder(
                                    condition: Xeatscubit.getposters.isNotEmpty,
                                    fallback: (context) => Center(
                                          child: Loading(),
                                        ),
                                    builder: (context) => DiscountBanner()),
                              ),
                            ],
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
                                  'Restaurant',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      restaurant_api.length,
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigation(
                                                context,
                                                ResturantsMenu(
                                                    data:
                                                        restaurant_api[index]));
                                          },
                                          child: RestaurantView(
                                            data: restaurant_api[index]
                                                    ['Name'] ??
                                                Loading(),
                                            Colors: const Color.fromARGB(
                                                255, 5, 95, 9),
                                            image: Image(
                                              image: NetworkImage(DioHelper
                                                      .dio!.options.baseUrl +
                                                  restaurant_api[index]
                                                      ['image']),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: AdWidget(ad: bannerAd),
                                height: 50,
                                width: double.maxFinite,
                              )
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
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  child: Row(
                                    children: [
                                      ...List.generate(
                                        product_api.length,
                                        (index) {
                                          return GestureDetector(
                                            child: ProductView(
                                                image: 'images',
                                                width: width / 2.0,
                                                height: height / 4.2,
                                                data: product_api[index]
                                                        ["name"] +
                                                    "\n",
                                                Colors: Colors.white,
                                                Navigate: () => {}),
                                            onTap: () {
                                              print(product_api[0]["name"]);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: AdWidget(ad: bannerAd2),
                        )
                      ]),
                ),
              ),
            );
          }),
          listener: ((context, state) {}),
        ));
  }
}
