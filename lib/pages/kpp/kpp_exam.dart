import 'package:epandu/pages/kpp/exam_template.dart';
import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // String groupId;
  // String paperNo;

  _getExamQuestions() async {
    await Hive.openBox('exam_data');

    // Check existing KPP exam
    /* final examDataBox = Hive.box('exam_data');
    KppExamData data;

    if (examDataBox.length > 0) {
      data = examDataBox.getAt(0) as KppExamData;

      return CustomDialog().show(
        context: context,
        title: Center(child: Icon(Icons.info_outline)),
        content:
            'You have an existing session at ${data.groupId} ${data.paperNo}. Would you like to restore it?',
        customActions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              groupId = data.groupId;
              paperNo = data.paperNo;

              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              // Hive box must be cleared here
              examDataBox.clear();

              Navigator.pop(context);
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    } */

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
      backgroundColor: Colors.amber.shade50,
      /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('${widget.data.groupId} ${widget.data.paperNo}'),
      ), */
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              height: ScreenUtil().setHeight(1200),
            ),
          ),
          FutureBuilder(
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
                  color: primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
