import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../router.gr.dart';

@RoutePage(name: 'DiEnrollment')
class DiEnrollment extends StatefulWidget {
  final String? packageCodeJson;

  const DiEnrollment({super.key, this.packageCodeJson});

  @override
  _DiEnrollmentState createState() => _DiEnrollmentState();
}

class _DiEnrollmentState extends State<DiEnrollment> {
  final authRepo = AuthRepo();
  final formatter = NumberFormat('#,##0.00');
  Future? getPackages;
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final removeBracket = RemoveBracket.remove;

  @override
  void initState() {
    super.initState();

    getPackages = getPackageListByPackageCodeList();
  }

  getPackageListByPackageCodeList() async {
    var diCode = await localStorage.getMerchantDbCode();
    if (!context.mounted) return;
    var result = await authRepo.getPackageListByPackageCodeList(
      context: context,
      diCode: diCode,
      packageCodeJson: widget.packageCodeJson!.isEmpty
          ? Uri.encodeComponent(
              '{"Package": [{"package_code": "A"},{"package_code": "B"}]}')
          : Uri.encodeComponent(widget.packageCodeJson!),
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
        title: const Text(
          'Package',
        ),
      ),
      body: FutureBuilder(
        future: getPackages,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                padding: const EdgeInsets.all(15.0),
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 8.0),
                      blurRadius: 10.0,
                    ),
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Text(
                        AppLocalizations.of(context)!
                            .translate('select_enrollment_package'),
                        style: TextStyle(
                            fontSize: 70.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 30.h),
                          child: InkWell(
                            onTap: () => context.router.push(
                              EnrollConfirmation(
                                banner: snapshot.data[index].feedMediaFilename
                                    .replaceAll(removeBracket, '')
                                    .split('\r\n')[0],
                                packageName: snapshot.data[index].packageName,
                                packageCode: snapshot.data[index].packageCode,
                                packageDesc: snapshot.data[index].packageDesc,
                                diCode: snapshot.data[index].merchantNo,
                                termsAndCondition:
                                    snapshot.data[index].termConditionPolicy,
                                groupIdGrouping: snapshot.data[index]
                                    .groupIdGrouping, //package class
                                amount: formatter.format(double.tryParse(
                                    snapshot.data[index].amt)), //package price
                              ),
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      snapshot.data[index].feedMediaFilename
                                          .replaceAll(removeBracket, '')
                                          .split('\r\n')[0],
                                      gaplessPlayback: true,
                                    ),
                                  ),
                                  /* Text(
                                    snapshot.data[index].packageCode,
                                    style: TextStyle(
                                      fontSize: 60.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index].packageDesc,
                                    style: TextStyle(
                                      fontSize: 56.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ), */
                                  Text(
                                    '${AppLocalizations.of(context)!.translate('class_lbl')}: ' +
                                        snapshot.data[index].groupIdGrouping,
                                    style: TextStyle(
                                      fontSize: 60.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context)!.translate('amount')}: RM${formatter.format(double.tryParse(snapshot.data[index].amt))}',
                                    style: TextStyle(
                                      fontSize: 60.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.translate('get_package_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
