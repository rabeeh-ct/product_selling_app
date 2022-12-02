import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_selling_app/screens/home_page.dart';
import 'package:product_selling_app/screens/product_adding_screen.dart';
import 'package:product_selling_app/widgets/nav_bar.dart';
import 'package:product_selling_app/widgets/product_list.dart';

import 'message_screen.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late PageController pgController;

  int pageIndex = 0;
  int navIndex = 0;

  @override
  void initState() {
    pgController = PageController(initialPage: pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigo[900],
          actions: [
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
              ),
            )
          ],
          leading: Icon(Icons.menu,color: Colors.white,),
          title: Text('TOP SALES',style: TextStyle(color: Colors.white)),
          centerTitle: true),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pgController,
        onPageChanged: (value) {
          navIndex = value;
          setState(() {});
        },
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                        width: size.width * .2,
                        height: size.width * .2,
                        child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.hasError.toString());
                } else {
                  var productList = snapshot.data!.docs;
                  return GridView.builder(
                    itemCount: productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: size.height*.32,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return ProductList(
                        productName: productList[index]['name'],
                        price: productList[index]['price'],
                        description: productList[index]['description'],
                        imageUrl: productList[index]['imageUrl'],
                      );
                    },
                  );
                }
              }),
          ProductAddingScreen(),
          MessageScreen(),
        ],
      ),
      bottomNavigationBar: CircleNavBar(
        activeIndex: navIndex,
        activeIcons: [
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.add, color: Colors.white, size: 30),
          Icon(Icons.message, color: Colors.white, size: 30),
        ],
        inactiveIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.message, color: Colors.white)
        ],
        height: 60,
        circleWidth: 60,
        color: Colors.indigo[900]!,
        onTab: (v) {
          print(v);
          setState(() {
            navIndex = v;
            pageIndex = v;
            pgController.jumpToPage(pageIndex);
          });
        },
      ),
    );
  }
}
