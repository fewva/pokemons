import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final bool showBackArrow;
  final String title;

  CustomAppBar(
    {
      this.showBackArrow = false,
      this.title
    }
  );
  @override
  final Size preferredSize = Size(double.infinity, 56);
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: showBackArrow,
      title: Text(title)
    );
  }
}