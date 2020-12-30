import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/fpx_repository.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/widgets/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class BankList extends StatefulWidget {
  final String icNo;
  final String docDoc;
  final String docRef;
  final String packageCode;
  final String diCode;
  final String amountString;

  BankList({
    this.icNo,
    this.docDoc,
    this.docRef,
    this.packageCode,
    this.diCode,
    this.amountString,
  });

  @override
  _BankListState createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  final fpxRepo = FpxRepo();
  final removeBracket = RemoveBracket.remove;
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  final image = ImagesConstant();
  Future getBankList;
  bool isLoading = false;

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

  fpxSendB2CAuthRequest({bankId}) async {
    // String userId = await localStorage.getUserId();
    // String diCode = await localStorage.getMerchantDbCode();

    setState(() {
      isLoading = true;
    });

    var result;

    result = await fpxRepo.fpxSendB2CAuthRequestWithAmt(
      context: context,
      bankId: Uri.encodeComponent(bankId),
      icNo: widget.icNo,
      docDoc: widget.docDoc,
      docRef: widget.docRef,
      diCode: widget.diCode,
      amountString: widget.amountString ?? '',
      // callbackUrl: 'https://epandu.com/ePandu.Web2/DEVP/1_1/#/merchant-receipt?' +
      //     'diCode=$diCode&docDoc=${widget.docDoc}&docRef=${widget.docRef}&icNo=${widget.icNo}&packageCode=${widget.packageCode}&bankId=${Uri.encodeComponent(bankId)}&userId=$userId',
    );

    if (result.isSuccess) {
      ExtendedNavigator.of(context).push(Routes.webview,
          arguments: WebviewArguments(
              url: result.data[0].responseData,
              backType:
                  widget.amountString == null ? 'DI_ENROLLMENT' : 'HOME'));
      /* launch(
        result.data[0].responseData,
        enableJavaScript: true,
        forceWebView: true,
      ); */
    } else {
      ExtendedNavigator.of(context).push(
        Routes.paymentStatus,
        arguments: PaymentStatusArguments(icNo: widget.icNo),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('select_bank')),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: getBankList,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                    padding: EdgeInsets.all(15.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
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

                  var bankList = snapshot.data[1].bankList.split(',');

                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 55.w, vertical: 30.h),
                        child: Row(
                          children: [
                            Text(
                              'Pay with',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 70.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(image.fpxLogo2, width: 250.w),
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bankList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return bankList[index].split('~')[4] == 'A'
                              ? ListTile(
                                  onTap: () => fpxSendB2CAuthRequest(
                                      bankId: bankList[index].split('~')[0]),
                                  leading: Image.network(
                                      bankList[index].split('~')[3]),
                                  title: Text(bankList[index].split('~')[2]),
                                )
                              : ListTile(
                                  leading: Image.network(
                                      bankList[index].split('~')[3]),
                                  title: Text(bankList[index].split('~')[2] +
                                      ' (offline)'),
                                );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Powered By',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(
                              image.fpxLogo2,
                              width: 200.w,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                default:
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('get_bank_list_fail'),
                    ),
                  );
              }
            },
          ),
          LoadingModel(
            isVisible: isLoading,
          ),
        ],
      ),
    );
  }
}
