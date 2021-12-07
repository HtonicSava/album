// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 0;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album()
      ..sheetsWidth = fields[0] as double
      ..sheetsHeight = fields[1] as double
      ..sheets = (fields[2] as List)
          .map((dynamic e) => (e as List)
              .map((dynamic e) => (e as Map).cast<String, dynamic>())
              .toList())
          .toList();
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sheetsWidth)
      ..writeByte(1)
      ..write(obj.sheetsHeight)
      ..writeByte(2)
      ..write(obj.sheets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
