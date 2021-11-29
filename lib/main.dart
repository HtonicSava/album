import 'package:flutter/material.dart';
import 'UI/screens/home.dart';

void main() {
  runApp(const OnlineAlbum());
}

class OnlineAlbum extends StatelessWidget {
  const OnlineAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Онлайн альбом',
      home: Home(),
    );
  }
}
