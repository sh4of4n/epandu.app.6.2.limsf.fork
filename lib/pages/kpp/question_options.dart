import 'package:flutter/material.dart';
import 'dart:typed_data';

class QuestionOptions extends StatelessWidget {
  final questionOption;

  QuestionOptions({this.questionOption});

  final TextStyle _questionOptionStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 5),
      ),
      itemCount: questionOption.length,
      itemBuilder: (BuildContext context, int index) {
        if (questionOption[index] is String)
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(questionOption[index], style: _questionOptionStyle),
          );
        else if (questionOption[index] is Uint8List)
          return Center(child: Image.memory(questionOption[index]));

        return SizedBox.shrink();
      },
    );
  }
}
