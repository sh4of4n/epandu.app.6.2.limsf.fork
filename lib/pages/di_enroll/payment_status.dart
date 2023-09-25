import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/fpx_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

@RoutePage(name: 'PaymentStatus')
class PaymentStatus extends StatefulWidget {
  final String? icNo;

  const PaymentStatus({super.key, this.icNo});

  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  final fpxRepo = FpxRepo();
  final primaryColor = ColorConstant.primaryColor;
  Future? getPaymentStatus;

  @override
  void initState() {
    super.initState();

    getPaymentStatus = getOnlinePaymentListByIcNo();
  }

  getOnlinePaymentListByIcNo() async {
    var result = await fpxRepo.getOnlinePaymentListByIcNo(
      context: context,
      icNo: widget.icNo,
      startIndex: '-1',
      noOfRecords: '-1',
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
          AppLocalizations.of(context)!.translate('payment_status'),
        ),
      ),
      body: FutureBuilder(
          future: getPaymentStatus,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
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

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Column(
                        children: [
                          CustomButton(
                              onPressed: () => context.router.popUntil(
                                    ModalRoute.withName('Home'),
                                  ),
                              buttonColor: const Color(0xffdd0e0e),
                              title: AppLocalizations.of(context)!
                                  .translate('done_btn')),
                        ],
                      ),
                    );
                  },
                );
              default:
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!
                        .translate('get_payment_status_fail'),
                  ),
                );
            }
          }),
    );
  }
}
