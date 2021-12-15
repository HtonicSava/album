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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Text(
                    "OLEG",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Text(
                    "Олегов Олег Олегович",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.3), fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Text(
                    "oleg@oleg.com",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.3), fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                  child: Text(
                    "+7 800 555 35 35",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.3), fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.teal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 23, top: 12, bottom: 8),
                    child: Text(
                      "Мои альбомы",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 231,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(

                            width: 231,
                            height: 231,
                            decoration: const BoxDecoration(color: Colors.orange,
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 12);
                        },
                        itemCount: 5),
                  ),
                  ElevatedButton(onPressed: (){}, child:
                    const Text('Создать альбом'),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
