import 'package:flutter/material.dart';
import 'sheet_template.dart';
// SheetTemplate()

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  final int sheets = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 150,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: sheets,
          itemBuilder: (context, index) {
            return SheetTemplate();
          },
          separatorBuilder: (context, index) {
            return SizedBox(width: 16);
          },
        ),
      ),
    );
  }
}
