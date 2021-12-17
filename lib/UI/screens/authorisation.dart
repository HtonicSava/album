import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Authorisation extends StatefulWidget {
  const Authorisation({Key? key}) : super(key: key);

  @override
  _AuthorisationState createState() => _AuthorisationState();
}

class _AuthorisationState extends State<Authorisation>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: const Color(0xFFFFFFFF),
            height: MediaQuery.of(context).size.height / 4,
            child: const Center(
                // TODO добавить лого
                ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  child: Container(
                    color: const Color(0xAAE5E5E5),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
                      child: TabBarView(
                        children: [
                          const Center(child: Text('Авторизация')),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 52),
                                child: Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      spreadRadius: -20,
                                      blurRadius: 20,
                                      offset: Offset(0,
                                          20), // changes position of shadow
                                    ),
                                  ]),
                                  child: TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]),
                                        hintText:
                                            "Телефон или имя пользователя",
                                        fillColor: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      spreadRadius: -20,
                                      blurRadius: 20,
                                      offset: Offset(0,
                                          20), // changes position of shadow
                                    ),
                                  ]),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(IconData(0xe51c, fontFamily: 'MaterialIcons')),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                        ),
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]),
                                        hintText:
                                        "Пароль",
                                        fillColor: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                        controller: _tabController,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                        // color: Color(0xAAE5E5E5),
                        ),
                    child: Container(
                      clipBehavior: Clip.none,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            spreadRadius: -8,
                            blurRadius: 20,
                            offset: Offset(0, 21), // changes position of shadow
                          ),
                        ],
                        //TabBar color
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: TabBar(
                        padding: const EdgeInsets.symmetric(horizontal: 47),
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                        indicatorColor: Colors.black,
                        tabs: const [
                          Tab(
                            child: Text(
                              'Вход',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Регистрация',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
