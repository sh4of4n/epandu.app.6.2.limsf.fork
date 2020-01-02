import 'package:epandu/pages/kpp/question_options.dart';
import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/custom_snackbar.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../app_localizations.dart';

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
  KppExamData kppExamData;
  final customSnackbar = CustomSnackbar();
  final customDialog = CustomDialog();

  int index; // Added from local index
  int totalQuestion;
  String question;
  Uint8List questionImage;

  List<String> roman = [];
  List<String> questionOption = []; // I) II) III) IV) V)
  List<Uint8List> questionOptionImage = []; // Image in question option

  List<String> type = []; // answer letter
  List<dynamic> answers = [];
  List<Uint8List> answersImage = [];

  String correctAnswer;
  int correct = 0; // number of correct answers selected
  int incorrect = 0; // number of incorrect answers selected

  TextStyle _questionStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  TextStyle _clockStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400);

  // Used for answers
  TextStyle _answerStyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);

  double answerWidthText = ScreenUtil().width / (ScreenUtil().height / 5);
  double answerWidthImg = ScreenUtil().width / (ScreenUtil().height / 2);

  Timer _timer;
  int minute = 45;
  int second = 00;

  List<Color> _answerColor = [];
  int _correctIndex;
  bool selected = false; // if not selected, next button is hidden

  // ====

  @override
  void initState() {
    super.initState();

    snapshotData = widget.snapshot;

    setState(() {
      totalQuestion = widget.snapshot.length;
      index = widget.index;
    });

    _startTimer();
    _renderQuestion();
    _restoreSession();
  }

  // Todo: Optimize timer, it currently re-renders the entire page
  _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (minute > 0 && second == 0) {
            minute -= 1;
            second = 59;
          } else if (minute == 0 && second == 0) {
            timer.cancel();

            // close dialog
            customDialog.show(
              context: context,
              barrierDismissable: false,
              title:
                  Text(AppLocalizations.of(context).translate('expired_title')),
              content: AppLocalizations.of(context).translate('exam_expired'),
              customActions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('ok_btn')),
                  onPressed: () {
                    // Hive box must be cleared here
                    examDataBox.clear();

                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
              type: DialogType.GENERAL,
            );
          } else {
            second -= 1;
          }
        },
      ),
    );
  }

  _restoreSession() {
    if (examDataBox.length > 0) {
      final data = examDataBox.getAt(examDataBox.length - 1) as KppExamData;
      // final selectedAnswerIndex = examDataBox.getAt(index)
      //     as KppExamData; // get Question 1 selected answer
      // _checkSelectedAnswer(selectedAnswerIndex.answerIndex, 'next');

      setState(() {
        index = data.examQuestionNo + 1; // move to latest question
        correct += data.correct;
        incorrect += data.incorrect;
        minute = int.tryParse(data.minute);
        second = int.tryParse(data.second);
      });

      _clearCurrentQuestion();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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

        if (snapshotData[index]['question_option_${i}_photo'] != null)
          questionOptionImage.add(
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

        if (snapshotData[index]['option_${type[i]}'] != null &&
            snapshotData[index]['option_${type[i]}_photo'] == null) {
          answers.add(snapshotData[index]['option_${type[i]}']);
        } else if (snapshotData[index]['option_${type[i]}'] == null &&
            snapshotData[index]['option_${type[i]}_photo'] != null) {
          answers.add(
            base64Decode(
              snapshotData[index]['option_${type[i]}_photo'],
            ),
          );

          answersImage.add(
            base64Decode(
              snapshotData[index]['option_${type[i]}_photo'],
            ),
          );
        } else if (snapshotData[index]['option_${type[i]}'] != null &&
            snapshotData[index]['option_${type[i]}_photo'] != null) {
          answers.add(snapshotData[index]['option_${type[i]}']);

          answersImage.add(
            base64Decode(
              snapshotData[index]['option_${type[i]}_photo'],
            ),
          );
        }
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
      questionOptionImage.clear();
      answers.clear();
      answersImage.clear();
      questionImage = null;
      _answerColor.clear();
      selected = false;
    });

    _renderQuestion();
  }

  _questionImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Image.memory(
        questionImage,
        width: ScreenUtil().setWidth(500),
        height: ScreenUtil().setHeight(500),
      ),
    );
  }

  _prevButton() {
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
                if (index != 0) {
                  setState(() {
                    index -= 1;
                  });
                  _clearCurrentQuestion();

                  final data = examDataBox.getAt(index) as KppExamData;
                  _checkSelectedAnswer(data.answerIndex, 'back');
                } else {
                  return customSnackbar.show(
                    context,
                    message: AppLocalizations.of(context)
                        .translate('first_page_desc'),
                    type: MessageType.TOAST,
                  );
                }
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
                  'PREV',
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
                if (selected) {
                  setState(() {
                    if (index < snapshotData.length - 1) {
                      index += 1;
                      _clearCurrentQuestion();

                      // populate selected answer to question
                      if (index < examDataBox.length) {
                        final data = examDataBox.getAt(index) as KppExamData;
                        _checkSelectedAnswer(data.answerIndex, 'next');
                      }
                    } else {
                      Navigator.pushReplacementNamed(context, KPP_RESULT,
                          arguments: kppExamData);

                      // end timer
                      _timer.cancel();

                      // clear data once exam is completed
                      examDataBox.clear();
                    }
                    // _clearCurrentQuestion();
                  });
                } else {
                  return customSnackbar.show(
                    context,
                    duration: 1000,
                    message: AppLocalizations.of(context)
                        .translate('select_answer_desc'),
                    type: MessageType.TOAST,
                  );
                }
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
    return IconButton(
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        size: ScreenUtil().setSp(90),
      ),
      onPressed: () {
        _showExitDialog();
      },
    );
  }

  _showExitDialog() {
    return CustomDialog().show(
      context: context,
      title: Text(AppLocalizations.of(context).translate('warning_title')),
      content: AppLocalizations.of(context).translate('confirm_exit_desc'),
      customActions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('yes_lbl')),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);

            _timer.cancel();

            // Hive box must be cleared here
            examDataBox.clear();
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('no_lbl')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      type: DialogType.GENERAL,
    );
  }

  // Top bar
  _appBarTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        '${widget.groupId} ${widget.paperNo}',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(60), fontWeight: FontWeight.w600),
      ),
    );
  }

  _answers({
    answers,
    answersImage,
    correctAnswer,
    type,
  }) {
    int itemCount;

    if (answers.length > 0)
      itemCount = answers.length;
    else if (answers.length == 0 && answersImage.length > 0)
      itemCount = answersImage.length;

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int answerIndex) {
        if (answers[answerIndex] is String && answersImage.isEmpty) {
          return InkWell(
            onTap: () => _checkSelectedAnswer(answerIndex, 'selected'),
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                /* border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ), */
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 3.0),
                ],
              ),
              child: Text('${type[answerIndex]}. ${answers[answerIndex]}',
                  style: _answerStyle),
            ),
          );
        } else if (answers[answerIndex] is Uint8List &&
            answersImage[answerIndex] is Uint8List) {
          return InkWell(
            onTap: () => _checkSelectedAnswer(answerIndex, 'selected'),
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                /* border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ), */
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 3.0),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.memory(
                    answersImage[answerIndex],
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setHeight(300),
                  ),
                ],
              ),
            ),
          );
        } else if (answers[answerIndex] is String &&
            answersImage[answerIndex] is Uint8List) {
          return InkWell(
            onTap: () => _checkSelectedAnswer(answerIndex, 'selected'),
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                /* border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ), */
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 3.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(600),
                    child: Text('${type[answerIndex]}. ${answers[answerIndex]}',
                        textAlign: TextAlign.center, style: _answerStyle),
                  ),
                  SizedBox(height: 8.0),
                  LimitedBox(
                    maxWidth: ScreenUtil().setWidth(300),
                    maxHeight: ScreenUtil().setHeight(300),
                    child: Image.memory(
                      answersImage[answerIndex],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  _checkSelectedAnswer(answerIndex, status) {
    if (!selected) {
      if (type[answerIndex].toUpperCase() == correctAnswer) {
        // checks for correct answer
        setState(() {
          _answerColor[answerIndex] = Colors.green;
          selected = true; // if selected, next button appears
          if (status == 'selected') correct += 1;
          // _selectedIndex = index;
        });
      } else {
        setState(() {
          _answerColor[_correctIndex] = Colors.green;
          _answerColor[answerIndex] = Colors.red;
          selected = true;
          if (status == 'selected') incorrect += 1;
          // _selectedIndex = index;
        });
      }

      kppExamData = KppExamData(
        selectedAnswer: type[answerIndex], // not in use
        answerIndex: answerIndex,
        examQuestionNo: index,
        correct: correct,
        incorrect: incorrect,
        totalQuestions: snapshotData.length,
        groupId: widget.groupId,
        paperNo: widget.paperNo,
        minute: minute.toString(),
        second: second.toString(),
      );

      if (status == 'selected') {
        examDataBox.add(kppExamData);
      }
    }
  }

  Future<bool> _onWillPop() async {
    return _showExitDialog();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _backButton(),
                  _appBarTitle(),
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
                      horizontal: 20.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${minute < 10 ? '0$minute' : '$minute'}:${second < 10 ? '0$second' : '$second'}",
                        style: _clockStyle,
                      ),
                      // Text('$currentTime', style: _clockStyle),
                      Text('${index + 1}/${snapshotData.length}',
                          style: _clockStyle)
                    ],
                  ),
                ),
                // Question
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Text(
                    question,
                    style: _questionStyle,
                  ),
                ),
                // Question Image
                questionImage != null ? _questionImage() : SizedBox.shrink(),
                // Question options I, II, III, IV, V
                questionOption.length > 0
                    ? QuestionOptions(
                        questionOption: questionOption,
                        image: questionOptionImage,
                      )
                    : SizedBox.shrink(),
                // Answers a, b, c, d, e
                answers.length > 0 || answersImage.length > 0
                    ? _answers(
                        answers: answers,
                        answersImage: answersImage,
                        correctAnswer: correctAnswer,
                        type: type)
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _prevButton(),
              _nextButton(),
            ],
          ),
        ],
      ),
    );
  }
}
