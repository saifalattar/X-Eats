import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Components/ItemClass.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Checkout/CheckOut.dart';
import 'package:xeats/views/HomePage/HomePage.dart';
import 'package:xeats/views/Layout/Layout.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => Xeatscubit()
        ..CartData()
        ..GettingUserData(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Xeatscubit.get(context);

          var userId = cubit.idInformation;
          var cartId = cubit.cartID;

          return Scaffold(
            appBar: AppBar(
              actions: [Image.asset("assets/Images/shopping-cart.png")],
              backgroundColor: const Color.fromARGB(255, 9, 134, 211),
              toolbarHeight: 120,
              leadingWidth: 400,
              leading: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Cart",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Column(
              children: [
                FutureBuilder(
                    future: Xeatscubit.get(context).getCartItems(
                      context,
                      users: userId,
                    ),
                    builder: (ctx, AsyncSnapshot snapshot) {
                      print(snapshot.connectionState);
                      if (snapshot.hasData) {
                        print(snapshot.data.length);
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return snapshot.data[index];
                            },
                            separatorBuilder: (context, index) {
                              return Dividerr();
                            },
                            itemCount: snapshot.data.length,
                          ),
                        );
                      } else {
                        return Loading();
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Slide Left to delete an Item",
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigation(context, Layout());
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 9, 134, 211)),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Continue Shopping",
                                style: TextStyle(color: Colors.black),
                              )),
                          DefaultButton(
                              function: () {
                                // if() {}
                                Navigation(context, const CheckOut());
                              },
                              text: "Checkout")
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
