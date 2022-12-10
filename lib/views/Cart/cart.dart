import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/CustomDivider.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/CheckOut/CheckOut.dart';
import 'package:xeats/views/HomePage/HomePage.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Xeatscubit, XeatsStates>(builder: (context, state) {
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
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: Xeatscubit.get(context).getCartItems(),
                builder: (ctx, AsyncSnapshot ss) {
                  print(ss.connectionState);
                  if (ss.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ss.data[index];
                        },
                        separatorBuilder: (context, index) {
                          return CustomDivider();
                        },
                        itemCount: ss.data.length,
                      ),
                    );
                  } else {
                    return Loading();
                  }
                }),
            CustomDivider(),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigation(context, const HomePage());
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 9, 134, 211))))),
                          child: Text(
                            "Continue Shopping",
                            style: TextStyle(color: Colors.black),
                          )),
                      DefaultButton(
                          // width: MediaQuery.of(context).size.width / 2.2,
                          function: () {
                            Navigation(context, const CheckOut());
                          },
                          text: "Check Out")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
