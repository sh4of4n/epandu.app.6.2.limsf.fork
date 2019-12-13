import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionOptions extends StatelessWidget {
  final List<String> questionOption;
  final List<Uint8List> image;

  QuestionOptions({this.questionOption, this.image});

  final TextStyle _questionOptionStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: GridView.builder(
        // padding: EdgeInsets.only(bottom: 10.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 5),
          mainAxisSpacing: 15.0,
        ),
        itemCount: questionOption.length,
        itemBuilder: (BuildContext context, int index) {
          if (questionOption.length > 0 && image.length > 0) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Text(questionOption[index], style: _questionOptionStyle),
                  SizedBox(width: 10.0),
                  Image.memory(
                    image[index],
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            );
          } else if (questionOption.length > 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(questionOption[index], style: _questionOptionStyle),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
