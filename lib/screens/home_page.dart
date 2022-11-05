import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:product_selling_app/screens/sign_in_screen.dart';
import 'package:product_selling_app/widgets/reusable_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[500]!],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomCenter,
            stops: [0.4, 1],
          ),
        ),
        height: size.height,
        width: size.width,
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              alignment: Alignment(-0.8, -0.8),
              child: Text(
                'HELLO',
                style: TextStyle(
                    fontSize: size.width * .127,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
            ),
            Positioned(
              top: size.height * .165,
              child: Container(
                height: size.height * .5,
                width: size.width,
                child: Lottie.asset(
                  'assets/animations/product.json',
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.1,
              left: size.width * .05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignButton(
                    clr: Colors.indigo[900]!,
                    text: 'SIGN IN',
                    txtclr: Colors.white,
                    fn: signIN,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  SignButton(
                    clr: Colors.white,
                    text: 'SIGN UP',
                    txtclr: Colors.black,
                    fn: signUP,
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  signIN() {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(isitlogin: true),
        ));
  }

  signUP() {

    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(isitlogin: false),
        ));
  }
}
