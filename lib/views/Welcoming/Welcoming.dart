// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';

class Welcoming extends StatefulWidget {
  Welcoming({super.key});

  @override
  State<Welcoming> createState() => _WelcomingState();
}

class _WelcomingState extends State<Welcoming> {
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
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height / 21,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: defultformfield(
                              validator: (value) {
                                value!.isEmpty
                                    ? 'null'
                                    : cubit.Searchbar(value);
                              },
                              type: TextInputType.text,
                              label: 'Search'),
                        ),
                      ),
                    ]),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: (() {}),
                ),
                bottomNavigationBar: BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 10.0,
                    color: Colors.blue,
                    child: CircularNotchBottom(
                        ontap: (index) {
                          setState(() {
                            cubit.changebottomnavindex(index);
                            if cubit.currentindex
                          });
                        },
                        Items: [
                          // ignore: prefer_const_constructors
                          BottomNavigationBarItem(
                            label: '',
                            icon: Icon(Icons.home_outlined),
                          ),
                          BottomNavigationBarItem(
                            label: '',
                            icon: Icon(Icons.add),
                          ),
                          BottomNavigationBarItem(
                            label: '',
                            icon: Icon(Icons.shopping_cart_checkout),
                          )
                        ],
                        currentindex: cubit.currentindex)),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              );
            }
          }),
          listener: ((context, state) {})),
    );
  }
}
