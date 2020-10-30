import 'package:auto_route/auto_route.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../router.gr.dart';

class DiEnrollment extends StatefulWidget {
  final String packageCodeJson;

  DiEnrollment({this.packageCodeJson});

  @override
  _DiEnrollmentState createState() => _DiEnrollmentState();
}

class _DiEnrollmentState extends State<DiEnrollment> {
  final authRepo = AuthRepo();
  Future getPackages;
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;

  @override
  void initState() {
    super.initState();

    getPackages = getPackageListByPackageCodeList();
  }

  getPackageListByPackageCodeList() async {
    var diCode = await localStorage.getMerchantDbCode();

    var result = await authRepo.getPackageListByPackageCodeList(
      context: context,
      diCode: diCode,
      packageCodeJson: widget.packageCodeJson ?? '',
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
          AppLocalizations.of(context).translate('enroll_lbl'),
        ),
      ),
      body: FutureBuilder(
        future: getPackages,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 8.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Center(
                  child: SpinKitFoldingCube(
                    color: primaryColor,
                  ),
                ),
              );
            case ConnectionState.done:
              if (snapshot.data is String) {
                return Center(
                  child: Text(snapshot.data),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => ExtendedNavigator.of(context).push(
                      Routes.packageDetail,
                      arguments: PackageDetailArguments(
                        packageCode: snapshot.data[index].packageCode,
                        packageDesc: snapshot.data[index].packageDesc,
                      ),
                    ),
                    child: Text(
                      snapshot.data[index].packageCode,
                    ),
                  );
                },
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate('get_package_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
