import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:http/http.dart';

class CategoriesView extends StatelessWidget {
  final String? image;
  final String? category;
  final String? categoryId;
  final String? restaurantName;

  const CategoriesView(
    this.restaurantID, {
    required this.image,
    required this.category,
    required this.categoryId,
    required this.restaurantName,
  });

  final String? restaurantID;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Xeatscubit(),
      child: BlocBuilder<Xeatscubit, XeatsStates>(
        builder: ((context, state) {
          return Scaffold(
            appBar: appBar(context, subtitle: restaurantName, title: category),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder(
                future: Xeatscubit.get(context).getCurrentProducts(context,
                    restaurantName: restaurantName,
                    id: restaurantID,
                    CatId: categoryId,
                    image: image,
                    category: category),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return Loading();
                  }
                }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
