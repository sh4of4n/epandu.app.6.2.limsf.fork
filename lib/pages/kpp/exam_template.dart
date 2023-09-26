import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/kpp/question_options.dart';
import 'package:epandu/common_library/services/model/kpp_model.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class ExamTemplate extends StatefulWidget {
  final snapshot;
  final index;
  final groupId;
  final paperNo;

  const ExamTemplate(
      {super.key, this.snapshot, this.index, this.groupId, this.paperNo});

  @override
  _ExamTemplateState createState() => _ExamTemplateState();
}

class _ExamTemplateState extends State<ExamTemplate> {
  var snapshotData;
  final examDataBox = Hive.box('exam_data');
  KppExamData? kppExamData;
  final customSnackbar = CustomSnackbar();
  final customDialog = CustomDialog();

  int index = 0; // Added from local index
  int? totalQuestion;
  String? question;
  Uint8List? questionImage;

  List<String> roman = [];
  List<String?> questionOption = []; // I) II) III) IV) V)
  List<Uint8List> questionOptionImage = []; // Image in question option

  List<String> type = []; // answer letter
  List<dynamic> answers = [];
  List<Uint8List> answersImage = [];

  String? correctAnswer;
  int correct = 0; // number of correct answers selected
  int incorrect = 0; // number of incorrect answers selected

  final TextStyle _questionStyle =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final TextStyle _clockStyle =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400);

  // Used for answers
  final TextStyle _answerStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);

  double answerWidthText =
      ScreenUtil().screenWidth / (ScreenUtil().screenHeight / 5);
  double answerWidthImg =
      ScreenUtil().screenWidth / (ScreenUtil().screenHeight / 2);

  late Timer _timer;
  int minute = 45;
  int second = 00;

  final List<Color> _answerColor = [];
  late int _correctIndex;
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
              title: Text(
                  AppLocalizations.of(context)!.translate('expired_title')),
              content: AppLocalizations.of(context)!.translate('exam_expired'),
              customActions: <Widget>[
                TextButton(
                  child:
                      Text(AppLocalizations.of(context)!.translate('ok_btn')),
                  onPressed: () {
                    // Hive box must be cleared here
                    examDataBox.clear();

                    context.router.pop();
                    context.router.pop();
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
      final data = examDataBox.getAt(examDataBox.length - 1) as KppExamData?;
      // final selectedAnswerIndex = examDataBox.getAt(index)
      //     as KppExamData; // get Question 1 selected answer
      // _checkSelectedAnswer(selectedAnswerIndex.answerIndex, 'next');

      setState(() {
        index = data!.examQuestionNo! + 1; // move to latest question
        correct += data.correct!;
        incorrect += data.incorrect!;
        minute = int.tryParse(data.minute!)!;
        second = int.tryParse(data.second!)!;
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
      question = snapshotData[index].question;

      if (snapshotData[index].questionPhoto != null) {
        questionImage = base64Decode(snapshotData[index].questionPhoto);
      }

      for (var i = 0; i <= 4; i++) {
        if (i == 0) {
          roman.add('I)');
        } else if (i == 1)
          roman.add('II)');
        else if (i == 2)
          roman.add('III)');
        else if (i == 3)
          roman.add('IV)');
        else if (i == 4) roman.add('V.');

        // Add question options and question options image
        switch (i) {
          case 0:
            if (snapshotData[index].questionOption1 != null) {
              questionOption.add(snapshotData[index].questionOption1);
            }

            if (snapshotData[index].questionOption1Photo != null) {
              questionOptionImage
                  .add(base64Decode(snapshotData[index].questionOption1Photo));
            }
            break;
          case 1:
            if (snapshotData[index].questionOption2 != null) {
              questionOption.add(snapshotData[index].questionOption2);
            }

            if (snapshotData[index].questionOption2Photo != null) {
              questionOptionImage
                  .add(base64Decode(snapshotData[index].questionOption2Photo));
            }
            break;
          case 2:
            if (snapshotData[index].questionOption3 != null) {
              questionOption.add(snapshotData[index].questionOption3);
            }

            if (snapshotData[index].questionOption3Photo != null) {
              questionOptionImage
                  .add(base64Decode(snapshotData[index].questionOption3Photo));
            }
            break;
          case 3:
            if (snapshotData[index].questionOption4 != null) {
              questionOption.add(snapshotData[index].questionOption4);
            }

            if (snapshotData[index].questionOption4Photo != null) {
              questionOptionImage
                  .add(base64Decode(snapshotData[index].questionOption4Photo));
            }
            break;
          case 4:
            if (snapshotData[index]?.questionOption5 != null) {
              questionOption.add(snapshotData[index].questionOption5);
            }

            if (snapshotData[index]?.questionOption5Photo != null) {
              questionOptionImage
                  .add(base64Decode(snapshotData[index].questionOption5Photo));
            }
            break;
        }
      }

      for (var i = 0; i <= 4; i++) {
        if (i == 0) {
          type.add('a');
        } else if (i == 1)
          type.add('b');
        else if (i == 2)
          type.add('c');
        else if (i == 3)
          type.add('d');
        else if (i == 4) type.add('e');

        switch (i) {
          case 0:
            if (snapshotData[index].optionA != null &&
                snapshotData[index].optionAPhoto == null) {
              answers.add(snapshotData[index].optionA);
            } else if (snapshotData[index].optionA == null &&
                snapshotData[index].optionAPhoto != null) {
              answers.add(
                base64Decode(
                  snapshotData[index].optionAPhoto,
                ),
              );

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionAPhoto,
                ),
              );
            } else if (snapshotData[index].optionA != null &&
                snapshotData[index].optionAPhoto != null) {
              answers.add(snapshotData[index].optionA);

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionAPhoto,
                ),
              );
            }
            break;
          case 1:
            if (snapshotData[index].optionB != null &&
                snapshotData[index].optionBPhoto == null) {
              answers.add(snapshotData[index].optionB);
            } else if (snapshotData[index].optionB == null &&
                snapshotData[index].optionBPhoto != null) {
              answers.add(
                base64Decode(
                  snapshotData[index].optionBPhoto,
                ),
              );

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionBPhoto,
                ),
              );
            } else if (snapshotData[index].optionB != null &&
                snapshotData[index].optionBPhoto != null) {
              answers.add(snapshotData[index].optionB);

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionBPhoto,
                ),
              );
            }
            break;
          case 2:
            if (snapshotData[index].optionC != null &&
                snapshotData[index].optionCPhoto == null) {
              answers.add(snapshotData[index].optionC);
            } else if (snapshotData[index].optionC == null &&
                snapshotData[index].optionCPhoto != null) {
              answers.add(
                base64Decode(
                  snapshotData[index].optionCPhoto,
                ),
              );

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionCPhoto,
                ),
              );
            } else if (snapshotData[index].optionC != null &&
                snapshotData[index].optionCPhoto != null) {
              answers.add(snapshotData[index].optionC);

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionCPhoto,
                ),
              );
            }
            break;
          case 3:
            if (snapshotData[index].optionD != null &&
                snapshotData[index].optionDPhoto == null) {
              answers.add(snapshotData[index].optionD);
            } else if (snapshotData[index].optionD == null &&
                snapshotData[index].optionDPhoto != null) {
              answers.add(
                base64Decode(
                  snapshotData[index].optionDPhoto,
                ),
              );

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionDPhoto,
                ),
              );
            } else if (snapshotData[index].optionD != null &&
                snapshotData[index].optionDPhoto != null) {
              answers.add(snapshotData[index].optionD);

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionDPhoto,
                ),
              );
            }
            break;
          case 4:
            if (snapshotData[index].optionE != null &&
                snapshotData[index].optionEPhoto == null) {
              answers.add(snapshotData[index].optionE);
            } else if (snapshotData[index].optionE == null &&
                snapshotData[index].optionEPhoto != null) {
              answers.add(
                base64Decode(
                  snapshotData[index].optionEPhoto,
                ),
              );

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionEPhoto,
                ),
              );
            } else if (snapshotData[index].optionE != null &&
                snapshotData[index].optionEPhoto != null) {
              answers.add(snapshotData[index].optionE);

              answersImage.add(
                base64Decode(
                  snapshotData[index].optionEPhoto,
                ),
              );
            }
            break;
        }
      }

      correctAnswer = snapshotData[index].answer;
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
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Image.memory(
        questionImage!,
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(420.w, 45.h),
              backgroundColor: const Color(0xffdd0e0e),
              padding: const EdgeInsets.symmetric(vertical: 11.0),
              shape: const StadiumBorder(),
              textStyle: const TextStyle(color: Colors.white),
            ),
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
                  message: AppLocalizations.of(context)!
                      .translate('first_page_desc'),
                  type: MessageType.TOAST,
                );
              }
            },
            child: Text(
              AppLocalizations.of(context)!.translate('prev_btn'),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(56),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(420.w, 45.h),
              backgroundColor: const Color(0xffdd0e0e),
              padding: const EdgeInsets.symmetric(vertical: 11.0),
              shape: const StadiumBorder(),
              textStyle: const TextStyle(color: Colors.white),
            ),
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
                    context.router.replace(
                      KppResult(data: kppExamData),
                    );

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
                  message: AppLocalizations.of(context)!
                      .translate('select_answer_desc'),
                  type: MessageType.TOAST,
                );
              }
            },
            child: Text(
              AppLocalizations.of(context)!.translate('next_btn'),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(56),
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
        context.router.pop();
      },
    );
  }

  Future<bool> _showExitDialog() async {
    return await CustomDialog().show(
      context: context,
      title: Text(AppLocalizations.of(context)!.translate('warning_title')),
      content: AppLocalizations.of(context)!.translate('confirm_exit_desc'),
      customActions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.translate('yes_lbl')),
          onPressed: () async {
            _timer.cancel();
            await examDataBox.clear();
            if (!context.mounted) return;
            context.router.pop(true);
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.translate('no_lbl')),
          onPressed: () {
            context.router.pop(false);
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
    required answers,
    answersImage,
    correctAnswer,
    type,
  }) {
    int? itemCount;

    if (answers.length > 0) {
      itemCount = answers.length;
    } else if (answers.length == 0 && answersImage.length > 0)
      itemCount = answersImage.length;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int answerIndex) {
        if (answers[answerIndex] is String && answersImage.isEmpty) {
          return InkWell(
            onTap: () => _checkSelectedAnswer(answerIndex, 'selected'),
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                /* border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ), */
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
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
              margin: const EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                /* border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ), */
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 3.0),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('${type[answerIndex]}. '),
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
              margin: const EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: _answerColor[answerIndex],
                /* border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ), */
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
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
                  const SizedBox(height: 8.0),
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
        return const SizedBox.shrink();
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
        physics: const BouncingScrollPhysics(),
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
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    question!,
                    style: _questionStyle,
                  ),
                ),
                // Question Image
                questionImage != null
                    ? _questionImage()
                    : const SizedBox.shrink(),
                // Question options I, II, III, IV, V
                questionOption.isNotEmpty
                    ? QuestionOptions(
                        roman: roman,
                        questionOption: questionOption,
                        image: questionOptionImage,
                      )
                    : const SizedBox.shrink(),
                // Answers a, b, c, d, e
                answers.isNotEmpty || answersImage.isNotEmpty
                    ? _answers(
                        answers: answers,
                        answersImage: answersImage,
                        correctAnswer: correctAnswer,
                        type: type)
                    : const SizedBox.shrink(),
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
