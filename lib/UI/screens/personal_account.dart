import 'package:album/UI/widgets/album_preview.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:album/bloc/authorization/authorization_bloc.dart';
import 'package:album/bloc/authorization/authorization_event.dart';
import 'package:album/bloc/authorization/authorization_state.dart';
import 'package:album/data/models/hive_album.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalAccount extends StatelessWidget {
  final ValueSetter onAlbumTapped;
  final VoidCallback onAccountExit;
  final VoidCallback onThemeChangerTapped;


  const PersonalAccount(
      {Key? key, required this.onAlbumTapped, required this.onAccountExit, required this.onThemeChangerTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Билд личного кабинета');
    //TODO Почему при первом запуске билд 5 раз?
    List<Album>? _albums;
    final AlbumRedactorBloc _albumRedactorBloc =
        BlocProvider.of<AlbumRedactorBloc>(context);
    _albumRedactorBloc.add(const GetAlbums());
    final AuthorizationBloc _authorizationBloc =
        BlocProvider.of<AuthorizationBloc>(context);
    _authorizationBloc.add(const AuthorizationEventGetLogin());

    // SystemChrome.setSystemUIOverlayStyle(
    //      SystemUiOverlayStyle(
    //       statusBarColor: ThemeData.from(colorScheme: const ColorScheme.light()).appBarTheme.foregroundColor,
    //       // statusBarBrightness: Brightness.light,
    //     )
    // );

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              TextButton(
                  onPressed: () => {
                        _authorizationBloc.add(const AuthorizationEventExit()),
                        Navigator.pop(context),
                      },

                  child: const Text('Выход')),
              TextButton(
                  onPressed: () => {

                    onThemeChangerTapped(),
                    Navigator.pop(context)
                  },

                  child: const Text('Сменить тему'))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.notifications,
            ),
          ),
        ],
        title: const Text('Личный кабинет'),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child: BottomNavigationBar(

          // backgroundColor: Colors.transparent,
          backgroundColor: Colors.white,
          items:  <BottomNavigationBarItem>[

            // BottomNavigationBarItem(
            //   icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
            //   label: 'ЛК',
            // ),
            const BottomNavigationBarItem(
              icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
              label: 'ЛК',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.add),
              icon: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                    shape: BoxShape.circle
                ),
                child: const Icon(

                    Icons.add,
                    color: Colors.white,
                ),
              ),
              label: 'ЛК',
            ),
            const BottomNavigationBarItem(
              icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
              label: 'ЛК',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
            //   label: 'ЛК',
            // ),
          ],
        ),
      ),
      body: BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: (BuildContext context, state) {
          if (state is AuthorizationStateUserRemoved) {
            onAccountExit();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.only(top: 8.0),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.max,
              children: [
                // SizedBox(
                //   height: 300,
                //   width: MediaQuery.of(context).size.width,
                //   child: Stack(
                //     // fit: StackFit.expand,
                //     alignment: Alignment.center,
                //     // clipBehavior: Clip.none,
                //     children: [
                //       const Positioned(
                //         top: 12,
                //         right: 20.0,
                //         // left: 10,
                //         child: Icon(
                //           Icons.settings,
                //           color: Color(0xFFA5A5A5),
                //         ),
                //       ),
                //       Positioned(
                //         child: Column(
                //           children: [
                //             Container(
                //               margin:
                //                   const EdgeInsets.symmetric(vertical: 12.0),
                //               width: 150,
                //               height: 150,
                //               decoration: const BoxDecoration(
                //                   color: Colors.grey, shape: BoxShape.circle),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                //               child: BlocBuilder<AuthorizationBloc,
                //                       AuthorizationState>(
                //                   builder: (context, state) {
                //                 if (state is AuthorizationStateShowUserData) {
                //                   return Text(
                //                     state.login,
                //                     textAlign: TextAlign.center,
                //                     style: const TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 23),
                //                   );
                //                 } else {
                //                   return const Text(
                //                     'Загрузка...',
                //                     textAlign: TextAlign.center,
                //                     style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 23),
                //                   );
                //                 }
                //               }),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                //               child: Text(
                //                 "Олегов Олег Олегович",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     color: Colors.black.withOpacity(0.3),
                //                     fontSize: 14),
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                //               child: Text(
                //                 "oleg@oleg.com",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     color: Colors.black.withOpacity(0.3),
                //                     fontSize: 14),
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                //               child: Text(
                //                 "+7 800 555 35 35",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     color: Colors.black.withOpacity(0.3),
                //                     fontSize: 14),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 23, top: 12, bottom: 28),
                              child: Text(
                                "Мои альбомы",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   right: 20,
                          //   top: -20,
                          //   child: ElevatedButton(
                          //     onPressed: () {},
                          //     child: const Icon(Icons.add),
                          //     style: ButtonStyle(
                          //       shape: MaterialStateProperty.all(
                          //           const CircleBorder()),
                          //       padding: MaterialStateProperty.all(
                          //           const EdgeInsets.all(20)),
                          //       foregroundColor: MaterialStateProperty.all(
                          //           Colors.black.withOpacity(0.8)),
                          //       backgroundColor: MaterialStateProperty.all(
                          //           const Color(0xFFA5A5A5)),
                          //       // <-- Button color
                          //       overlayColor:
                          //           MaterialStateProperty.resolveWith<Color?>(
                          //               (states) {
                          //         if (states.contains(MaterialState.pressed)) {
                          //           return Colors.white10;
                          //         } // <-- Splash color
                          //       }),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        // height: MediaQuery.of(context).size.height - 290,
                        height: MediaQuery.of(context).size.height,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: BlocBuilder<AlbumRedactorBloc,
                                    AlbumRedactorState>(
                                bloc: _albumRedactorBloc,
                                buildWhen: (previousState, state) {
                                  if ((state is AlbumRedactorShowAlbums) &&
                                      (state.props != previousState.props)) {
                                    // _albums = state.albums;
                                    print("$state from buildWhen of Albums");

                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                builder: (context, state) {
                                  if (state is AlbumRedactorShowAlbums) {
                                    print("$state from builder of Albums");

                                    _albums = state.albums;
                                    return _albums == null
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ListView.separated(
                                            primary: false,
                                            scrollDirection: Axis.vertical,
                                            itemCount: _albums!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    {onAlbumTapped(index)},
                                                child: AlbumPreview(
                                                  albumPagesNumber:
                                                      _albums![index]
                                                          .sheetsNumber,
                                                  albumName:
                                                      _albums![index].name,
                                                  albumCoverLink:
                                                      _albums![index]
                                                          .coverAlbumLink,
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(height: 12);
                                            },
                                          );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
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
