import 'package:flutter/material.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/controllers/Components/ItemClass.dart';
import 'package:xeats/controllers/Cubit.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Image.asset("assets/Images/shopping-cart.png")],
        backgroundColor: const Color.fromARGB(255, 9, 134, 211),
        toolbarHeight: 100,
        leadingWidth: 800,
        leading: const Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            "Check Out",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "EGP ${FoodItem.getSubtotal()}",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Delivery Fee",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "EGP ${FoodItem.deliveryFee}",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "EGP ${FoodItem.deliveryFee + FoodItem.getSubtotal()}",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 9, 134, 211))))),
                    child: Text(
                      "Back to cart",
                      style: TextStyle(color: Colors.black),
                    )),
                DefaultButton(
                    // width: MediaQuery.of(context).size.width / 2.2,
                    function: () {
                      Xeatscubit.get(context).confirmOrder();
                    },
                    text: "Order Now")
              ],
            )
          ],
        ),
      ),
    );
  }
}
