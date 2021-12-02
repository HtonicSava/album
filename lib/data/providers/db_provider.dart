import 'dart:io';
import 'package:album/data/models/album.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AlbumDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Album ("
          "id INTEGER PRIMARY KEY,"
          "sheetWidth DOUBLE,"
          "sheetHeight DOUBLE,"
          "sheets TEXT"
          ")");
      await db.execute(
          "INSERT INTO Album ('id', 'sheetWidth', 'sheetHeight', 'sheets')  values (?, ?, ?, ?)",
          [
            1,
            600.0,
            800.0,
            """  
            [
              [
                {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
                {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'filled': false},
              ],
              [
                {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
                {'width': 0.5, 'height': 0.2, 'top': 0.4, 'left': 0.5, 'filled': false},
                {'width': 0.5, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'filled': false},
              ],
              [
                {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2, 'filled': false},
                {'width': 0.3, 'height': 0.2, 'top': 0.1, 'left': 0.8, 'filled': false},
              ],
              [
                {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.0, 'filled': false},
                {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5, 'filled': false},
                {'width': 0.9, 'height': 0.2, 'top': 0.0, 'left': 1.0, 'filled': false},
              ],
             ]
             """,
          ]);
    });
  }

  Future<List<Album>> getAllProducts() async {
    final db = await database;
    List<Map> results = await db!.query(
        "Album", columns: Album.columns, orderBy: "id ASC"
    );
    List<Album> products = [];
    results.forEach((result) {
      Album product = Album.fromMap(result);
      products.add(product);
    });
    // print(results);
    return products;
  }
}
