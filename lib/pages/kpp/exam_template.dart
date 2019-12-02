import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class ExamTemplate extends StatefulWidget {
  final snapshot;
  final index;

  ExamTemplate({
    this.snapshot,
    this.index,
  });

  @override
  _ExamTemplateState createState() => _ExamTemplateState();
}

class _ExamTemplateState extends State<ExamTemplate> {
  var snapshotData;
  int totalQuestion;
  String question;
  Image questionImage;

  List<dynamic> questionOption = [];
  List<dynamic> answer = [];

  String correctAnswer;

  @override
  void initState() {
    super.initState();

    snapshotData = widget.snapshot.data[widget.index]['TheoryQuestion'];

    setState(() {
      totalQuestion = widget.snapshot.data.length;
      question = snapshotData['question'];

      if (snapshotData['question_photo'] != null)
        questionImage = snapshotData['question_photo'];

      for (var i = 0; i <= 4; i++) {
        String roman;

        if (i == 0)
          roman = 'i.';
        else if (i == 1)
          roman = 'ii.';
        else if (i == 2)
          roman = 'iii.';
        else if (i == 3)
          roman = 'iv.';
        else if (i == 4) roman = 'v.';

        if (snapshotData['question_option_$i'] != null)
          questionOption.add('$roman ${snapshotData["question_option_$i"]}');
        else if (snapshotData['question_option_$i'] == null &&
            snapshotData['question_option_${i}_photo'] != null)
          questionOption
              .add('$roman ${snapshotData["question_option_${i}_photo"]}');
      }

      for (var i = 0; i <= 4; i++) {
        String type;

        if (i == 0)
          type = 'a';
        else if (i == 1)
          type = 'b';
        else if (i == 2)
          type = 'c';
        else if (i == 3)
          type = 'd';
        else if (i == 4) type = 'e';

        if (snapshotData['option_$type'] != null)
          answer.add(snapshotData['option_$type']);
        else if (snapshotData['option_$type'] == null &&
            snapshotData['option_${type}_photo'] != null)
          answer.add(snapshotData['option_${type}_photo']);
      }

      correctAnswer = snapshotData['answer'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[],
    );
  }
}
