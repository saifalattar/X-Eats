// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
import 'package:xeats/views/SignUp2/SignUp2.dart';
import 'package:xeats/views/Verification/Verification.dart';

class SignUp2 extends StatelessWidget {
  SignUp2({super.key});

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Xeatscubit(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = Xeatscubit.get(context);
          var cubit1 = Xeatscubit.get(context);
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.12),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/Images/BG.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text("Create your Profile",
                                  style: const TextStyle(
                                    fontFamily: 'UberMoveTextBold',
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 9, 134, 211),
                                  )),
                            ),
                          ]),
                      Align(
                          child: Image(
                        height: height / 3.5,
                        image: AssetImage('assets/Images/First.png'),
                      )),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 17, right: 10),
                          child: Container(
                            width: width / 2.5,
                            child: defultformfield(
                                controller: Xeatscubit.get(context).Firstname,
                                label: 'First Name',
                                type: TextInputType.name,
                                validator: (value) => value!.isEmpty
                                    ? 'Put your First Name'
                                    : null),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: width / 2.5,
                          child: defultformfield(
                              controller: Xeatscubit.get(context).Lastname,
                              label: 'Last Name',
                              type: TextInputType.name,
                              validator: (value) =>
                                  value!.isEmpty ? 'Put your Last Name' : null),
                        ),
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 315,
                        child: defultformfield(
                            prefix: Icons.phone_android,
                            controller: Xeatscubit.get(context).Phone,
                            label: 'Phone No.',
                            type: TextInputType.phone,
                            validator: (value) => value!.isEmpty
                                ? 'Put your Phone number'
                                : null),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 315,
                        child: defultformfield(
                            controller: cubit.datecontroller,
                            prefix: Icons.calendar_month,
                            label: 'DD/MM/YYYY',
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate:
                                          DateTime.utc(1980, 1, 1, 1, 1, 1),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                cubit.datecontroller.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            validator: (value) =>
                                value!.isEmpty ? 'Put your Birthday' : null),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 315,
                        height: 70,
                        child: SelectedGender(
                          changed: (value) {
                            value = cubit.Value;
                            gender = cubit.Gender;
                            cubit.changegender();
                          },
                          form: (value) =>
                              value == null ? 'Select your gender' : null,
                        ),
                      ),
                      NextButton(
                          function: (() {
                            final form = formkey.currentState;
                            if (form != null && form.validate()) {
                              Navigation(context, Verify());
                            }
                          }),
                          text: 'Next'),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have time??',
                            style: TextStyle(fontSize: 13),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigation(context, Verify());
                              },
                              child: Text(
                                'Skip??',
                                style: TextStyle(fontSize: 13),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
