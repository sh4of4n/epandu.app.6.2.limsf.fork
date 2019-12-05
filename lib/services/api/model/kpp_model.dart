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
  final int examQuestionNo; // The index
  // final String examTime;

  KppExamData({
    this.selectedAnswer,
    this.examQuestionNo,
    // this.examTime,
  });
}
