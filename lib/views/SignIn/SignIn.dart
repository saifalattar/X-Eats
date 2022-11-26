// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/views/SignUp/SignUp.dart';

import '../../controllers/Cubit.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  var formkey = GlobalKey<FormState>();

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
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(4),
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
                            child: Text("Login",
                                style: const TextStyle(
                                  fontFamily: 'UberMoveTextBold',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 9, 134, 211),
                                )),
                          )
                        ],
                      ),
                      Align(
                          child: Image(
                        image: AssetImage('assets/Images/First.png'),
                      )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 21),
                        child: Container(
                          child: defultformfield(
                              prefix: Icons.email_outlined,
                              controller: Xeatscubit.get(context).email,
                              label: 'Email',
                              type: TextInputType.emailAddress,
                              validator: (value) => value!.isEmpty
                                  ? 'please put your Email'
                                  : null),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 22),
                        child: Container(
                          width: double.infinity,
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defultbutton(
                          function: (() {
                            final form = formkey.currentState;
                            if (form != null && form.validate()) {
                              Navigation(context, SignUp());
                            }
                          }),
                          text: 'Sign In'),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(
                            flex: 3,
                          ),
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(fontSize: 15),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigation(context, SignUp());
                              },
                              child: Text(
                                'Sign up?',
                                style: TextStyle(fontSize: 15),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
