import 'package:epandu/pages/kpp/exam_template.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

class KppExam extends StatefulWidget {
  final data;

  KppExam(this.data);

  @override
  _KppExamState createState() => _KppExamState();
}

class _KppExamState extends State<KppExam> {
  final kppRepo = KppRepo();
  final primaryColor = ColorConstant.primaryColor;
  int index = 0;

  _getExamQuestions() async {
    await Hive.openBox('exam_data');

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
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        /* appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('${widget.data.groupId} ${widget.data.paperNo}'),
        ), */
        body: FutureBuilder(
            future: _getExamQuestions(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ExamTemplate(
                  snapshot: snapshot,
                  index: index,
                  groupId: widget.data.groupId,
                  paperNo: widget.data.paperNo,
                );
              }
              return Center(
                child: SpinKitFoldingCube(
                  color: Colors.lightBlue,
                ),
              );
            }),
      ),
    );
  }
}
