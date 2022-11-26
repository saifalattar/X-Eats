// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/SignIn/SignIn.dart';

class Layout extends StatelessWidget {
  String Hour = DateFormat("HH").format(DateTime.now());
  late String Hour1;
  late String Hour2;
  late String Minute1;
  late String Minute2;
  late int sum123;
  String minute = DateFormat.m().format(DateTime.now());
  String second = DateFormat.s().format(DateTime.now());

  var dt = DateTime.now();

  Layout({super.key}) {
    sum123 = int.parse(minute + Hour);
    print(Hour);
    print(minute);
    print(sum123);
    Hour1 = Hour.substring(0, 1);
    Hour2 = Hour.substring(1);
    Minute1 = minute.substring(0, 1);
    Minute2 = minute.substring(1);
  }

  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: ((context) => Xeatscubit()),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
          builder: ((context, state) {
            {
              var cubit = Xeatscubit.get(context);
              return Scaffold(
                  body: cubit.Screens[cubit.currentindex],
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Colors.black,
                    items: cubit.bottomitems,
                    currentIndex: cubit.currentindex,
                    onTap: (index) {
                      cubit.changebottomnavindex(index);
                    },
                  ));
            }
          }),
          listener: ((context, state) {})),
    );
  }
}
