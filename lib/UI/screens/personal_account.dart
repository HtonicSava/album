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
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalAccount extends StatelessWidget {
  final ValueSetter onAlbumTapped;
  final VoidCallback onAccountExit;
  final VoidCallback onThemeChangerTapped;

  const PersonalAccount(
      {Key? key,
      required this.onAlbumTapped,
      required this.onAccountExit,
      required this.onThemeChangerTapped})
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
              // TextButton(
              //     onPressed: () =>
              //         {onThemeChangerTapped(), Navigator.pop(context)},
              //     child: const Text('Сменить тему'))
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
        ),
        child: Container(
          // color: Colors.white,
          // height: 58,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child:

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
            //     ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Container(
            //         width: 40,
            //         height: 40,
            //         decoration: BoxDecoration(
            //             color: Theme.of(context)
            //                 .bottomNavigationBarTheme
            //                 .selectedIconTheme!
            //                 .color,
            //             shape: BoxShape.circle),
            //         child: const Icon(
            //           Icons.add,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
            //     ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
            //     ),
            //   ],
            // ),
            BottomNavigationBar(
              // enableFeedback: false,
              type: BottomNavigationBarType.fixed,
              // iconSize: 30,
              // backgroundColor: Colors.transparent,
              backgroundColor: Colors.white,
              items:  <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
                  label: 'ЛК',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
                  label: 'ЛК',
                ),
                BottomNavigationBarItem(
                  // icon: Icon(Icons.add),
                  icon: Container(
                    width: 54,
                    height: 54,
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
                const BottomNavigationBarItem(
                  icon: Icon(IconData(0xe958, fontFamily: 'MaterialIcons')),
                  label: 'ЛК',
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocListener<AuthorizationBloc, AuthorizationState>(
        listener: (BuildContext context, state) {
          if (state is AuthorizationStateUserRemoved) {
            onAccountExit();
          }
        },
        child: Container(
          // padding: const EdgeInsets.only(top: 8.0),
          color: Theme.of(context).colorScheme.primary,
          child: Container(
            //TODO Вынести 290 в отдельную переменную
            // height: MediaQuery.of(context).size.height - 290 + 125,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height - 290,
              height: MediaQuery.of(context).size.height,

              child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
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
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListView.separated(
                                // primary: false,
                                // physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: _albums!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => {onAlbumTapped(index)},
                                    child: AlbumPreview(
                                      albumPagesNumber:
                                          _albums![index].sheetsNumber,
                                      albumName: _albums![index].name,
                                      albumCoverLink:
                                          _albums![index].coverAlbumLink,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 12);
                                },
                              ),
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
      ),
    );
  }
}
