import 'package:flutter/material.dart';

import 'chat_screen.dart';

class IndividualProductScreen extends StatelessWidget {
  IndividualProductScreen(
      {Key? key,
      required String this.productName,
      required String this.price,
      required String this.description,
      required String this.imageUrl})
      : super(key: key);
  String imageUrl;
  String productName;
  String description;
  String price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ChatScreen(frdUsername: 'hi', endUser: 'sdkc'),
          ));
        },
        child: Container(
            width: size.width * .2,
            height: size.height * .03,
            color: Colors.grey[300],
            child: Center(child: Text('Chat'))),
      ),
      appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.maybePop(context),
          ),
          elevation: 0,
          backgroundColor: Colors.indigo[900],
          title: Text(
            productName,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true),
      body: Column(children: [
        Container(
          width: double.infinity,
          height: size.height * .3,
          child: Image.network(
            // scale: 500,
            // width: 200,
            // cacheWidth: 100,
            imageUrl,
            fit: BoxFit.fitHeight,
          ),
        )
      ]),
    );
  }
}
