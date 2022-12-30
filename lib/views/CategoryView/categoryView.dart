import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xeats/controllers/Components/AppBarCustomized.dart';
import 'package:xeats/controllers/Components/Components.dart';
import 'package:xeats/controllers/Components/Global%20Components/loading.dart';
import 'package:xeats/controllers/Cubit.dart';
import 'package:xeats/controllers/Cubits/ButtomNavigationBarCubit/navigationCubit.dart';
import 'package:xeats/controllers/States.dart';
import 'package:xeats/views/Layout/Layout.dart';
import 'package:xeats/views/Profile/Profile.dart';

class CategoriesView extends StatelessWidget {
  final String? image;
  final String? category;
  final String? categoryId;
  final String? restaurantName;

  const CategoriesView(
    this.restaurantID, {
    super.key,
    required this.image,
    required this.category,
    required this.categoryId,
    required this.restaurantName,
  });

  final String? restaurantID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Xeatscubit, XeatsStates>(
      builder: ((context, state) {
        var navcubit = NavBarCubitcubit.get(context);
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
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: GoogleFonts.poppins(),
            backgroundColor: Colors.white,
            items: navcubit.bottomitems,
            currentIndex: 1,
            onTap: (index) {
              Navigator.pop(context);
              if (index == 1) {
              } else if (index == 0) {
                Navigation(context, Layout());
              } else {
                Navigation(context, Profile());
              }
            },
          ),
        );
      }),
    );
  }
}
