import 'package:flutter/material.dart';
import 'package:product_selling_app/screens/sign_in_screen.dart';

class SignButton extends StatelessWidget {
  SignButton(
      {Key? key,
      required String this.text,
      required Color this.clr,
      required Color this.txtclr,
      required Function this.fn
      })
      : super(key: key);
  String text;
  Color clr;
  Color txtclr;
  Function fn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:  () {
        fn();
      },
      child: Container(
          width: size.width * .9,
          height: size.height * 0.07,
          decoration: BoxDecoration(
              color: clr, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: txtclr,
                  fontSize: size.width * .05,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
          )),
    );
  }
}
