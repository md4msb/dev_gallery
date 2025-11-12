// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeveloperModelAdapter extends TypeAdapter<DeveloperModel> {
  @override
  final int typeId = 0;

  @override
  DeveloperModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeveloperModel(
      username: fields[0] as String,
      avatarUrl: fields[1] as String,
      name: fields[2] as String?,
      bio: fields[3] as String?,
      followers: fields[4] as int?,
      following: fields[5] as int?,
      publicRepos: fields[6] as int?,
      isFavorite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DeveloperModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.avatarUrl)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.bio)
      ..writeByte(4)
      ..write(obj.followers)
      ..writeByte(5)
      ..write(obj.following)
      ..writeByte(6)
      ..write(obj.publicRepos)
      ..writeByte(7)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeveloperModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
