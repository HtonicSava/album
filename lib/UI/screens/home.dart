// import 'album_redactor.dart';
import 'package:album/UI/screens/authorisation.dart';
import 'package:album/UI/screens/personal_account.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: const Authorisation(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe48d, fontFamily: 'MaterialIcons')),
              label: 'ЛК',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xf04e, fontFamily: 'MaterialIcons')),

              label: 'Новости',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),

              label: 'Избранное',
            ),
          ],

        ),
    );
  }
}
