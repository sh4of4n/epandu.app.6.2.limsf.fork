import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/pages/kpp/exam_template.dart';
import 'package:epandu/common_library/services/model/kpp_model.dart';
import 'package:epandu/common_library/services/repository/kpp_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

class KppExam extends StatefulWidget {
  final String? groupId;
  final String? paperNo;

  KppExam({
    required this.groupId,
    required this.paperNo,
  });

  @override
  _KppExamState createState() => _KppExamState();
}

class _KppExamState extends State<KppExam> {
  final kppRepo = KppRepo();
  final primaryColor = ColorConstant.primaryColor;
  int index = 0;
  String? groupId;
  String? paperNo;
  var snapshot;
  String? message = '';
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
    KppExamData? data;

    if (examDataBox.length > 0) {
      data = examDataBox.getAt(0) as KppExamData?;

      return customDialog.show(
        context: context,
        title: Center(child: Icon(Icons.info_outline, size: 120)),
        content:
            '${AppLocalizations.of(context)!.translate("existing_session")} ${data!.groupId} ${data.paperNo}. ${AppLocalizations.of(context)!.translate("existing_session_two")}',
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('yes_lbl')),
            onPressed: () {
              groupId = data!.groupId;
              paperNo = data.paperNo;

              context.router.pop();

              _getTheoryQuestionByPaper();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('no_lbl')),
            onPressed: () {
              groupId = widget.groupId;
              paperNo = widget.paperNo;
              // Hive box must be cleared here
              examDataBox.clear();

              context.router.pop();

              _getTheoryQuestionByPaper();
            },
          ),
        ],
        type: DialogType.GENERAL,
        barrierDismissable: false,
      );
    } else {
      groupId = widget.groupId;
      paperNo = widget.paperNo;

      _getTheoryQuestionByPaper();
    }

    // await _getTheoryQuestionByPaper();
  }

  _getTheoryQuestionByPaper() async {
    var result = await kppRepo.getTheoryQuestionByPaper(
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
