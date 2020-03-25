import 'package:epandu/pages/profile/profile_loading.dart';
import 'package:epandu/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
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

  /* final TextStyle _titleStyle = TextStyle(
    fontSize: 65.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  ); */

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
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w),
              child: Ink(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 8.0),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.h, horizontal: 55.w),
                  child: FutureBuilder(
                    future: _getData,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Container(
                            height: 1700.h,
                            child: SpinKitFoldingCube(
                              color: primaryColor,
                            ),
                          );
                        case ConnectionState.done:
                          if (snapshot.data is String) {
                            return ProfileLoading(snapshot.data);
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  PAYMENT_HISTORY_DETAIL,
                                  arguments: snapshot.data[index],
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(15.w, 50.h, 15.w, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Table(
                                        children: [
                                          TableRow(
                                            children: [
                                              Text(
                                                '${format.format(DateTime.parse(snapshot.data[index].trandate))}',
                                                style: _subtitleStyle,
                                              ),
                                              Text(
                                                'REC ${snapshot.data[index].recpNo}',
                                                style: _subtitleStyle,
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: snapshot.data[index]
                                                            .trnDesc !=
                                                        null
                                                    ? Text(
                                                        '${snapshot.data[index].trnDesc}',
                                                        style: _subtitleStyle,
                                                      )
                                                    : Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'no_description'),
                                                        style: _subtitleStyle,
                                                      ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Text(
                                                  'RM${NumberFormat('#,###0.00').format(double.tryParse(snapshot.data[index].payAmount))}',
                                                  style: _subtitleStyle,
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      index + 1 != snapshot.data.length
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 50.h),
                                              child: Divider(
                                                color: Colors.grey[300],
                                                height: 1.0,
                                                thickness: 1.0,
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(top: 50.h),
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
            ),
          ],
        ),
      ),
    );
  }
}
