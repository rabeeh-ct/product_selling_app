import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * .35,
            color: Colors.indigo[100],
            child: PageView(
              children: [
                GestureDetector(
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
                                  final XFile? image = await _picker.pickImage(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
