import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Components/TopPage.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Dio/DioHelper.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Profile/Profile.dart';
import 'package:xeats/views/Resturants/Resturants.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

class ResturantsMenu extends StatelessWidget {
  ResturantsMenu({super.key, required this.data});
  var data;

  String title1 = "Shawrma Frakh";
  String title2 = "Meals";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-5674432343391353/4524475505",
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
    return BlocProvider(
      create: (context) => Xeatscubit(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Xeatscubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Stack(children: [
                  SafeArea(child: TopPage()),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height / 9.5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: height / 5,
                                  width: width / 2.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.amber,
                                      border: Border.all(
                                          width: 20, color: Colors.white)),
                                  child: Image(
                                    image: NetworkImage(
                                        DioHelper.dio!.options.baseUrl +
                                            data['image']),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width / 45,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: height / 9),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              data['Name'],
                              style: GoogleFonts.kanit(fontSize: 16),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: width / 7,
                                height: height / 13,
                                child: const Image(
                                    image: AssetImage(
                                  'assets/Images/First.png',
                                )),
                              ),
                              SizedBox(
                                width: width / 79,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                'X-Eats Delivery',
                                style: GoogleFonts.kanit(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ]),
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: AdWidget(ad: bannerAd),
                ),
                SizedBox(
                  height: height / 75.6,
                ),
                SizedBox(
                  height: height / 1.995,
                  child: FutureBuilder(
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      } else {
                        return Loading();
                      }
                    }),
                    future: Xeatscubit.get(context).getCurrentCategories(
                        context,
                        restaurantId: data["id"].toString()),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: GoogleFonts.kanit(),
              backgroundColor: Colors.white,
              items: cubit.bottomitems,
              currentIndex: 1,
              onTap: (index) {
                if (index == 1) {
                  Navigator.pop(context);
                } else if (index == 0) {
                  Navigation(context, Layout());
                } else {
                  Navigation(context, Layout());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
