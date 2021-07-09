// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KppExamDataAdapter extends TypeAdapter<KppExamData> {
  @override
  final int typeId = 0;

  @override
  KppExamData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KppExamData(
      selectedAnswer: fields[0] as String?,
      answerIndex: fields[1] as int?,
      examQuestionNo: fields[2] as int?,
      correct: fields[3] as int?,
      incorrect: fields[4] as int?,
      totalQuestions: fields[5] as int?,
      second: fields[6] as String?,
      minute: fields[7] as String?,
      groupId: fields[8] as String?,
      paperNo: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, KppExamData obj) {
    writer
      ..writeByte(10)
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
      ..write(obj.second)
      ..writeByte(7)
      ..write(obj.minute)
      ..writeByte(8)
      ..write(obj.groupId)
      ..writeByte(9)
      ..write(obj.paperNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KppExamDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
