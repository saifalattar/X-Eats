import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';

class CategoriesView extends StatelessWidget {
  final String? restaurantID, categoryId, name;
  const CategoriesView(this.restaurantID, this.categoryId, this.name,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Xeatscubit, XeatsStates>(builder: ((context, state) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 9, 134, 211),
            title: Center(
              child: Text("${this.name}"),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
                future: Xeatscubit.get(context).getCurrentProducts(context,
                    id: restaurantID, CatId: categoryId),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return Loading();
                  }
                })),
          ));
    }));
  }
}
