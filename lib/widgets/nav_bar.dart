import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:product_selling_app/screens/product_adding_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIndex: 1,
      activeIcons: [
        Icon(
          Icons.person,
        ),
        IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductAddingScreen(),
                )),
            icon: Icon(Icons.add, color: Colors.white, size: 30)),
        Icon(Icons.menu_rounded),
      ],
      inactiveIcons: const [
        Text(""),
        Text(""),
        Text(""),
      ],
      height: 60,
      circleWidth: 60,
      color: Colors.indigo[900]!,
    );
  }
}
