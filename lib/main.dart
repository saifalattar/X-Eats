// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:xeats/views/Boarding/Boarding.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
import 'package:xeats/views/SignUp/SignUp.dart';
import 'package:xeats/views/Layout/Layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Layout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
