import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionOptions extends StatelessWidget {
  final List<String>? roman;
  final List<String?>? questionOption;
  final List<Uint8List>? image;

  const QuestionOptions({super.key, this.roman, this.questionOption, this.image});

  final TextStyle _questionOptionStyle =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: _renderQuestionOption(),
    );
  }

  // image with description
  _renderQuestionOption() {
    if (questionOption!.isNotEmpty &&
        questionOption![0]!.length > 4 &&
        image!.isNotEmpty) {
      return _renderConditionAndImage();
    } else if (questionOption!.isNotEmpty && image!.isNotEmpty)
      return _renderRomanAndImage();
    // no image
    else if (questionOption!.isNotEmpty && image!.isEmpty)
      return _renderConditions();

    return const SizedBox.shrink();
  }

  _renderConditionAndImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListView.builder(
        // padding: EdgeInsets.only(bottom: 10.0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          // mainAxisSpacing: 15.0,
        ), */
        itemCount: questionOption!.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(15.0),
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              const SizedBox(width: 5.0),
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
