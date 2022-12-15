import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewProducts extends StatefulWidget {
  NewProducts({
    Key? key,
    this.image,
    this.Colors,
    this.Navigate,
    required this.title,
  }) : super(key: key);

  final double raduisPadding = 8.0;
  final double raduisButton = 10.0;
  final String title;
  final Image? image;
  final Color? Colors;
  final VoidCallback? Navigate;

  @override
  State<NewProducts> createState() => _NewProductsState();
}

class _NewProductsState extends State<NewProducts> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.15;
    double height = MediaQuery.of(context).size.height / 4;
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          child: Padding(
            padding: EdgeInsets.all(widget.raduisPadding),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.Colors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.raduisButton)))),
                onPressed: widget.Navigate,
                child: widget.image),
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
