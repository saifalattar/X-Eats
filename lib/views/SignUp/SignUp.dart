// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/SignIn/SignIn.dart';
import 'package:xeats/views/SignUp2/SignUp2.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => Xeatscubit(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = Xeatscubit.get(context);
          var cubit1 = Xeatscubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.12),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/Images/BG.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text("Sign Up",
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
                      image: AssetImage('assets/Images/First.png'),
                    )),
                    Container(
                      width: 315,
                      child: defultformfield(
                          prefix: Icons.email_outlined,
                          controller: Xeatscubit.get(context).email,
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty ? 'please put your Email' : null),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 315,
                      child: defultformfield(
                          prefix: Icons.lock_open,
                          controller: cubit.Password,
                          label: 'Password',
                          suffix: cubit.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          suffixpressed: () {
                            cubit.changepasswordVisablity();
                          },
                          validator: (value) => value!.isEmpty
                              ? 'please put your Password'
                              : null),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 315,
                      child: defultformfield(
                          prefix: Icons.lock_open,
                          controller: cubit1.Password1,
                          label: 'Confirm Password',
                          suffix: cubit.isPassword1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit1.isPassword,
                          suffixpressed: () {
                            Xeatscubit.get(context).changepasswordVisablity1();
                          },
                          validator: (value) => value!.isEmpty
                              ? 'please put your Password'
                              : null),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defultbutton(
                        function: (() {
                          Navigation(context, SignUp2());
                        }),
                        text: 'Sign Up'),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already User',
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigation(context, SignIn());
                            },
                            child: Text(
                              'Login?',
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
