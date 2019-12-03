import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:typed_data';

class Answers extends StatefulWidget {
  final answers;

  Answers({this.answers});

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  TextStyle _answerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

  double answerWidthText = ScreenUtil().width / (ScreenUtil().height / 5);
  double answerWidthImg = ScreenUtil().width / (ScreenUtil().height / 2);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            widget.answers[0] is String ? answerWidthText : answerWidthImg,
      ),
      itemCount: widget.answers.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.answers[index] is String) {
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1.0, color: Colors.black12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 5.0),
              ],
            ),
            child: Text(widget.answers[index], style: _answerStyle),
          );
        } else if (widget.answers[index] is Uint8List) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: Image.memory(widget.answers[index])),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
