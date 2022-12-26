import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Animations/EmptyCart.dart';
import 'package:xeats/views/Checkout/CheckOut.dart';
import 'package:xeats/views/Layout/Layout.dart';

List<Widget> allWhatInCart = [];

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => Xeatscubit()
        ..GettingUserData()
        ..getCartID(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Xeatscubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          "${cubit.FirstName}\'s Cart",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      child: Image(
                          image: AssetImage('assets/Images/shopping-cart.png')),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 15,
                ),
                SingleChildScrollView(
                  child: FutureBuilder(
                      future: Xeatscubit.get(context).getCartItems(
                        context,
                        email: cubit.EmailInforamtion,
                      ),
                      builder: (ctx, AsyncSnapshot snapshot) {
                        print(snapshot.connectionState);
                        if (snapshot.hasData) {
                          if (!snapshot.data.isEmpty) {
                            allWhatInCart = snapshot.data;

                            allWhatInCart.add(Padding(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigation(context, Layout());
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 9, 134, 211)),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            "Continue Shopping",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height: 50.h,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            onPressed: () {
                                              Navigation(
                                                  context, const CheckOut());
                                            },
                                            child: const Text("Check Out")),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ));

                            return SizedBox(
                              height: MediaQuery.of(context).size.height / 1.32,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return allWhatInCart[index];
                                },
                                separatorBuilder: (context, index) {
                                  return Dividerr();
                                },
                                itemCount: allWhatInCart.length,
                              ),
                            );
                          } else {
                            return Center(child: EmptyCart());
                          }
                        } else {
                          return SizedBox(
                            child: Loading(),
                            height: MediaQuery.of(context).size.height / 1.5,
                          );
                        }
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
