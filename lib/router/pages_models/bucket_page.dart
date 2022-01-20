import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BucketPage extends StatelessWidget {
  const BucketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
            'Bucket'
        ),
      ),
      body: const Center(
        child: Text(
            'Корзина'
        ),
      ),
    );
  }
}
