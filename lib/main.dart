import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'UI/screens/home.dart';
import 'data/providers/db_provider.dart';

void main() async {

  await Hive.initFlutter();

  runApp(

      OnlineAlbum());
}

class OnlineAlbum extends StatelessWidget {
  const OnlineAlbum({Key? key, this.albums} ) : super(key: key);
  final albums;

  @override
  Widget build(BuildContext context)  {

    // SQLiteDbProvider.db.getAllProducts().then((value) => {print(value[0].sheets)});

    return const MaterialApp(
      title: 'Онлайн альбом',
      home: Home(),
    );
  }
}
