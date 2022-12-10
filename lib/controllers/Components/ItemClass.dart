import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';

class FoodItem extends StatelessWidget {
  static double deliveryFee = 10;
  final String? englishName, productSlug, description, creationDate, arabicName;
  String? itemImage, restaurantImage;
  final int? restaurant, category, id;
  int quantity = 1;
  final double? price;
  double? totalPrice;
  final bool? isMostPopular, isNewProduct, isBestOffer;

  static List<FoodItem> CartItems = [
    FoodItem(
        id: 43,
        restaurantImage: "/uploads/Restaurant/Untitled_design_5.png",
        itemImage: "/uploads/Catgories/8.png",
        englishName: "Alexandrian Liver Sandwich",
        arabicName:
            "\u0643\u0628\u062f\u0629 \u0627\u0633\u0643\u0646\u0631\u0627\u0646\u064a",
        productSlug: "alexandrian-liver-sandwich",
        restaurant: 2,
        description: "",
        price: 20.0,
        category: 10,
        isBestOffer: false,
        isMostPopular: false,
        isNewProduct: false,
        creationDate: "2022-11-05T14:22:07.990140+02:00"),
    FoodItem(
        id: 43,
        restaurantImage: "/uploads/Restaurant/Untitled_design_5.png",
        itemImage: "/uploads/Catgories/8.png",
        englishName: "Alexandrian Liver Sandwich",
        arabicName:
            "\u0643\u0628\u062f\u0629 \u0627\u0633\u0643\u0646\u0631\u0627\u0646\u064a",
        productSlug: "alexandrian-liver-sandwich",
        restaurant: 2,
        description: "",
        price: 20.0,
        category: 10,
        isBestOffer: false,
        isMostPopular: false,
        isNewProduct: false,
        creationDate: "2022-11-05T14:22:07.990140+02:00"),
    FoodItem(
        id: 43,
        restaurantImage: "/uploads/Restaurant/Untitled_design_5.png",
        itemImage: "/uploads/Catgories/8.png",
        englishName: "Alexandrian Liver Sandwich",
        arabicName:
            "\u0643\u0628\u062f\u0629 \u0627\u0633\u0643\u0646\u0631\u0627\u0646\u064a",
        productSlug: "alexandrian-liver-sandwich",
        restaurant: 2,
        description: "",
        price: 20.0,
        category: 10,
        isBestOffer: false,
        isMostPopular: false,
        isNewProduct: false,
        creationDate: "2022-11-05T14:22:07.990140+02:00"),
    FoodItem(
        id: 43,
        restaurantImage: "/uploads/Restaurant/Untitled_design_5.png",
        itemImage: "/uploads/Catgories/8.png",
        englishName: "Alexandrian Liver Sandwich",
        arabicName:
            "\u0643\u0628\u062f\u0629 \u0627\u0633\u0643\u0646\u0631\u0627\u0646\u064a",
        productSlug: "alexandrian-liver-sandwich",
        restaurant: 2,
        description: "",
        price: 20.0,
        category: 10,
        isBestOffer: false,
        isMostPopular: false,
        isNewProduct: false,
        creationDate: "2022-11-05T14:22:07.990140+02:00"),
    FoodItem(
        id: 43,
        restaurantImage: "/uploads/Restaurant/Untitled_design_5.png",
        itemImage: "/uploads/Catgories/8.png",
        englishName: "Alexandrian Liver Sandwich",
        arabicName:
            "\u0643\u0628\u062f\u0629 \u0627\u0633\u0643\u0646\u0631\u0627\u0646\u064a",
        productSlug: "alexandrian-liver-sandwich",
        restaurant: 2,
        description: "",
        price: 20.0,
        category: 10,
        isBestOffer: false,
        isMostPopular: false,
        isNewProduct: false,
        creationDate: "2022-11-05T14:22:07.990140+02:00")
  ];

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
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      NetworkImage("https://x-eats.com${this.restaurantImage}"),
                ),
                SizedBox(
                  child: Image.network("https://x-eats.com${this.itemImage}"),
                  width: 100,
                ),
              ],
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
      );
    });
  }

  Widget preview(BuildContext context) {
    String? shift;
    return BlocBuilder<Xeatscubit, XeatsStates>(builder: (context, states) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 9, 134, 211),
          //add to cart button
          onPressed: () {
            Xeatscubit.get(context).addToCart(
                productId: id.toString(),
                quantity: quantity.toString(),
                price: price.toString(),
                totalPrice: totalPrice.toString(),
                restaurantId: restaurant.toString(),
                timeShift: currentTiming);
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [Image.asset("assets/Images/compass.png")],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 170,
                color: const Color.fromARGB(255, 9, 134, 211),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.network(
                          "https://x-eats.com${this.restaurantImage}"),
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                    Text(
                      "Res Name",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Image.network(
                        "https://x-eats.com${this.itemImage}",
                        width: 200,
                      ),
                      Text(
                        "${this.englishName}\n${this.arabicName}",
                        style: TextStyle(fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${this.price} EGP",
                        style: TextStyle(fontSize: 23),
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
                              "Description:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              "${this.description}",
                              style: TextStyle(fontSize: 19),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Order Time :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
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
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    quantity++;
                                    totalPrice = quantity * price!;
                                    Xeatscubit.get(context).emit(AddQuantity());
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 9, 134, 211),
                                  )),
                              Text("${this.quantity}"),
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
                                    color: Color.fromARGB(255, 9, 134, 211),
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      );
    });
  }
}
