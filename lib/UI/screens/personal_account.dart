import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalAccount extends StatelessWidget {

  final ValueSetter onAlbumTapped;

  const PersonalAccount({Key? key, required this.onAlbumTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.notifications,
            ),
          ),
        ],
        title: const Text('Личный кабинет'),
        foregroundColor: const Color(0xFFA5A5A5),
        backgroundColor: const Color(0xFFDDDDDD),
      ),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 8.0),
          color: const Color(0xFFE5E5E5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 290,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  // fit: StackFit.expand,
                  alignment: Alignment.center,
                  // clipBehavior: Clip.none,
                  children: [
                    const Positioned(
                      top: 12,
                      right: 20.0,
                      // left: 10,
                      child: Icon(
                        Icons.settings,
                        color: Color(0xFFA5A5A5),
                      ),
                    ),
                    Positioned(
                      child: Column(
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            child: Text(
                              "Олегов Олег Олегович",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            child: Text(
                              "oleg@oleg.com",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "+7 800 555 35 35",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //TODO Вынести 290 в отдельную переменную

                // height: MediaQuery.of(context).size.height - 290 + 125,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 23, top: 12, bottom: 28),
                            child: Text(
                              "Мои альбомы",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 20,
                            top: -20,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Icon(Icons.add),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(const CircleBorder()),
                                padding:
                                    MaterialStateProperty.all(const EdgeInsets.all(20)),
                                foregroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.8)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFA5A5A5)), // <-- Button color
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.white10;
                                  } // <-- Splash color
                                }),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height - 290,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => {
                                    onAlbumTapped(index)
                                  },
                                  child: SizedBox(
                                    // width: 231,
                                    height: 380,
                                    child: Column(
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Название альбома',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '15 стр.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFFA5A5A5)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFE4E4E4),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 12);
                              },
                              itemCount: 5),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 24,
                    //   ),
                    //   child: SizedBox(
                    //     width: 292,
                    //     height: 65,
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         padding: EdgeInsets.zero,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30.0),
                    //         ),
                    //       ),
                    //       onPressed: () {},
                    //       child: Ink(
                    //         decoration: BoxDecoration(
                    //           gradient: const LinearGradient(colors: [
                    //             Color(0xFFBDBBBE),
                    //             Color(0xFF9D9EA3),
                    //           ]),
                    //           // gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
                    //           borderRadius: BorderRadius.circular(30.0),
                    //         ),
                    //         child: Container(
                    //           alignment: Alignment.center,
                    //           child: const Text(
                    //             'Создать альбом',
                    //             style: TextStyle(
                    //               fontSize: 18,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
