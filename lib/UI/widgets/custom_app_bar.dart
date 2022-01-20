import 'package:flutter/material.dart';

class CustomAppBar extends AppBar{

  final String text;

  CustomAppBar({Key? key, required this.text}) : super(key: key) ;


  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
    );
  }
}
