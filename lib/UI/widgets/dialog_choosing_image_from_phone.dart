import 'package:album/UI/widgets/resizable_widget.dart';
import 'package:album/bloc/album_redactor/album_redactor_bloc.dart';
import 'package:album/bloc/album_redactor/album_redactor_event.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogChoosingImage extends StatelessWidget {
  final AlbumRedactorShowPopupSheetRedactor state;


  const DialogChoosingImage({Key? key, required this.state}) : super(key: key);

  eventCloseTrigger(BuildContext context, proportion) {
    BlocProvider.of<AlbumRedactorBloc>(context)
        .add(GetAlbumRedactorPlaceholderProportion(proportion));
  }

  @override
  Widget build(BuildContext context) {
    return
      // Dialog(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //   elevation: 1,
      //   child:
      FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,

        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ResizableWidget(
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/gneg.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: state.props[0] * 0.5,
                    child: Container(
                      // color: Colors.white.withOpacity(0.1),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                        backgroundBlendMode: BlendMode.lighten,
                        border: Border.all(width: 3, color: Colors.black.withOpacity(0.5), style: BorderStyle.solid)
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                },
              child: const Text(
                "Закрыть",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        // ),
      );
  }

}
