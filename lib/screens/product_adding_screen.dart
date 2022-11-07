
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProductAddingScreen extends StatefulWidget {
  ProductAddingScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddingScreen> createState() => _ProductAddingScreenState();
}

class _ProductAddingScreenState extends State<ProductAddingScreen> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  TextEditingController pricectr = TextEditingController();
  TextEditingController productnamectr = TextEditingController();
  TextEditingController productdesripctr = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? imageurl;
  bool isclickable=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * .35,
              color: Colors.indigo[100],
              child: GestureDetector(
                  onTap: () {
                    SnackBar snackbar = SnackBar(
                        backgroundColor: Colors.indigo[100],
                        duration: Duration(seconds: 6),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  if (photo != null) {
                                    imageFile = File(photo.path);
                                  }
                                });
                              },
                              child: Text('camera'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.indigo[900]),
                                foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                var image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  if (image != null) {
                                    imageFile = File(image.path);
                                  }
                                });
                              },
                              child: Text('Gallery'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.indigo[900]),
                                foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                              ),
                            ),
                          ],
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          scale: 5,
                          image: imageFile == null
                              ? AssetImage(
                            'assets/images/add.png',
                          )
                              : FileImage(imageFile!) as ImageProvider),
                    ),
                  )),
            ),
            SizedBox(height: size.height * .03),
            Center(
              child: Container(
                  width: size.width * .9,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * .07),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: pricectr,
                        decoration: InputDecoration(
                            labelText: 'Price',
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.currency_rupee,
                              color: Colors.indigo[900],
                            )),
                      ),
                    ),
                  )),
            ),
            SizedBox(height: size.height * .03),
            Center(
              child: Container(
                  width: size.width * .9,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * .07),
                      child: TextField(
                        controller: productnamectr,
                        decoration: InputDecoration(
                          labelText: 'Name of the Product',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )),
            ),
            SizedBox(height: size.height * .03),
            Center(
              child: Container(
                  width: size.width * .9,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: size.width * .07),
                      child: TextField(
                        maxLength: 45,
                        controller: productdesripctr,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )),
            ),
            SizedBox(height: size.height * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.indigo[100]),
                        foregroundColor:
                        MaterialStatePropertyAll(Colors.black)),
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: () => isclickable==true?sendData():null,
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.indigo[900])),
                    child: Text('Post')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future sendData() async {
    isclickable=false;
    if (productnamectr.text != '' &&
        pricectr.text != '' &&
        productdesripctr.text != '') {
      final imageStorage = FirebaseStorage.instance.ref().child('images${productnamectr.text}');
      print(imageFile!.path);
      var uploadimage =await imageStorage.putFile(imageFile!);
      imageurl = await imageStorage.getDownloadURL();
      print(imageurl);
      FirebaseFirestore.instance.collection('products').add({
        'name': productnamectr.text,
        'price': pricectr.text,
        'description': productdesripctr.text,
        'imageUrl':imageurl,
      });
      Navigator.of(_scaffoldKey.currentContext!).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product successfully uploaded'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter all details'),
        ),
      );
    }
    isclickable=true;
  }
}
