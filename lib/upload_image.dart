import 'package:flutter/material.dart';

class UploadImagePage extends StatelessWidget {
  const UploadImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
      ),
    );
  }
}
