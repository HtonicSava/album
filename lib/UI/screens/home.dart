import 'album_redactor.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Онлайн альбом',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: const AlbumRedactor());
  }
}
