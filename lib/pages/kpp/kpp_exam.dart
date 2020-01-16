import 'package:epandu/app_localizations.dart';
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
  String message = '';
  final customDialog = CustomDialog();

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

      return customDialog.show(
        context: context,
        title: Center(child: Icon(Icons.info_outline, size: 120)),
        content:
            '${AppLocalizations.of(context).translate("existing_session")} ${data.groupId} ${data.paperNo}. ${AppLocalizations.of(context).translate("existing_session_two")}',
        customActions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('yes_lbl')),
            onPressed: () {
              groupId = data.groupId;
              paperNo = data.paperNo;

              Navigator.pop(context);

              _getExamQuestions();
            },
          ),
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('no_lbl')),
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
      context: context,
      groupId: groupId,
      paperNo: paperNo,
    );

    if (result.isSuccess) {
      setState(() {
        message = '';
        snapshot = result.data;
      });
    } else {
      setState(() {
        message = result.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
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
                )
        ],
      ),
    );
  }
}
