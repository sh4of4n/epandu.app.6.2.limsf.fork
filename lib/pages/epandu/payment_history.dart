import 'package:epandu/pages/profile/profile_loading.dart';
import 'package:epandu/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final primaryColor = ColorConstant.primaryColor;
  final format = DateFormat("yyyy-MM-dd");

  final TextStyle _titleStyle = TextStyle(
    fontSize: 65.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 56.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade600,
  );

  final epanduRepo = EpanduRepo();

  Future _getData;

  @override
  void initState() {
    super.initState();

    _getData = _getdata();
  }

  _getdata() async {
    var response = await epanduRepo.getCollectionByStudent(context: context);

    if (response.isSuccess) {
      return response.data;
    } else {
      return response.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('payment_lbl')),
        ),
        body: Container(
          height: ScreenUtil().setHeight(1800),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(100.0),
              horizontal: ScreenUtil().setWidth(35.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 8.0),
                blurRadius: 10.0,
              )
            ],
          ),
          child: FutureBuilder(
            future: _getData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SpinKitFoldingCube(
                    color: primaryColor,
                  );
                case ConnectionState.done:
                  if (snapshot.data is String) {
                    return ProfileLoading(snapshot.data);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${AppLocalizations.of(context).translate('receipt_no_lbl')} ${snapshot.data[index].recpNo}',
                                style: _titleStyle,
                              ),
                              Text(
                                'Date ${format.format(DateTime.parse(snapshot.data[index].trandate))}',
                                style: _subtitleStyle,
                              ),
                              snapshot.data[index].trnCode != null
                                  ? Text(
                                      'Detail ${snapshot.data[index].trnCode}',
                                      style: _subtitleStyle,
                                    )
                                  : Text(
                                      AppLocalizations.of(context)
                                          .translate('no_item_payment_det'),
                                      style: _subtitleStyle,
                                    ),
                              snapshot.data[index].trnDesc != null
                                  ? Text(
                                      'Desc ${snapshot.data[index].trnDesc}',
                                      style: _subtitleStyle,
                                    )
                                  : Text(
                                      AppLocalizations.of(context)
                                          .translate('no_item_payment_desc'),
                                      style: _subtitleStyle,
                                    ),
                              Text(
                                  'Item amount ${snapshot.data[index].tdefaAmt}'),
                              Text(
                                'Total amount RM${snapshot.data[index].payAmount}',
                                style: _subtitleStyle,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                default:
                  return Center(
                    child: Text(snapshot.data),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
