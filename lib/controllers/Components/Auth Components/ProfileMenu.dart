import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xeats/controllers/Components/Global%20Components/DefaultButton.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          DefaultButton(
            function: press,
            text: '',
          ),
          Row(
            children: [
              SvgPicture.asset(
                icon,
                color: Colors.black,
                width: 22,
              ),
              SizedBox(width: 20),
              Expanded(child: Text(text)),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ],
      ),
    );
  }
}
