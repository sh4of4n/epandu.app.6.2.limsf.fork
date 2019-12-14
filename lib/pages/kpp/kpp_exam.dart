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
  String groupId;
  String paperNo;
  var snapshot;

  @override
  void initState() {
    super.initState();

    _checkExistingExam();
  }

  _checkExistingExam() async {
    await Hive.openBox('exam_data');

    // Check existing KPP exam
    final examDataBox = Hive.box('exam_data');
    KppExamData data;

    if (examDataBox.length > 0) {
      data = examDataBox.getAt(0) as KppExamData;

      return CustomDialog().show(
        context: context,
        title: Center(child: Icon(Icons.info_outline, size: 120)),
        content:
            'You have an existing session at ${data.groupId} ${data.paperNo}. Would you like to restore it?',
        customActions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              groupId = data.groupId;
              paperNo = data.paperNo;

              Navigator.pop(context);

              _getExamQuestions();
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              groupId = widget.data.groupId;
              paperNo = widget.data.paperNo;
              // Hive box must be cleared here
              examDataBox.clear();

              Navigator.pop(context);

              _getExamQuestions();
            },
          ),
        ],
        type: DialogType.GENERAL,
        barrierDismissable: false,
      );
    } else {
      groupId = widget.data.groupId;
      paperNo = widget.data.paperNo;

      _getExamQuestions();
    }

    // await _getExamQuestions();
  }

  _getExamQuestions() async {
    var result = await kppRepo.getExamQuestions(
      groupId: groupId,
      paperNo: paperNo,
    );

    if (result.isSuccess) {
      setState(() {
        snapshot = result.data['TheoryQuestion'];
      });
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
          snapshot != null
              ? ExamTemplate(
                  snapshot: snapshot,
                  index: index,
                  groupId: groupId,
                  paperNo: paperNo,
                )
              : Center(
                  child: SpinKitFoldingCube(
                    color: primaryColor,
                  ),
                ),
        ],
      ),
    );
  }
}
