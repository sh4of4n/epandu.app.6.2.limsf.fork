import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionOptions extends StatelessWidget {
  final List<String>? roman;
  final List<String?>? questionOption;
  final List<Uint8List>? image;

  QuestionOptions({this.roman, this.questionOption, this.image});

  final TextStyle _questionOptionStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: _renderQuestionOption(),
    );
  }

  // image with description
  _renderQuestionOption() {
    if (questionOption!.length > 0 &&
        questionOption![0]!.length > 4 &&
        image!.length > 0)
      return _renderConditionAndImage();
    // image without description
    else if (questionOption!.length > 0 && image!.length > 0)
      return _renderRomanAndImage();
    // no image
    else if (questionOption!.length > 0 && image!.length == 0)
      return _renderConditions();

    return SizedBox.shrink();
  }

  _renderConditionAndImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListView.builder(
        // padding: EdgeInsets.only(bottom: 10.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          // mainAxisSpacing: 15.0,
        ), */
        itemCount: questionOption!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(15.0),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10.0,
              children: <Widget>[
                Text(roman![index], style: _questionOptionStyle),
                LimitedBox(
                  maxWidth: ScreenUtil().setWidth(300),
                  maxHeight: ScreenUtil().setHeight(300),
                  child: Image.memory(
                    image![index],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(800),
                  alignment: Alignment.center,
                  child:
                      Text(questionOption![index]!, style: _questionOptionStyle),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _renderRomanAndImage() {
    return GridView.builder(
      // padding: EdgeInsets.only(bottom: 10.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.7,
        // mainAxisSpacing: 15.0,
      ),
      itemCount: questionOption!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Row(
            children: <Widget>[
              Text(questionOption![index]!, style: _questionOptionStyle),
              SizedBox(width: 5.0),
              LimitedBox(
                maxWidth: ScreenUtil().setWidth(470),
                maxHeight: ScreenUtil().setHeight(580),
                child: Image.memory(
                  image![index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _renderConditions() {
    return GridView.builder(
      // padding: EdgeInsets.only(bottom: 10.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.1,
        // mainAxisSpacing: 15.0,
      ),
      itemCount: questionOption!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(questionOption![index]!, style: _questionOptionStyle),
        );
      },
    );
  }
}
