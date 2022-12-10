// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:xeats/controllers/AuthCubit/States.dart';
import 'package:xeats/controllers/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
import 'package:xeats/views/SignUp/SignUp.dart';
import 'package:xeats/views/Verification/Verification.dart';

class Complete_Profile extends StatelessWidget {
  Complete_Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xff0986d3),
          body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(150.r))),
            child: SafeArea(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: cubit.complee_profile_formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Complete Profile",
                            style: TextStyle(
                              fontFamily: 'UberMoveTextBold',
                              fontSize: 25.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 9, 134, 211),
                            )),
                        Center(
                          child: Image(
                            image: AssetImage('assets/Images/First.png'),
                            width: width / 2,
                            height: width / 2,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: defultformfield(
                                    controller: cubit.first_name,
                                    label: 'First Name',
                                    type: TextInputType.name,
                                    validator: (value) => value!.isEmpty
                                        ? 'Put your First Name'
                                        : null),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: defultformfield(
                                    controller: cubit.last_name,
                                    label: 'Last Name',
                                    type: TextInputType.name,
                                    validator: (value) => value!.isEmpty
                                        ? 'Put your Last Name'
                                        : null),
                              ),
                            ]),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: defultformfield(
                              prefix: Icons.phone_android,
                              controller: cubit.PhoneNumber,
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
                          width: double.infinity,
                          child: defultformfield(
                              controller: cubit.nu_id,
                              label: 'NU ID ',
                              type: TextInputType.phone,
                              validator: (value) => value!.isEmpty
                                  ? 'Put your Phone number'
                                  : null),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
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
                              validator: (value) => value!.isEmpty
                                  ? 'Enter your Birthday'
                                  : null),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
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
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: SelectedTitle(
                            changed: (value) {
                              value = cubit.ValueTitle;
                              title = cubit.title;
                              cubit.changetitle();
                            },
                            form: (value) =>
                                value == null ? 'Select your title' : null,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defultbutton(
                            function: () {
                              if (cubit.complee_profile_formkey.currentState!
                                  .validate()) {
                                cubit.CreateUser(
                                  context,
                                  password: cubit.password.text,
                                  email: cubit.email.text,
                                  first_name: cubit.first_name.text,
                                  last_name: cubit.last_name.text,
                                  title: cubit.title,
                                  nu_id: cubit.nu_id.text,
                                  school: "CS",
                                  PhoneNumber: cubit.PhoneNumber.text,
                                );
                                Navigation(context, Verify());
                              }
                            },
                            text: 'Next'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
