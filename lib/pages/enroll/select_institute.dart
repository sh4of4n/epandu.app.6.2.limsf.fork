import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repo/auth_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SelectInstitute extends StatelessWidget {
  final authRepo = AuthRepo();
  final primaryColor = ColorConstant.primaryColor;

  Future<dynamic> _getDiList(context) async {
    var result = await authRepo.getDiList(
      context: context,
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
          title: Text(
              AppLocalizations.of(context).translate('select_institute_lbl'))),
      body: FutureBuilder(
        future: _getDiList(context),
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
                    onTap: () => Navigator.pushNamed(context, SELECT_CLASS,
                        arguments: snapshot.data[index].diCode),
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
                          Text(snapshot.data[index].name ?? 'No name',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(snapshot.data[index].add != null
                              ? snapshot.data[index].add.replaceAll('\r\n', '')
                              : 'No address'),
                          Text(snapshot.data[index].phone ?? 'No phone'),
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
                  AppLocalizations.of(context).translate('get_di_list_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
