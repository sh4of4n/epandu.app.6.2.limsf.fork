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

class PinRequest {
  String wsCodeCrypt;
  String caUid;
  String caPwd;
  String pinNumber;
  String diCode;
  String phone;
  String userId;
  String groupId;
  String courseCode;

  PinRequest({
    this.wsCodeCrypt,
    this.caUid,
    this.caPwd,
    this.pinNumber,
    this.diCode,
    this.phone,
    this.userId,
    this.groupId,
    this.courseCode,
  });

  PinRequest.fromJson(Map<String, dynamic> json) {
    wsCodeCrypt = json['wsCodeCrypt'];
    caUid = json['caUid'];
    caPwd = json['caPwd'];
    pinNumber = json['pinNumber'];
    diCode = json['diCode'];
    phone = json['phone'];
    userId = json['userId'];
    groupId = json['groupId'];
    courseCode = json['courseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wsCodeCrypt'] = this.wsCodeCrypt;
    data['caUid'] = this.caUid;
    data['caPwd'] = this.caPwd;
    data['pinNumber'] = this.pinNumber;
    data['diCode'] = this.diCode;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    data['groupId'] = this.groupId;
    data['courseCode'] = this.courseCode;
    return data;
  }
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
