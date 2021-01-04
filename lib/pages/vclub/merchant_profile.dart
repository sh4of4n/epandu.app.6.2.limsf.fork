import 'package:epandu/common_library/services/repository/vclub_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

class MerchantProfile extends StatefulWidget {
  final data;

  MerchantProfile(this.data);

  @override
  _MerchantProfileState createState() => _MerchantProfileState();
}

class _MerchantProfileState extends State<MerchantProfile> {
  final vClubRepo = VclubRepo();
  Future _getMerchantDetail;

  final primaryColor = ColorConstant.primaryColor;

  @override
  void initState() {
    super.initState();

    _getMerchantDetail = _getMerchant();
  }

  _getMerchant() async {
    var result = await vClubRepo.getMerchant(
        context: context,
        keywordSearch: widget.data.merchantNo,
        latitude: '999',
        longitude: '999',
        merchantType: widget.data.merchantType,
        maxRadius: 0,
        noOfRecords: -1,
        startIndex: -1);

    if (result.isSuccess) return result.data;
    return result.message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _getMerchantDetail,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                  child: Text(snapshot.data),
                );
              }
              return Column(
                children: <Widget>[],
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context)
                      .translate('merchant_detail_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
