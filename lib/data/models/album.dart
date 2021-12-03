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

// class Album {
//   const Album( { required this.id,required this.sheetWidth, required this.sheetHeight, required this.sheets});
//   final int id;
//   final double sheetWidth;
//   final double sheetHeight;
//   final String sheets;
//
//   static final columns = ["id", "sheetWidth", "sheetHeight", "sheets"];
//
//   factory Album.fromMap(Map<dynamic, dynamic> data){
//     return Album(id: data["id"], sheetWidth: data["sheetWidth"], sheetHeight: data["sheetHeight"], sheets: data["sheets"]);
//   }
//
//   Map<String, dynamic> toMap() => {
//     "id":id,
//     "sheetWidth": sheetWidth,
//     "sheetHeight": sheetHeight,
//     "sheets": sheets,
//   };
// }

class Album {
  const Album( { required this.id,required this.sheetWidth, required this.sheetHeight, required this.sheets});
  final int id;
  final double sheetWidth;
  final double sheetHeight;
  final String sheets;

  static final columns = ["id", "sheetWidth", "sheetHeight", "sheets"];

  factory Album.fromMap(Map<dynamic, dynamic> data){
    return Album(id: data["id"], sheetWidth: data["sheetWidth"], sheetHeight: data["sheetHeight"], sheets: data["sheets"]);
  }

  Map<String, dynamic> toMap() => {
    "id":id,
    "sheetWidth": sheetWidth,
    "sheetHeight": sheetHeight,
    "sheets": sheets,
  };
}









