import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:product_selling_app/constants/constants.dart';
import 'package:product_selling_app/screens/home_page.dart';
import 'package:product_selling_app/screens/product_screen.dart';
import 'package:product_selling_app/widgets/reusable_textfield.dart';
import '../widgets/reusable_button.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, required bool this.isitlogin}) : super(key: key);
  bool isitlogin;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[100]!, Colors.blue[500]!],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomCenter,
            stops: [0, 0.5, 1],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: SizedBox(
                width: size.width * .6,
                height: size.height * .35,
                child: Lottie.asset(
                  'assets/animations/product.json',
                ),
              ),
            ),
            Align(
              alignment: Alignment(-1, -0.85),
              child: Container(
                width: size.width * .17,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue[200]),
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.indigo[900],
                    )),
              ),
            ),
            Column(
              children: [
                SizedBox(height: size.height * .3),
                Text(
                  widget.isitlogin == true ? 'Welcome Back' : 'Register',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 45,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.isitlogin == true
                      ? 'Login to Your account '
                      : 'Create your account',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .1,
                      ),
                      UsableTextField(
                          hintText: 'Email',
                          isitHide: false,
                          txtctr: Constants.emailctr),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      UsableTextField(
                          hintText: 'Password',
                          isitHide: true,
                          txtctr: Constants.passwordctr),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .5),
                        child: Text(
                          widget.isitlogin == true ? 'Forgot Password?' : '',
                          style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: SizedBox(
                height: size.height * .18,
                width: size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      child: SignButton(
                        clr: Colors.indigo[900]!,
                        text: widget.isitlogin == true ? 'SIGN IN' : 'SIGN UP',
                        txtclr: Colors.white,
                        fn: sign,
                      ),
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          )),
                    ),
                    SizedBox(
                      height: size.height * .035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isitlogin == true
                              ? 'Don\'t have an account?  '
                              : 'Already have an account?  ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                        GestureDetector(
                          child: Text(
                            widget.isitlogin == true ? 'Sign Up' : 'Sign In',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.double),
                          ),
                          onTap: () {
                            setState(() {
                              widget.isitlogin = !widget.isitlogin;
                            });
                            ;
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sign() {
    print("${widget.isitlogin},${Constants.emailctr.text},");
    if (widget.isitlogin != true) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: Constants.emailctr.text,
              password: Constants.passwordctr.text)
          .then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(),
              ),
            ),
          );
    } else {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: Constants.emailctr.text,
              password: Constants.passwordctr.text)
          .then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(),
              ),
            ),
          );
    }
  }
}
