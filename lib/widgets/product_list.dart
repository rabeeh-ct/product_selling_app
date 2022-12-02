import 'package:flutter/material.dart';

import '../screens/individual_product_screen.dart';

class ProductList extends StatelessWidget {
  ProductList(
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
    return Padding(
      padding: EdgeInsets.only(
          bottom: size.height * .01,
          top: size.height * .01,
          left: size.width * .03,
          right: size.width * .03),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualProductScreen(description: description,imageUrl: imageUrl,price: price,productName: productName),));
        },
        child: Container(
          // height: size.height * .3,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * .02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: size.height * .17,
                    width: double.infinity,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(height: size.height*.01,),
                Text(
                  productName.toUpperCase(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: size.height*.005,),
                Text(
                  '₹ ${price}',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height*.005,),
                Text(
                  overflow: TextOverflow.ellipsis,
                  description,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
