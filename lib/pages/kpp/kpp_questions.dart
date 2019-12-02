import 'package:epandu/pages/kpp/exam_template.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class KppQuestions extends StatefulWidget {
  final data;

  KppQuestions(this.data);

  @override
  _KppQuestionsState createState() => _KppQuestionsState();
}

class _KppQuestionsState extends State<KppQuestions> {
  final kppRepo = KppRepo();
  final primaryColor = ColorConstant.primaryColor;
  int index = 0;

  _getExamQuestions() async {
    var result = await kppRepo.getExamQuestions(
      groupId: widget.data.groupId,
      paperNo: widget.data.paperNo,
    );

    if (result.isSuccess) {
      return result.data['TheoryQuestion'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: _getExamQuestions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ExamTemplate(
                snapshot: snapshot,
                index: index,
              );
            }
            return Center(
                child: SpinKitFoldingCube(
              color: primaryColor,
            ));
          }),
    );
  }
}
