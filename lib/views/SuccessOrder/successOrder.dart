import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';
import 'package:xeats/views/HomePage/HomePage.dart';

class SuccessOrder extends StatelessWidget {
  const SuccessOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Order is done \n نبقى نحط هنا بقى يا عبده اي حاجه شكلها حلو و بتاع عشان نقوله انه تمام و كده"),
          DefaultButton(
              function: () {
                NavigateAndRemov(context, const HomePage());
              },
              text: "Go to home")
        ],
      ),
    );
  }
}
