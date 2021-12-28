import 'package:hive/hive.dart';
part 'hive_album.g.dart';

@HiveType(typeId: 0)
class Album extends HiveObject{
  @HiveField(0)
  late double sheetsWidth;
  @HiveField(1)
  late double sheetsHeight;
  @HiveField(2)
  late List sheets;
  @HiveField(3)
  late String name;
  @HiveField(4)
  late int sheetsNumber;
  @HiveField(5)
  late String coverAlbumLink;
}

// var Album ={
//   'sheetsWidth': 600,
//   'sheetsHeight': 800,
//   'sheets': [
//     [
//       {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
//       {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'filled': false},
//     ],
//     [
//       {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
//       {'width': 0.5, 'height': 0.2, 'top': 0.4, 'left': 0.5, 'filled': false},
//       {'width': 0.5, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'filled': false},
//     ],
//     [
//       {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
//     ],
//     [
//       {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
//       {'width': 0.3, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'filled': false},
//     ],
//     [
//       {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.0, 'filled': false},
//       {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5, 'filled': false},
//       {'width': 0.9, 'height': 0.2, 'top': 0.0, 'left': 1.0, 'filled': false},
//     ],
//   ]
// };