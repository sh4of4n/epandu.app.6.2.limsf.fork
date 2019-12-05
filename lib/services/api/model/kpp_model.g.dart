// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KppExamDataAdapter extends TypeAdapter<KppExamData> {
  @override
  KppExamData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KppExamData(
      selectedAnswer: fields[0] as String,
      examQuestionNo: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, KppExamData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.selectedAnswer)
      ..writeByte(1)
      ..write(obj.examQuestionNo);
  }
}
