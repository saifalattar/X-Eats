// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';

class Verify extends StatelessWidget {
  Verify({super.key});

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Xeatscubit(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var PhoneCubit = Xeatscubit.get(context).Phone.text;
          return Scaffold(
            body: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.12),
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/Images/BG.png',
                          ),
                          fit: BoxFit.cover)),
                  child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Align(
                              child: Image(
                            height: 250,
                            image: AssetImage('assets/Images/password.png'),
                          )),
                          const Text("Verification Code",
                              style: TextStyle(
                                fontFamily: 'UberMoveTextBold',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 9, 134, 211),
                              )),
                          const SizedBox(
                            height: 1,
                          ),
                          const Text(
                            'Please type the verification code\n          sent to',
                            style: TextStyle(fontSize: 9.8),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 70,
                                child: OtpField(
                                  onTap: () {
                                    Action:
                                    TextInputAction.next;
                                  },
                                  Action: TextInputAction.next,
                                  controller: Xeatscubit.get(context).XeatOtp1,
                                  type: TextInputType.phone,
                                  validator: ((value) =>
                                      value!.isEmpty ? 'Number missing' : null),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 70,
                                child: OtpField(
                                  Action: TextInputAction.next,
                                  controller: Xeatscubit.get(context).XeatOtp2,
                                  type: TextInputType.phone,
                                  validator: ((value) =>
                                      value!.isEmpty ? 'Number missing' : null),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 70,
                                child: OtpField(
                                  Action: TextInputAction.next,
                                  controller: Xeatscubit.get(context).XeatOtp3,
                                  type: TextInputType.phone,
                                  validator: ((value) =>
                                      value!.isEmpty ? 'Number missing' : null),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 70,
                                child: OtpField(
                                  Action: TextInputAction.done,
                                  controller: Xeatscubit.get(context).XeatOtp4,
                                  type: TextInputType.phone,
                                  validator: ((value) =>
                                      value!.isEmpty ? 'Number missing' : null),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Resend Code',
                                style: GoogleFonts.kanit(
                                    fontWeight: FontWeight.w600,
                                    textStyle: TextStyle(color: Colors.blue)),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 315,
                            height: 65,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () {},
                              child: Expanded(
                                child: Row(children: [
                                  const SizedBox(
                                    width: 75,
                                  ),
                                  Text('Verify now',
                                      style: GoogleFonts.kanit(
                                        textStyle: const TextStyle(
                                          fontSize: 25.0,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Image.asset(
                                    'assets/Images/Khaledd.png',
                                    height: 20,
                                    width: 20,
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
