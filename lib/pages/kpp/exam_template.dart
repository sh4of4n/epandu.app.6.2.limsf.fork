import 'package:epandu/pages/kpp/question_options.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'exam_answers.dart';

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

  int index; // Added from local index
  int totalQuestion;
  String question;
  Uint8List questionImage;

  List<String> roman = [];
  List<dynamic> questionOption = [];

  List<String> type = []; // answer letter
  List<dynamic> answers = [];

  String correctAnswer;

  TextStyle _questionStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  TextStyle _clockStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400);

  @override
  void initState() {
    super.initState();

    snapshotData = widget.snapshot.data;

    setState(() {
      totalQuestion = widget.snapshot.data.length;
      index = widget.index;
    });

    _renderQuestion();
  }

  _renderQuestion() {
    setState(() {
      question = snapshotData[index]['question'];

      if (snapshotData[index]['question_photo'] != null)
        questionImage = base64Decode(snapshotData[index]['question_photo']);

      for (var i = 0; i <= 4; i++) {
        if (i == 0)
          roman.add('I)');
        else if (i == 1)
          roman.add('II)');
        else if (i == 2)
          roman.add('III)');
        else if (i == 3)
          roman.add('IV)');
        else if (i == 4) roman.add('v.');

        if (snapshotData[index]['question_option_$i'] != null)
          questionOption.add(snapshotData[index]['question_option_$i']);
        else if (snapshotData[index]['question_option_$i'] == null &&
            snapshotData[index]['question_option_${i}_photo'] != null)
          questionOption.add(
              base64Decode(snapshotData[index]['question_option_${i}_photo']));
      }

      for (var i = 0; i <= 4; i++) {
        if (i == 0)
          type.add('a');
        else if (i == 1)
          type.add('b');
        else if (i == 2)
          type.add('c');
        else if (i == 3)
          type.add('d');
        else if (i == 4) type.add('e');

        if (snapshotData[index]['option_${type[i]}'] != null)
          answers.add(snapshotData[index]['option_${type[i]}']);
        else if (snapshotData[index]['option_${type[i]}'] == null &&
            snapshotData[index]['option_${type[i]}_photo'] != null)
          answers.add(
            base64Decode(
              snapshotData[index]['option_${type[i]}_photo'],
            ),
          );
      }

      correctAnswer = snapshotData[index]['answer'];
    });
  }

  _nextQuestion() {
    setState(() {
      questionOption.clear();
      answers.clear();
      questionImage = null;
    });

    _renderQuestion();
  }

  _questionImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      child: Image.memory(
        questionImage,
        width: ScreenUtil().setWidth(600),
        height: ScreenUtil().setHeight(800),
      ),
    );
  }

  _nextButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonTheme(
            padding: EdgeInsets.all(0.0),
            shape: StadiumBorder(),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  if (index < snapshotData.length - 1) {
                    index += 1;

                    _nextQuestion();
                  }
                });
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.shade700, Colors.blue],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 15.0,
                ),
                child: Text(
                  'NEXT',
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(56),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2.0, 5.0),
                blurRadius: 4.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '0:00',
                      style: _clockStyle,
                    ),
                    Text('${index + 1}/${snapshotData.length}',
                        style: _clockStyle)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  question,
                  style: _questionStyle,
                ),
              ),
              questionImage != null ? _questionImage() : SizedBox.shrink(),
              questionOption.length > 0
                  ? QuestionOptions(questionOption: questionOption)
                  : SizedBox.shrink(),
            ],
          ),
        ),
        answers.length > 0 ? Answers(answers: answers) : SizedBox.shrink(),
        _nextButton(),
      ],
    );
  }
}
