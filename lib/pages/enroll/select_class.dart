import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class SelectClass extends StatefulWidget {
  final data;

  SelectClass(this.data);

  @override
  _SelectClassState createState() => _SelectClassState();
}

class _SelectClassState extends State<SelectClass> {
  final authRepo = AuthRepo();
  final primaryColor = ColorConstant.primaryColor;
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();
  bool _isLoading = false;

  Future _getClasses;
  var status;

  @override
  void initState() {
    super.initState();

    _getClasses = _getGroupIdByDiCodeForOnline();
  }

  Future<dynamic> _getEnrollHistory(groupId) async {
    // return _memoizer.runOnce(() async {
    var result = await authRepo.getEnrollHistory(
      groupId: groupId,
    );

    if (result.isSuccess) {
      return result.data[0].status;
    }
    return null;
    // });
  }

  Future<dynamic> _getGroupIdByDiCodeForOnline() async {
    var result = await authRepo.getGroupIdByDiCodeForOnline(
      context: context,
      diCode: widget.data.diCode,
    );

    if (result.isSuccess) {
      return result.data;
    }

    return result.message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            primaryColor,
          ],
          stops: [0.45, 0.95],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).translate('select_class_lbl'),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 300.h,
                    width: double.infinity,
                    color: Color(0xff0290b7),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('installment_scheme'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 90.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: FadeInImage(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(200),
                      placeholder: MemoryImage(kTransparentImage),
                      image: AssetImage(
                        myImage.visaImage,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1000.w,
                    child: Divider(
                      height: 1.0,
                      color: Color(0xffc73143),
                      thickness: 1.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: FadeInImage(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(200),
                      placeholder: MemoryImage(kTransparentImage),
                      image: AssetImage(
                        myImage.banksImage,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: Divider(
                      height: 1.0,
                      color: Color(0xffaaaaaa),
                      thickness: 1.3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('select_class_lbl'),
                      style: TextStyle(
                        color: Color(0xffdd0e0e),
                        fontSize: 85.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _getClasses,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFoldingCube(
                              color: primaryColor,
                            ),
                          );
                        case ConnectionState.done:
                          if (snapshot.data is String) {
                            return Center(
                                child: Text(AppLocalizations.of(context)
                                    .translate('no_classes_desc')));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () =>
                                    _submit(snapshot.data[index].groupId),
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.fromLTRB(50.w, 30.w, 50.w, 0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontSize: 80.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Myriad',
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'class_lbl') +
                                                          ' ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color(
                                                          0xff666666,
                                                        ),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: snapshot.data[index]
                                                              .groupId ??
                                                          '',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffdd0e0e),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                'RM' +
                                                        NumberFormat('#,##0.00')
                                                            .format(double
                                                                .tryParse(snapshot
                                                                    .data[index]
                                                                    .fee)) ??
                                                    '0.00',
                                                style: TextStyle(
                                                  color: Color(
                                                    0xff666666,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                            .totalTime !=
                                                        null
                                                    ? AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'total_time') +
                                                        ' ' +
                                                        snapshot.data[index]
                                                            .totalTime
                                                    : /* AppLocalizations.of(context)
                                                      .translate('no_total_time') */
                                                    'Total time 00:00',
                                                style: TextStyle(
                                                  color: Color(
                                                    0xff666666,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 100.w),
                                            child: FutureBuilder(
                                              future: _getEnrollHistory(
                                                  snapshot.data[index].groupId),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<dynamic>
                                                      status) {
                                                switch (
                                                    status.connectionState) {
                                                  case ConnectionState.done:
                                                    if (status.data != null) {
                                                      return Text(
                                                        status.data,
                                                        style: TextStyle(
                                                          fontSize: 70.sp,
                                                          color: Color(
                                                            0xff666666,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return Container(
                                                        width: 0, height: 0);
                                                  default:
                                                    return Container(
                                                        width: 0, height: 0);
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(30)),
                                        child: Divider(
                                          height: 1.0,
                                          color: Colors.white,
                                          thickness: 1.0,
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
                              AppLocalizations.of(context)
                                  .translate('get_class_list_fail'),
                            ),
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  color: Colors.grey[900],
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight,
                  child: Center(
                    child: SpinKitFoldingCube(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submit(groupId) async {
    setState(() {
      _isLoading = true;
    });

    var result = await authRepo.saveEnrollmentWithParticular(
      context: context,
      diCode: widget.data.diCode,
      icNo: widget.data.icNo,
      name: widget.data.name,
      email: widget.data.email,
      groupId: groupId,
      gender: widget.data.gender,
      dateOfBirthString: widget.data.dateOfBirthString,
      nationality: widget.data.nationality,
      race: widget.data.race,
      userProfileImageBase64String: widget.data.profilePic,
    );

    if (result.isSuccess) {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Center(
          child: Icon(
            Icons.check_circle_outline,
            size: 120,
            color: Colors.green,
          ),
        ),
        content: AppLocalizations.of(context).translate('enroll_success'),
        type: DialogType.GENERAL,
        customActions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('ok_btn')),
            onPressed: () async {
              await authRepo.getUserRegisteredDI(
                  context: context, type: 'UPDATE');
              ExtendedNavigator.of(context)
                  .pushAndRemoveUntil(Routes.home, (r) => false);
            },
          ),
        ],
      );
    } else {
      customDialog.show(
        context: context,
        type: DialogType.ERROR,
        content: result.message.toString(),
        onPressed: () => ExtendedNavigator.of(context).pop(),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
