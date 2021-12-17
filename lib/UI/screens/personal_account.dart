
import 'package:flutter/material.dart';

class PersonalAccount extends StatelessWidget {
  const PersonalAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE5E5E5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Text(
                  "Олегов Олег Олегович",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.3), fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Text(
                  "oleg@oleg.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.3), fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  "+7 800 555 35 35",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.3), fontSize: 14),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(

              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius:
                BorderRadius.only( topLeft: Radius.circular(30), topRight:  Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 23, top: 12, bottom: 8),
                      child: Text(
                        "Мои альбомы",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18),
                      ),
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
                            decoration: const BoxDecoration(
                              color: Color(0xFFE4E4E4),
                              borderRadius:
                              BorderRadius.all(Radius.circular(16)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 12);
                        },
                        itemCount: 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                    ),
                    child: SizedBox(
                      width: 292,
                      height: 65,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFBDBBBE),
                              Color(0xFF9D9EA3),
                            ]),
                            // gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Создать альбом',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
