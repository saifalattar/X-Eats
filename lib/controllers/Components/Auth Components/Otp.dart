import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OTP extends StatefulWidget {
  OTP(
      {Key? key,
      required this.type,
      required this.action,
      required this.context,
      this.controller})
      : super(key: key);

  final TextEditingController? controller;
  final BuildContext context;
  final TextInputAction? action;
  final TextInputType type;

  Color background = Colors.blue;
  VoidCallback? onTap;
  BorderSide? bord;
  TextStyle? labelst;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textInputAction: widget.action,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isNotEmpty && value != "") {
            FocusScope.of(context).focusInDirection(TraversalDirection.right);
          }
        },
        controller: widget.controller,
        textAlign: TextAlign.center,
        keyboardType: widget.type,
        style: GoogleFonts.poppins(
            height: 1.5,
            color: Colors.black,
            textStyle: TextStyle(fontSize: 25)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue,
          prefixIconConstraints: BoxConstraints(maxWidth: 40, minWidth: 30),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.black, width: 4)),
          labelStyle: widget.labelst,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 4),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.background)),
        ),
      ),
    );
  }
}
