import 'package:epandu/services/api/model/auth_model.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';

class SelectClass extends StatefulWidget {
  final diCode;

  SelectClass(this.diCode);

  @override
  _SelectClassState createState() => _SelectClassState();
}

class _SelectClassState extends State<SelectClass> {
  final authRepo = AuthRepo();

  final primaryColor = ColorConstant.primaryColor;

  Future _getClasses;

  @override
  void initState() {
    super.initState();

    _getClasses = _getGroupIdByDiCodeForOnline();
  }

  Future<dynamic> _getGroupIdByDiCodeForOnline() async {
    var result = await authRepo.getGroupIdByDiCodeForOnline(
      context: context,
      diCode: widget.diCode,
    );

    if (result.isSuccess) {
      return result.data;
    }

    return result.message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(AppLocalizations.of(context).translate('select_class_lbl'))),
      body: FutureBuilder(
        future: _getClasses,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: SpinKitFoldingCube(
                  color: primaryColor,
                ),
              );
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ENROLLMENT,
                      arguments: EnrollmentArguments(
                        diCode: widget.diCode,
                        groupId: snapshot.data[index].groupId,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(50),
                          ScreenUtil().setWidth(30),
                          ScreenUtil().setWidth(50),
                          0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              'Class ' + snapshot.data[index].groupId ??
                                  'No class',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(NumberFormat('#,###0.00').format(
                                  double.tryParse(snapshot.data[index].fee)) ??
                              'No fee'),
                          Text(snapshot.data[index].totalTime != null
                              ? 'Total time ' + snapshot.data[index].totalTime
                              : 'No total time'),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30)),
                            child: Divider(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate('get_class_list_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
