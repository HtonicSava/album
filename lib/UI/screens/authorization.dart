import 'package:album/UI/icons/app_icons.dart';
import 'package:album/bloc/authorization/authorization_bloc.dart';
import 'package:album/bloc/authorization/authorization_event.dart';
import 'package:album/bloc/authorization/authorization_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authorization extends StatefulWidget {
  final VoidCallback onTapped;

  const Authorization({Key? key, required this.onTapped}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<
        Authorization> //TODO динамическая передача введённых данных в бд
    with
        SingleTickerProviderStateMixin {
  TabController? _tabController;
  late bool _passwordVisible;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _tryLogin(String logConText, String pasConText,AuthorizationBloc bloc){

    if (logConText != '' && pasConText != ''){
      bloc.add(AuthorizationEventLogin(login: logConText, password: pasConText));
    } else {
      Fluttertoast.showToast(
          msg: "Введите логин и пароль",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,

          fontSize: 16.0
      );
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthorizationBloc _authorizationBloc =
        BlocProvider.of<AuthorizationBloc>(context);
    _authorizationBloc.add(const AuthorizationEventCheckCurrentUser());
    return Scaffold(
      //Скролл при появлении клавиатуры от инпута
      body: BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: (BuildContext context, state) {
          if (state is AuthorizationStateAuthorizated) {
            widget.onTapped();
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: const Color(0xFFFFFFFF),
                  // height: MediaQuery.of(context).size.height / 4,
                  height: 200,
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
                            padding: const EdgeInsets.fromLTRB(0, 52, 0, 0),
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 52),
                                        child: Container(
                                          decoration:
                                              const BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                              spreadRadius: -20,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ]),
                                          child: TextField(
                                            controller: _loginController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
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
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Container(
                                          decoration:
                                              const BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                              spreadRadius: -20,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ]),
                                          child: TextField(
                                            controller: _passwordController,
                                            obscureText: !_passwordVisible,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(_passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                  onPressed: () {
                                                    setState(() {
                                                      _passwordVisible =
                                                          !_passwordVisible;
                                                    });
                                                  },
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                hintText: "Пароль",
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.black12),
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            'Забыли пароль?',
                                            style: TextStyle(
                                              color: Color(0xFF303030),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9),
                                            child: Container(
                                              height: 40.0,
                                              width: 40.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFDEDEDE),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11)),
                                              ),
                                              child: const Icon(
                                                MyFlutterApp.iconGoogle,
                                                color: Color(0xFF5F5F5F),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9),
                                            child: Container(
                                              height: 40.0,
                                              width: 40.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFDEDEDE),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(11)),
                                              ),
                                              child: const Icon(
                                                MyFlutterApp.iconVK,
                                                size: 18,
                                                color: Color(0xFF5F5F5F),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // TODO вынести кнопку в отдельный файл
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 40,
                                        ),
                                        child: SizedBox(
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
                                            onPressed: () => _tryLogin(_loginController.text, _passwordController.text, _authorizationBloc),
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFFBDBBBE),
                                                      Color(0xFF9D9EA3),
                                                    ]),
                                                // gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Вход',
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 52),
                                        child: Container(
                                          decoration:
                                              const BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                              spreadRadius: -20,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ]),
                                          child: TextField(
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                hintText: "Телефон",
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Container(
                                          decoration:
                                              const BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                              spreadRadius: -20,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ]),
                                          child: TextField(
                                            obscureText: false,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                hintText: "Имя пользователя",
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Container(
                                          decoration:
                                              const BoxDecoration(boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                              spreadRadius: -20,
                                              blurRadius: 20,
                                              offset: Offset(0,
                                                  20), // changes position of shadow
                                            ),
                                          ]),
                                          child: TextField(
                                            obscureText: !_passwordVisible,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(_passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                  onPressed: () {
                                                    setState(() {
                                                      _passwordVisible =
                                                          !_passwordVisible;
                                                    });
                                                  },
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                filled: true,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                hintText: "Пароль",
                                                fillColor: Colors.white),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 9),
                                              child: Container(
                                                height: 40.0,
                                                width: 40.0,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFDEDEDE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(11)),
                                                ),
                                                child: const Icon(
                                                  MyFlutterApp.iconGoogle,
                                                  color: Color(0xFF5F5F5F),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 9),
                                              child: Container(
                                                height: 40.0,
                                                width: 40.0,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFDEDEDE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(11)),
                                                ),
                                                child: const Icon(
                                                  MyFlutterApp.iconVK,
                                                  size: 18,
                                                  color: Color(0xFF5F5F5F),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // TODO вынести кнопку в отдельный файл
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 40,
                                        ),
                                        child: SizedBox(
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
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg: "Регистрация временно недоступна",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,

                                                  fontSize: 16.0
                                              );
                                            },
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFFBDBBBE),
                                                      Color(0xFF9D9EA3),
                                                    ]),
                                                // gradient: LinearGradient(colors: [Colors.red, Colors.yellow]),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  'Регистрация',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(top: 50.0),
                                        child: RichText(
                                          text: const TextSpan(
                                            text:
                                                'Продолжая, вы соглашаетесь с положениями ',
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'условий пользовательского соглашения и соглашения о конфиденциальности',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ),
                      ),
                      //Top part
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
                                  offset: Offset(
                                      0, 21), // changes position of shadow
                                ),
                              ],
                              //TabBar color
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                            ),
                            child: TabBar(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 47),
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
          ),
        ),
      ),
    );
  }
}
