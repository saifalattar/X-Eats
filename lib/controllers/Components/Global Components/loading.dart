import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: const SpinKitFadingCircle(
      color: Colors.lightBlue,
      duration: Duration(seconds: 3),
      size: 30,
    ));
  }
}
