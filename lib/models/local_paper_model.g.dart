// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_paper_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalPaperAdapter extends TypeAdapter<LocalPaper> {
  @override
  final int typeId = 1;

  @override
  LocalPaper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalPaper(
      uniqueId: fields[0] as String,
      year: fields[1] as int,
      course: fields[2] as String,
      semester: fields[3] as int,
      subject: fields[4] as String,
      term: fields[5] as String,
      filePath: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalPaper obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uniqueId)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.course)
      ..writeByte(3)
      ..write(obj.semester)
      ..writeByte(4)
      ..write(obj.subject)
      ..writeByte(5)
      ..write(obj.term)
      ..writeByte(6)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalPaperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
