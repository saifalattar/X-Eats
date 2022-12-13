import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/AuthCubit/States.dart';
import 'package:xeats/controllers/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Dio/Cache_Helper.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..Email(),
      child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            var Email = cubit.UserInformation;
            return SafeArea(
              child: ConditionalBuilder(
                condition: Email != null,
                fallback: (context) => Center(child: Loading()),
                builder: (BuildContext context) {
                  return Scaffold(
                    body: Column(
                      children: [
                        Text("The Name Of User is: $Email"),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              cubit.signOut(context);
                            },
                            child: Text('SignOut'))
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
