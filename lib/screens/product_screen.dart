import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_selling_app/screens/home_page.dart';
import 'package:product_selling_app/widgets/nav_bar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(elevation: 0, backgroundColor: Colors.indigo[900], actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      )));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),)
      ],leading: null,title: Text('TOP SALES'),centerTitle: true),
      bottomNavigationBar: NavBar(),
    );
  }
}
