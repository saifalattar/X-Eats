import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/Cart/cart.dart';
import 'package:xeats/views/CheckOut/CheckOut.dart';
import 'package:http/http.dart';

class FoodItem extends StatelessWidget {
  final bool? isMostPopular, isNewProduct, isBestOffer;
  static double deliveryFee = 10;
  final double? price;
  final int? restaurant, category, id;
  final String? englishName, productSlug, description, creationDate, arabicName;

  int quantity = 1;
  double? totalPrice;
  String? itemImage, restaurantImage;
  String? cartItemId;

  static List<FoodItem> CartItems = [];

  FoodItem(
      {this.id,
      this.quantity = 1,
      this.englishName,
      this.productSlug,
      this.description,
      this.creationDate,
      this.arabicName,
      this.restaurant,
      this.category,
      this.price,
      this.isMostPopular,
      this.itemImage,
      this.restaurantImage,
      this.isNewProduct,
      this.cartItemId,
      this.isBestOffer}) {
    totalPrice = price;
  }

  static double getSubtotal() {
    double total = 0;
    for (var i in CartItems) {
      total += i.totalPrice!;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Xeatscubit, XeatsStates>(builder: (context, state) {
      return Dismissible(
        onDismissed: (direction) {
          Xeatscubit.get(context).deleteCartItem(context, "${this.cartItemId}");
        },
        key: Key(""),
        background: Container(
          decoration: const BoxDecoration(color: Colors.red),
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Image.network("https://x-eats.com${this.itemImage}"),
                width: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${this.englishName}",
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    "${this.arabicName}",
                    style: TextStyle(fontSize: 21),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("QTY :    ${this.quantity}"),
                        Text(
                          "$totalPrice EGP",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget productsOfCategory(
    BuildContext context, {
    required String? image,
  }) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // DioHelper.dio!.options.baseUrl +
          // value.data["Names"][index]['image'],
          InkWell(
            onTap: () {
              Navigation(context, productDetails(context, image: '${image}'));
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  FutureBuilder(
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var image = snapshot.data;

                        return Container(
                          height: 130.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(74, 158, 158, 158)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.network(
                              "https://x-eats.com${image.data["Names"][0]["image"]}",
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: Loading(),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return Loading();
                      }
                    }),
                    future: Dio().get(
                        "https://x-eats.com/get_category_by_id/${this.category}"),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              englishName!,
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            category.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 11),
                          ),
                          Text(
                            price.toString() + "  EGP",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productDetails(BuildContext context, {required String? image}) {
    String? shift;

    final BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-5674432343391353/3216382829",
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

    return BlocBuilder<Xeatscubit, XeatsStates>(builder: (context, states) {
      var cubit = Xeatscubit.get(context);
      var userId = cubit.idInformation;
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 9, 134, 211),
          //add to cart button
          onPressed: () {
            Xeatscubit.get(context).addToCart(
                productId: id,
                quantity: quantity,
                price: price,
                totalPrice: totalPrice,
                restaurantId: restaurant,
                timeShift: currentTiming);
            // Navigation(context, const Cart());
            print(cubit.cartItems);
          },
          child: const Icon(Icons.add_shopping_cart_rounded),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 9, 134, 211),
          toolbarHeight: 100,
          leadingWidth: double.maxFinite,
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Preview",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [Image.asset("assets/Images/compass.png")],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Image(
                        width: 200,
                        image: NetworkImage(
                          'https://x-eats.com$image',
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: Loading(),
                          );
                        },
                      ),
                      Text(
                        "${this.englishName}\n${this.arabicName}",
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${this.price} EGP",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description:\n",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${this.description}",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Order Time :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                DropdownButton(
                                    hint: shift == null
                                        ? Text("Time Shift")
                                        : Text("$shift"),
                                    items: getTimings(),
                                    onChanged: (data) {
                                      shift = data as String?;
                                      currentTiming = data as String?;
                                      // Xeatscubit.get(context).emit(SetTiming());
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "QTY :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (quantity != 1) {
                                            quantity--;
                                            totalPrice = quantity * price!;
                                            Xeatscubit.get(context)
                                                .emit(RemoveQuantity());
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color:
                                              Color.fromARGB(255, 9, 134, 211),
                                        )),
                                    Text("${this.quantity}"),
                                    IconButton(
                                        onPressed: () {
                                          quantity++;
                                          totalPrice = quantity * price!;
                                          Xeatscubit.get(context)
                                              .emit(AddQuantity());
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color:
                                              Color.fromARGB(255, 9, 134, 211),
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: AdWidget(ad: bannerAd),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );
    });
  }
}
