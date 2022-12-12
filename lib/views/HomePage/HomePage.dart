import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/DiscountBanner.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Components/Products%20Components/ProductView.dart';
import 'package:xeats/controllers/Components/Restaurant%20Components/RestaurantView.dart';
import 'package:xeats/controllers/Components/TopPage.dart';
import 'package:xeats/controllers/Cubit.dart';
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
          ..GetResturants(),
        child: BlocConsumer<Xeatscubit, XeatsStates>(
          builder: ((context, state) {
            var cubit = Xeatscubit.get(context);
            var product_api = Xeatscubit.MostSold;
            var category_api = Xeatscubit.Get_Category;
            var restaurant_api = Xeatscubit.ResturantsList;

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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TopPage(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: ConditionalBuilder(
                                condition: Xeatscubit.getimages.isNotEmpty,
                                fallback: (context) => Center(
                                      child: Loading(),
                                    ),
                                builder: (context) => DiscountBanner()),
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
                                  style: GoogleFonts.kanit(fontSize: 16),
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
                                  style: GoogleFonts.kanit(fontSize: 16),
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
                                                image: product_api[index]
                                                    ["image"],
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

                                      ProductView(
                                          width: width / 2.0,
                                          height: height / 4.2,
                                          data: "Shawrma Frakh" + "\n",
                                          Colors: Colors.white,
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Shawrma.png',
                                            ),
                                          ),
                                          Navigate: () => {}),
                                      ProductView(
                                          width: width / 2.0,
                                          height: height / 4.2,
                                          data: "Shawrma Frakh" + "\n",
                                          Colors: Colors.white,
                                          image: const Image(
                                            image: AssetImage(
                                              'assets/Images/Shawrma.png',
                                            ),
                                          ),
                                          Navigate: () => {}),
                                      ProductView(
                                          width: width / 2.0,
                                          height: height / 4.2,
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
