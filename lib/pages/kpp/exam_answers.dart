import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:typed_data';

class Answers extends StatefulWidget {
  final answers;
  final type;

  Answers({this.answers, this.type});

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  TextStyle _answerStyle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500);

  double answerWidthText = ScreenUtil().width / (ScreenUtil().height / 5);
  double answerWidthImg = ScreenUtil().width / (ScreenUtil().height / 2);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.answers.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.answers[index] is String) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              /* decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 1.0, color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 5.0),
                ],
              ), */
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
