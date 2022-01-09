import 'package:album/UI/widgets/sheet_natural_preview.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/sheet_preview.dart';

class AlbumPreview extends StatelessWidget {
  final int albumIndex;
  final ValueSetter onSheetTapped;

  const AlbumPreview({
    Key? key,
    required this.albumIndex,
    required this.onSheetTapped,
  }) : super(key: key);

  void _changeActiveNaturalSheet(
      BuildContext context, sheet, index, width, height) {
    BlocProvider.of<AlbumRedactorBloc>(context).add(
        GetAlbumRedactorNaturalSheet(
            sheet: sheet,
            sheetIndex: index,
            sheetWidth: width,
            sheetHeight: height));
  }

  @override
  Widget build(BuildContext context) {
    String _pageName;
    List? _sheets;
    late double _sheetsHeight;
    late double _sheetsWidth;
    late int _sheetIndex;

    final AlbumRedactorBloc _albumRedactorBloc =
        BlocProvider.of<AlbumRedactorBloc>(context);
    _albumRedactorBloc.add(GetTheAlbum(albumIndex));

    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
              bloc: _albumRedactorBloc,
              buildWhen: (previousState, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  _pageName = state.albumName;
                  return true;
                }

                return false;
              },
              builder: (context, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  _pageName = state.albumName;
                  return Text(_pageName);
                } else {
                  return const Text('Альбом');
                }


              })),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
              bloc: _albumRedactorBloc,
              //TODO Нужны ли одинаковые фрагменты кода внутри build и buildWhen?
              buildWhen: (previousState, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  _sheets = state.sheets;
                  _sheetsWidth = state.sheetsWidth;
                  _sheetsHeight = state.sheetsHeight;
                  _albumRedactorBloc.add(GetAlbumRedactorNaturalSheet(

                    sheet: _sheets![0],
                    sheetIndex: 0,
                    sheetHeight: _sheetsHeight,
                    sheetWidth: _sheetsWidth,
                  ));
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is AlbumRedactorUpdateAlbum) {
                  // print(sheets);
                  // print(state);
                  _pageName = state.albumName;
                  return SizedBox(
                      height: 150,
                      child: _sheets == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _sheets!.length,
                              itemBuilder: (context, index) {
                                return SheetPreview(
                                  photos: _sheets![index]['pages'],
                                  callback: () => {
                                    _changeActiveNaturalSheet(
                                        context,
                                        _sheets![index],
                                        index,
                                        _sheetsWidth,
                                        _sheetsHeight)
                                  },
                                  width: _sheetsWidth,
                                  height: _sheetsHeight,
                                  sheetCoverLink: _sheets![index]
                                      ['sheetCoverLink'],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 16);
                              },
                            ));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<AlbumRedactorBloc, AlbumRedactorState>(
              buildWhen: (previousState, state) {
                if (state is AlbumRedactorShowNaturalSheet) {
                  return true;
                }

                return false;
              },
              builder: (context, state) {
                if (state is AlbumRedactorShowNaturalSheet) {
                  _sheetIndex = state.sheetIndex;
                  return SheetNaturalPreview(
                    photos: state.sheet['pages'],
                    sheetIndex: state.sheetIndex,
                    sheetPropCoef: state.sheetWidth / state.sheetHeight,
                    albumIndex: albumIndex,
                    sheetName: state.sheet['name'],
                    sheetCoverLink: state.sheet['sheetCoverLink'],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SizedBox(
              // width: 292,
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  onSheetTapped(_sheetIndex);
                },
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
                      'Редактировать',
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
    )
        // )
        ;
  }
}
