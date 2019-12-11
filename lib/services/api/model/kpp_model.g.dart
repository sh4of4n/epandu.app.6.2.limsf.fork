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
      answerIndex: fields[1] as int,
      examQuestionNo: fields[2] as int,
      correct: fields[3] as int,
      incorrect: fields[4] as int,
      totalQuestions: fields[5] as int,
      examTime: fields[6] as String,
      groupId: fields[7] as String,
      paperNo: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KppExamData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.selectedAnswer)
      ..writeByte(1)
      ..write(obj.answerIndex)
      ..writeByte(2)
      ..write(obj.examQuestionNo)
      ..writeByte(3)
      ..write(obj.correct)
      ..writeByte(4)
      ..write(obj.incorrect)
      ..writeByte(5)
      ..write(obj.totalQuestions)
      ..writeByte(6)
      ..write(obj.examTime)
      ..writeByte(7)
      ..write(obj.groupId)
      ..writeByte(8)
      ..write(obj.paperNo);
  }
}
