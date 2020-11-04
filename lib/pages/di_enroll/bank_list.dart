import 'package:auto_route/auto_route.dart';
import 'package:epandu/services/repository/fpx_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class BankList extends StatefulWidget {
  @override
  _BankListState createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  final fpxRepo = FpxRepo();
  final removeBracket = RemoveBracket.remove;
  final primaryColor = ColorConstant.primaryColor;
  Future getBankList;

  @override
  void initState() {
    super.initState();

    getBankList = fpxSendB2CBankEnquiry();
  }

  fpxSendB2CBankEnquiry() async {
    var result = await fpxRepo.fpxSendB2CBankEnquiry(context: context);

    if (result.isSuccess) {
      return result.data;
    }
    return result.message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getBankList,
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

              var bankList = snapshot.data[1].bankList.split('~');

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Text(
                        AppLocalizations.of(context).translate('select_bank'),
                        style: TextStyle(
                            fontSize: 70.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bankList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: bankList[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate('get_bank_list_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
