import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:typed_data';

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
  List<Icon> _answerIcon = [];
  int _correctIndex;
  // int _selectedIndex;
  bool selected = false;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.answers.length; i++) {
      _answerColor.add(Colors.white);
      _answerIcon.add(null);

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
          _answerIcon[index] = Icon(Icons.check_circle, color: Colors.blue);
          selected = true;
          // _selectedIndex = index;
        });
      } else {
        setState(() {
          _answerColor[_correctIndex] = Colors.green;
          _answerIcon[_correctIndex] =
              Icon(Icons.check_circle, color: Colors.blue);
          _answerColor[index] = Colors.red;
          _answerIcon[index] = Icon(Icons.cancel, color: Colors.grey);
          selected = true;
          // _selectedIndex = index;
        });
      }
    }
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${widget.type[index]}. ${widget.answers[index]}',
                      style: _answerStyle),
                  _answerIcon[index] ?? SizedBox.shrink(),
                ],
              ),
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
