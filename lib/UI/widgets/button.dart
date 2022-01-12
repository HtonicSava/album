import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback? onTapped;
  final String buttonText;

  const CustomButton({Key? key, this.onTapped, required this.buttonText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 292,
      height: 65,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(30.0),
          ),
        ),
        onPressed: onTapped,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [
                  Color(0xFFFAE4D4),
                  Color(0xFFDB8677),
                ]),
            // gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
            borderRadius:
            BorderRadius.circular(30.0),
          ),
          child: Container(
            alignment: Alignment.center,
            child:  Text(
              buttonText,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
