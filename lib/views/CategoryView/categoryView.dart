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

  const CategoriesView(this.restaurantID, this.categoryId, this.name,
      {required this.image});

  final String? restaurantID, categoryId, name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Xeatscubit, XeatsStates>(
      builder: ((context, state) {
        return Scaffold(
          appBar: appBar(context),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FutureBuilder(
              future: Xeatscubit.get(context).getCurrentProducts(context,
                  id: restaurantID, CatId: categoryId, image: image),
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
    );
  }
}
