import 'package:epandu/pages/kpp/question_options.dart';
import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class ExamTemplate extends StatefulWidget {
  final snapshot;
  final index;
  final groupId;
  final paperNo;

  ExamTemplate({this.snapshot, this.index, this.groupId, this.paperNo});

  @override
  _ExamTemplateState createState() => _ExamTemplateState();
}

class _ExamTemplateState extends State<ExamTemplate> {
  var snapshotData;
  final examDataBox = Hive.box('exam_data');

  int index; // Added from local index
  int totalQuestion;
  String question;
  Uint8List questionImage;

  List<String> roman = [];
  List<dynamic> questionOption = [];

  List<String> type = []; // answer letter
  List<dynamic> answers = [];

  List<int> selectedAnswerCorrect = [];
  List<int> selectedAnswerIncorrect = [];

  String correctAnswer;

  TextStyle _questionStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  TextStyle _clockStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400);

  // Used for answers
  TextStyle _answerStyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);

  double answerWidthText = ScreenUtil().width / (ScreenUtil().height / 5);
  double answerWidthImg = ScreenUtil().width / (ScreenUtil().height / 2);

  List<Color> _answerColor = [];
  int _correctIndex;
  // int _selectedIndex;
  bool selected = false; // if not selected, next button is hidden

  // ====

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
        else if (i == 4) roman.add('V.');

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

    _getCorrectAnswerIndex();
  }

  _getCorrectAnswerIndex() {
    for (var i = 0; i < answers.length; i++) {
      _answerColor.add(Colors.white);

      // save correct answer index
      if (type[i].toUpperCase() == correctAnswer) {
        setState(() {
          _correctIndex = i;
        });
      }
    }
  }

  _clearCurrentQuestion() {
    setState(() {
      questionOption.clear();
      answers.clear();
      questionImage = null;
      _answerColor.clear();
      selected = false;
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
                  }
                  _clearCurrentQuestion();
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

  _backButton() {
    return Platform.isAndroid
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: ScreenUtil().setSp(90),
            ),
            onPressed: () {
              if (index == 0)
                _showExitDialog();
              else {
                setState(() {
                  index -= 1;
                });
                _clearCurrentQuestion();
              }
            },
          )
        : IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtil().setSp(90),
            ),
            onPressed: () {
              if (index == 0)
                Navigator.pop(context);
              else {
                setState(() {
                  index -= 1;
                });
                _clearCurrentQuestion();
              }
            },
          );
  }

  Future<bool> _showExitDialog() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);

                  // Hive box must be cleared here
                  examDataBox.delete(index);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }

  // Top bar
  _examTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        '${widget.groupId} ${widget.paperNo}',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(70), fontWeight: FontWeight.w600),
      ),
    );
  }

  _answers({
    answers,
    correctAnswer,
    type,
  }) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (BuildContext context, int answerIndex) {
        if (answers[answerIndex] is String) {
          return InkWell(
            onTap: () => _checkSelectedAnswer(answerIndex),
            child: Container(
              // margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                // borderRadius: BorderRadius.circular(10.0),
                /* border: Border.all(width: 1.0, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 5.0),
                ], */
              ),
              child: Text('${type[index]}. ${answers[index]}',
                  style: _answerStyle),
            ),
          );
        } else if (answers[index] is Uint8List) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.memory(
                  answers[index],
                  width: ScreenUtil().setWidth(500),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  _checkSelectedAnswer(answerIndex) {
    if (!selected) {
      if (type[answerIndex].toUpperCase() == correctAnswer) {
        setState(() {
          _answerColor[answerIndex] = Colors.green;
          selected = true; // if selected, next button appears
          selectedAnswerCorrect.add(answerIndex);
          // _selectedIndex = index;
        });
      } else {
        setState(() {
          _answerColor[_correctIndex] = Colors.green;
          _answerColor[answerIndex] = Colors.red;
          selected = true;
          selectedAnswerCorrect.add(_correctIndex);
          selectedAnswerIncorrect.add(answerIndex);
          // _selectedIndex = index;
        });
      }

      KppExamData kppExamData = KppExamData(
        selectedAnswer: type[answerIndex],
        correctAnswerIndex: _correctIndex,
        incorrectAnswerIndex: answerIndex,
        examQuestionNo: index,
      );

      examDataBox.add(kppExamData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _backButton(),
                _examTitle(),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          /* decoration: BoxDecoration(
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
          ), */
          child: Column(
            children: <Widget>[
              // Timer, No of Questions
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
              // Question
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  question,
                  style: _questionStyle,
                ),
              ),
              // Question Image
              questionImage != null ? _questionImage() : SizedBox.shrink(),
              // Question options I, II, III, IV, V
              questionOption.length > 0
                  ? QuestionOptions(questionOption: questionOption)
                  : SizedBox.shrink(),
              // Answers a, b, c, d, e
              answers.length > 0
                  ? _answers(
                      answers: answers,
                      correctAnswer: correctAnswer,
                      type: type)
                  : SizedBox.shrink(),
            ],
          ),
        ),
        selected ? _nextButton() : SizedBox.shrink(),
      ],
    );
  }
}
