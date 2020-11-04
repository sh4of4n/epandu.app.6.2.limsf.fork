import 'package:epandu/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';

class PaymentHistoryDetail extends StatefulWidget {
  final recpNo;

  PaymentHistoryDetail(this.recpNo);

  @override
  _PaymentHistoryDetailState createState() => _PaymentHistoryDetailState();
}

class _PaymentHistoryDetailState extends State<PaymentHistoryDetail> {
  final format = DateFormat("yyyy-MM-dd");
  final epanduRepo = EpanduRepo();
  Future _getPaymentDetail;
  final primaryColor = ColorConstant.primaryColor;

  final headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  double _taxAmt = 0;
  double _total = 0;

  @override
  void initState() {
    super.initState();

    _getPaymentDetail = _getCollectionDetailByRecpNo();
  }

  _getCollectionDetailByRecpNo() async {
    var response = await epanduRepo.getCollectionDetailByRecpNo(
        context: context, recpNo: widget.recpNo);

    if (response.isSuccess) return response.data;

    return response.message;
  }

  _getTotal(snapshot) {
    for (int i = 0; i < snapshot.length; i += 1) {
      _taxAmt += double.tryParse(snapshot[i].taxAmt);
      _total += double.tryParse(snapshot[i].nettAmt);
    }

    return Table(
      columnWidths: {0: FractionColumnWidth(.35)},
      children: [
        TableRow(
          children: [
            Text(
              AppLocalizations.of(context).translate('tax_lbl') + ': ',
            ),
            Text(
              _taxAmt != 0
                  ? 'RM${NumberFormat('#,##0.00').format(_taxAmt)}'
                  : '0.00',
              textAlign: TextAlign.right,
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              AppLocalizations.of(context).translate('total_lbl') + ': ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
            ),
            Text(
              _total != 0
                  ? 'RM${NumberFormat('#,##0.00').format(_total)}'
                  : '0.00',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70.sp),
            ),
          ],
        ),
      ],
    );
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('payment_lbl')),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 60.w),
          width: ScreenUtil().screenWidth,
          child: FutureBuilder(
            future: _getPaymentDetail,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SpinKitFoldingCube(
                    color: primaryColor,
                  );
                case ConnectionState.done:
                  if (snapshot.data is String) {
                    return Center(
                      child: Text(snapshot.data),
                    );
                  }

                  return Column(
                    children: <Widget>[
                      Table(
                        children: [
                          TableRow(
                            children: [
                              Text(snapshot.data[0].trandate.substring(0, 10)),
                              Text(
                                'REC ${snapshot.data[0].recpNo}',
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data[0].packageCode ??
                              AppLocalizations.of(context)
                                  .translate('no_package_code'),
                          // '',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data[0].packageDesc ??
                              // AppLocalizations.of(context)
                              //     .translate('no_package_desc'),
                              '',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 50.w),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('description'),
                                  textAlign: TextAlign.center,
                                  style: headerStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('subtotal'),
                                  textAlign: TextAlign.center,
                                  style: headerStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              /* Container(
                                    height: 1500.h,
                                    child: Center(child: Text('Payment details'))), */
                              Table(
                                border: TableBorder(
                                  left: BorderSide(width: 1.0),
                                  right: BorderSide(width: 1.0),
                                  bottom: BorderSide(width: 1.0),
                                  verticalInside: BorderSide(width: 1.0),
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                          snapshot.data[index].trnDesc ??
                                              // AppLocalizations.of(context)
                                              //     .translate('no_item_desc'),
                                              '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Text(
                                          'RM' +
                                                  NumberFormat('#,##0.00')
                                                      .format(double.tryParse(
                                                          snapshot.data[index]
                                                              .tranTotal)) ??
                                              // AppLocalizations.of(context)
                                              //     .translate('no_package_desc'),
                                              '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 100.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 800.w,
                            child: _getTotal(snapshot.data),
                          ),
                        ],
                      ),
                    ],
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
