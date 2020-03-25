import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';

class PaymentHistoryDetail extends StatelessWidget {
  final snapshot;

  PaymentHistoryDetail(this.snapshot);

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 60.w),
        width: ScreenUtil.screenWidthDp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Table(
              children: [
                TableRow(
                  children: [
                    Text(format.format(DateTime.parse(snapshot.trandate))),
                    Text(
                      'REC ${snapshot.recpNo}',
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              snapshot.packageCode ??
                  AppLocalizations.of(context).translate('no_package_code'),
              textAlign: TextAlign.left,
            ),
            Text(
              snapshot.trnDesc ??
                  AppLocalizations.of(context).translate('no_package_desc'),
              textAlign: TextAlign.left,
            ),
            Container(
                height: 1500.h, child: Center(child: Text('Payment details'))),
            Text(
              'Total RM${NumberFormat('#,###0.00').format(double.tryParse(snapshot.payAmount))}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 90.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
