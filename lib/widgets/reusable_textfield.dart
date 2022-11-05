import 'package:flutter/material.dart';

class UsableTextField extends StatelessWidget {
  UsableTextField(
      {Key? key,
      required String this.hintText,
      required bool this.isitHide,
      required TextEditingController this.txtctr})
      : super(key: key);
  String hintText;
  bool isitHide;
  TextEditingController txtctr;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * .9,
        height: size.height * 0.07,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .07),
            child: TextField(
              controller: txtctr,
              obscureText: isitHide,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ));
  }
}
