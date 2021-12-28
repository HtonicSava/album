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

