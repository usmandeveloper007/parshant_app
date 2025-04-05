import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
 final String text ;
  const CustomAppBar({super.key , required this.text});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
      centerTitle: true,
      backgroundColor: Colors.blue,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}

