import 'package:hive/hive.dart';

part 'kpp_model.g.dart';

class KppModuleArguments {
  final groupId;
  final paperNo;

  KppModuleArguments({
    this.groupId,
    this.paperNo,
  });
}

@HiveType()
class KppExamData {
  @HiveField(0)
  final String selectedAnswer;

  @HiveField(1)
  final int answerIndex;

  @HiveField(2)
  final int examQuestionNo; // The index

  @HiveField(3)
  final int correct;

  @HiveField(4)
  final int incorrect;

  @HiveField(5)
  final int totalQuestions;

  @HiveField(6)
  final String second;

  @HiveField(7)
  final String minute;

  @HiveField(8)
  final String groupId;

  @HiveField(9)
  final String paperNo;

  KppExamData({
    this.selectedAnswer,
    this.answerIndex,
    this.examQuestionNo,
    this.correct,
    this.incorrect,
    this.totalQuestions,
    this.second,
    this.minute,
    this.groupId,
    this.paperNo,
  });
}
