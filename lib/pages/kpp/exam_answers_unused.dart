import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:typed_data';

import 'package:hive/hive.dart';

// Required values to store:
// selected answer
// question number(index)

// When user goes to the next question,
// the selected answer from previous question must not be retained.
// When user goes back to the previous question,
// the selected answer from previous question must be restored.

class Answers extends StatefulWidget {
  final answers;
  final correctAnswer;
  final type;

  Answers({this.answers, this.correctAnswer, this.type});

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  TextStyle _answerStyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);

  double answerWidthText = ScreenUtil().width / (ScreenUtil().height / 5);
  double answerWidthImg = ScreenUtil().width / (ScreenUtil().height / 2);

  List<Color> _answerColor = [];
  int _correctIndex;
  // int _selectedIndex;
  bool selected = false; // if not selected, next button is hidden

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.answers.length; i++) {
      _answerColor.add(Colors.white);

      // save correct answer index
      if (widget.type[i].toUpperCase() == widget.correctAnswer) {
        setState(() {
          _correctIndex = i;
        });
      }
    }
  }

  _checkSelectedAnswer(index) {
    if (!selected) {
      if (widget.type[index].toUpperCase() == widget.correctAnswer) {
        setState(() {
          _answerColor[index] = Colors.green;
          selected = true; // if selected, next button appears
          // _selectedIndex = index;
        });
      } else {
        setState(() {
          _answerColor[_correctIndex] = Colors.green;
          _answerColor[index] = Colors.red;
          selected = true;
          // _selectedIndex = index;
        });
      }

      KppExamData kppExamData = KppExamData(
        selectedAnswer: widget.type[index],
        examQuestionNo: index,
      );
      _saveAnswer(kppExamData);
    }
  }

  _saveAnswer(KppExamData kppExamData) async {
    final examDataBox = Hive.box('exam_data');

    examDataBox.add(kppExamData);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.answers.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.answers[index] is String) {
          return InkWell(
            onTap: () => _checkSelectedAnswer(index),
            child: Container(
              // margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: _answerColor[index],
                // borderRadius: BorderRadius.circular(10.0),
                /* border: Border.all(width: 1.0, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 5.0),
                ], */
              ),
              child: Text('${widget.type[index]}. ${widget.answers[index]}',
                  style: _answerStyle),
            ),
          );
        } else if (widget.answers[index] is Uint8List) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.memory(
                  widget.answers[index],
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
}
