import 'dart:io';

import 'package:album/UI/widgets/resizable_widget.dart';
import 'package:album/bloc/album_redactor/album_redactor_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogChoosingImage extends StatefulWidget {
  final AlbumRedactorShowPopupSheetRedactor stateBloc;

  const DialogChoosingImage({Key? key, required this.stateBloc})
      : super(key: key);

  @override
  DialogChoosingImageState createState() =>
      DialogChoosingImageState(this.stateBloc);
}

class DialogChoosingImageState extends State<DialogChoosingImage> {
  var _image;
  var imagePicker;
  var stateBloc;

  DialogChoosingImageState(this.stateBloc);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    print('init state');
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 1.0,

      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ResizableWidget(
              child: _image == null
                  ? Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img/gneg.jpeg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  : Image.file(
                      _image,
                      fit: BoxFit.fill,
                    )),
          IgnorePointer(
            ignoring: true,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: AspectRatio(
                  aspectRatio: stateBloc.props[0] * 0.5,
                  child: Container(
                    // color: Colors.white.withOpacity(0.1),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        backgroundBlendMode: BlendMode.lighten,
                        border: Border.all(
                            width: 3,
                            color: Colors.black.withOpacity(0.5),
                            style: BorderStyle.solid)),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // var source = ImageSource.gallery;
                  var _picker = ImagePicker();
                  XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(image!.path);
                  });
                },
                child: const Text(
                  "Загрузить из галереи",
                  style: TextStyle(color: Colors.white),
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
        ],
      ),
      // ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       widthFactor: 1.0,
//       heightFactor: 1.0,
//
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: AlignmentDirectional.bottomCenter,
//         children: [
//           ResizableWidget(
//             child: Center(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/img/gneg.jpeg'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           IgnorePointer(
//             ignoring: true,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               child: Center(
//                 child: AspectRatio(
//                   aspectRatio: stateBloc.props[0] * 0.5,
//                   child: Container(
//                     // color: Colors.white.withOpacity(0.1),
//                     decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         backgroundBlendMode: BlendMode.lighten,
//                         border: Border.all(
//                             width: 3,
//                             color: Colors.black.withOpacity(0.5),
//                             style: BorderStyle.solid)),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () async {
//                   var source = ImageSource.gallery;
//                   XFile image = await i
//                 },
//                 child: const Text(
//                   "Загрузить из галереи",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text(
//                   "Закрыть",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//       // ),
//     );
//   }
// }
