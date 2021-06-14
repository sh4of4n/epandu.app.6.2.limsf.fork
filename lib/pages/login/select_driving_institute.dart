// import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';

import '../../router.gr.dart';

class SelectDrivingInstitute extends StatefulWidget {
  final diList;

  SelectDrivingInstitute(this.diList);

  @override
  _SelectDrivingInstituteState createState() => _SelectDrivingInstituteState();
}

class _SelectDrivingInstituteState extends State<SelectDrivingInstitute> {
  RegisteredDiArmasterProfile diListData;
  final primaryColor = ColorConstant.primaryColor;

  final localStorage = LocalStorage();

  final RegExp exp =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    super.initState();

    saveDiList();
  }

  saveDiList() async {
    await Hive.box('di_list').clear();

    for (int i = 0; i < widget.diList.length; i += 1) {
      diListData = RegisteredDiArmasterProfile(
        iD: widget.diList[i].iD,
        appId: widget.diList[i].appId,
        merchantNo: widget.diList[i].merchantNo,
        userId: widget.diList[i].userId,
        sponsor: widget.diList[i].sponsor,
        sponsorAppId: widget.diList[i].sponsorAppId,
        appCode: widget.diList[i].appCode,
        appVersion: widget.diList[i].appVersion,
        deleted: widget.diList[i].deleted,
        createUser: widget.diList[i].createUser,
        createDate: widget.diList[i].createDate,
        editUser: widget.diList[i].editUser,
        editDate: widget.diList[i].editDate,
        compCode: widget.diList[i].compCode,
        branchCode: widget.diList[i].branchCode,
        transtamp: widget.diList[i].transtamp,
        appBackgroundPhotoPath: widget.diList[i].appBackgroundPhotoPath,
        merchantIconFilename: widget.diList[i].merchantIconFilename,
        merchantBannerFilename: widget.diList[i].merchantBannerFilename,
        merchantProfilePhotoFilename:
            widget.diList[i].merchantProfilePhotoFilename,
        name: widget.diList[i].name,
        shortName: widget.diList[i].shortName,
      );

      await Hive.box('di_list').add(diListData);
    }
  }

  loadImage(diList) {
    if (diList.merchantBannerFilename != null)
      return AspectRatio(
        aspectRatio: 28 / 9,
        child: Image.network(
          diList.merchantBannerFilename.replaceAll(exp, '').split('\r\n')[0],
        ),
      );
    return AspectRatio(
      aspectRatio: 28 / 9,
      child: Container(
        color: Colors.white,
        child: Icon(
          Icons.broken_image,
          size: 80,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade300,
            primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      ImagesConstant().logo,
                      width: ScreenUtil().setWidth(1000),
                      height: ScreenUtil().setHeight(600),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Text(
                    AppLocalizations.of(context).translate('select_di_desc'),
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.diList.length,
                shrinkWrap: true,
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                //   // mainAxisSpacing: 15.0,
                // ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: () {
                        localStorage.saveMerchantDbCode(
                            widget.diList[index].merchantNo);

                        ExtendedNavigator.of(context).replace(Routes.home);
                      },
                      title: loadImage(widget.diList[index]),
                    ),
                  );
                  // return Column(
                  //   children: <Widget>[
                  //     InkWell(
                  //       onTap: () {
                  //         localStorage
                  //             .saveMerchantDbCode(diList[index].merchantNo);

                  //         ExtendedNavigator.of(context).replace(Routes.home);
                  //       },
                  //       child: Container(
                  //         margin: EdgeInsets.symmetric(horizontal: 10.0),
                  //         padding: EdgeInsets.symmetric(vertical: 5.0),
                  //         width: ScreenUtil().setWidth(600),
                  //         height: ScreenUtil().setHeight(600),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(15.0),
                  //         ),
                  //         child:
                  //             /* Image.memory(
                  //           base64Decode(
                  //             diList[index].appBackgroundPhoto,
                  //           ),
                  //           width: ScreenUtil().setWidth(300),
                  //           height: ScreenUtil().setHeight(300),
                  //         ), */
                  //             loadImage(diList[index]),
                  //       ),
                  //     ),
                  //   ],
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
