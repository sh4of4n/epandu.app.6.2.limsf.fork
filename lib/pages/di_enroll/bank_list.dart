import 'package:auto_route/auto_route.dart';
import 'package:epandu/services/repository/fpx_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/widgets/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class BankList extends StatefulWidget {
  final String icNo;
  final String docDoc;
  final String docRef;
  final String packageCode;

  BankList({
    this.icNo,
    this.docDoc,
    this.docRef,
    this.packageCode,
  });

  @override
  _BankListState createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  final fpxRepo = FpxRepo();
  final removeBracket = RemoveBracket.remove;
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
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
    String userId = await localStorage.getUserId();

    setState(() {
      isLoading = true;
    });

    var result = await fpxRepo.fpxSendB2CAuthRequest(
      context: context,
      bankId: Uri.encodeComponent(bankId),
      icNo: widget.icNo,
      docDoc: widget.docDoc,
      docRef: widget.docRef,
      callbackUrl: 'https://epandu.com/ePandu.Web2/DEVP/1_1/#/merchant-receipt?' +
          'diCode=&docDoc=${widget.docDoc}&docRef=${widget.docRef}&icNo=${widget.icNo}&packageCode=${widget.packageCode}&bankId=${Uri.encodeComponent(bankId)}&userId=$userId',
    );

    if (result.isSuccess) {
      ExtendedNavigator.of(context).push(Routes.webview,
          arguments: WebviewArguments(
              url: result.data[0].responseData, backType: 'HOME'));
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

                  return ListView.builder(
                    itemCount: bankList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return bankList[index].split('~')[3] == 'A'
                          ? ListTile(
                              onTap: () => fpxSendB2CAuthRequest(
                                  bankId: bankList[index].split('~')[0]),
                              title: Text(bankList[index].split('~')[2]),
                            )
                          : Container();
                    },
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
