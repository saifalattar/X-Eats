import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/States.dart';
import 'package:xeats/controllers/Cubits/AuthCubit/cubit.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Dio/Cache_Helper.dart';
import 'package:xeats/controllers/States.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Xeatscubit()..Email(),
      child: BlocConsumer<Xeatscubit, XeatsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = Xeatscubit.get(context);
            var Email = cubit.EmailInforamtion;

            return SafeArea(
              child: FutureBuilder(
                future: cubit.getEmail(context, email: Email),
                builder: (context, AsyncSnapshot snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.hasData) {
                    return Scaffold(
                      body: Column(
                        children: [
                          Text(
                              "The Name Of User is: ${snapshot.data[0]['email']}"),
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
                  }

                  return Center(child: Loading());
                },
              ),
            );
          }),
    );
  }
}
