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
      year: fields[0] as int,
      course: fields[1] as String,
      semester: fields[2] as int,
      subject: fields[3] as String,
      term: fields[4] as String,
      filePath: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalPaper obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.course)
      ..writeByte(2)
      ..write(obj.semester)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.term)
      ..writeByte(5)
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
