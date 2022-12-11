import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      width: width / 1.5,
      height: height / 13,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivering to',
                style: GoogleFonts.kanit(fontSize: 11, color: Colors.grey),
              ),
              Text(
                'Shiekh Zayed (Nile University)',
                style: GoogleFonts.kanit(fontSize: 13),
              ),
            ]),
      ),
    );
  }
}
