import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductView extends StatefulWidget {
  ProductView(
      {Key? key,
      this.image,
      this.Colors,
      this.Navigate,
      this.data,
      required this.height,
      required this.width})
      : super(key: key);

  final double raduisPadding = 8.0;
  final double raduisButton = 10.0;
  double height = 100;
  double width = 100;
  final Image? image;
  final Color? Colors;
  final VoidCallback? Navigate;
  final String? data;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          width: widget.width,
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
          "${widget.data}",
          // semanticsLabel: data,
          style: GoogleFonts.kanit(),
        )
      ],
    );
  }
}
