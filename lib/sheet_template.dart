import 'package:flutter/material.dart';
import 'photo_placeholder.dart';

class SheetTemplate extends StatelessWidget {
  const SheetTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return AspectRatio(
      aspectRatio: 1/2,
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Stack(
            children: const [
              PhotoPlaceholder(width: 0.6, height: 0.2, top: 0.7, left: 0.2),
              PhotoPlaceholder(width: 0.6, height: 0.2, top: 0.4, left: 0.5),
              PhotoPlaceholder(width: 0.6, height: 0.2, top: 0.1, left: 0.8),
            ],
          ),
        ),
      ),
    );
  }
}
