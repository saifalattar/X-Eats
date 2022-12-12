import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onSubmitted: (pattern) async {
          // if (app.search == SearchBy.PRODUCTS) {

          //   await productProvider.search(productName: pattern);
          //   Navigator.pushNamed(
          //     context,
          //     ProductSearchScreen.routeName,
          //   );
          // }
        },
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search For Restaaurants",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
