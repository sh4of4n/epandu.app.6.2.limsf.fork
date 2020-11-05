// import 'package:auto_route/auto_route.dart';
// import 'package:epandu/router.gr.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
// import 'package:epandu/utils/custom_button.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../app_localizations.dart';

class PackageDetail extends StatefulWidget {
  final String packageCode;
  final String packageDesc;

  PackageDetail(this.packageCode, this.packageDesc);

  @override
  _PackageDetailState createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  final authRepo = AuthRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final removeBracket = RemoveBracket.remove;
  Future getPackageDetail;

  @override
  void initState() {
    super.initState();

    getPackageDetail = getPackageDetlList();
  }

  getPackageDetlList() async {
    var diCode = await localStorage.getMerchantDbCode();

    var result = await authRepo.getPackageDetlList(
      context: context,
      diCode: diCode,
      packageCode: widget.packageCode,
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
        future: getPackageDetail,
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

              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 50.h),
                  child: Column(
                    children: [
                      Text(
                          '${AppLocalizations.of(context).translate('institute_lbl')}: ${snapshot.data[0].merchantNo}'),
                      Text(
                          '${AppLocalizations.of(context).translate('package_lbl')}: ${snapshot.data[0].packageCode}'),
                      if (snapshot.data[0].prodDesc != null)
                        Text(snapshot.data[0].prodDesc),
                      Text('RM' + snapshot.data[0].amt),
                      SizedBox(height: 50.h),
                      /* CustomButton(
                        onPressed: () => ExtendedNavigator.of(context).push(
                          Routes.enrollConfirmation,
                          arguments: EnrollConfirmationArguments(
                            merchantNo: snapshot.data[0].merchantNo,
                            packageCode: snapshot.data[0].packageCode,
                            prodDesc: snapshot.data[0].prodDesc,
                            price: snapshot.data[0].amt,
                          ),
                        ),
                        buttonColor: Color(0xffdd0e0e),
                        title:
                            AppLocalizations.of(context).translate('proceed'),
                      ) */
                    ],
                  ),
                ),
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context)
                      .translate('get_package_detail_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
