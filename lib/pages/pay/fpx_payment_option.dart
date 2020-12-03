import 'package:epandu/services/repository/fpx_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:epandu/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/custom_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:epandu/widgets/loading_model.dart';

import '../../router.gr.dart';

class FpxPaymentOption extends StatefulWidget {
  final String icNo;
  final String docDoc;
  final String docRef;
  final String merchant;
  final String packageCode;
  final String packageDesc;
  final String diCode;
  final String totalAmount;
  final String amountString; // for Authorization Request

  FpxPaymentOption({
    this.icNo,
    this.docDoc,
    this.docRef,
    this.merchant,
    this.packageCode,
    this.packageDesc,
    this.diCode,
    this.totalAmount,
    this.amountString,
  });

  @override
  _FpxPaymentOptionState createState() => _FpxPaymentOptionState();
}

class _FpxPaymentOptionState extends State<FpxPaymentOption> {
  final fpxRepo = FpxRepo();
  // List<String> paymentOption = ['Online Banking', 'Credit Card', 'Debit Card'];
  String selectedOption = '';
  final image = ImagesConstant();
  bool _isAgreed = false;
  bool isVisible = false;
  bool isLoading = false;
  Future getBankList;
  final primaryColor = ColorConstant.primaryColor;

  String selectedBankId = '';
  String selectedBankName = '';

  String message = '';

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
    );

    if (result.isSuccess) {
      ExtendedNavigator.of(context).push(Routes.webview,
          arguments: WebviewArguments(
              url: result.data[0].responseData,
              backType:
                  widget.amountString == null ? 'DI_ENROLLMENT' : 'HOME'));
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

  bankList() {
    return Visibility(
      visible: isVisible,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.7,
            child: Container(
              color: Colors.grey[900],
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
            ),
          ),
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

                  return Container(
                    padding: EdgeInsets.all(15.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 8.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: bankList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return bankList[index].split('~')[4] == 'A'
                            ? ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedBankId =
                                        bankList[index].split('~')[0];
                                    selectedBankName =
                                        bankList[index].split('~')[2];
                                    isVisible = false;
                                  });
                                },
                                leading: Image.network(
                                    bankList[index].split('~')[3]),
                                title: Text(bankList[index].split('~')[2]),
                              )
                            : Container();
                      },
                    ),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 30.h),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 30.h),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Text(AppLocalizations.of(context)
                            .translate('institute_lbl')),
                        Text(widget.merchant),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(AppLocalizations.of(context)
                            .translate('package_lbl')),
                        Text(
                          widget.packageCode,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text('Desc'),
                        Text(
                          widget.packageDesc,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(AppLocalizations.of(context)
                            .translate('total_lbl')),
                        Text(
                          widget.totalAmount,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      onChanged: (bool value) {
                        setState(() {
                          _isAgreed = value;
                        });
                      },
                    ),
                    Text(
                      AppLocalizations.of(context).translate('agree_to') +
                          ' FPX ',
                      style: TextStyle(
                        fontSize: 54.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () => ExtendedNavigator.of(context).push(
                        Routes.webview,
                        arguments: WebviewArguments(
                            url:
                                'https://www.mepsfpx.com.my/FPXMain/termsAndConditions.jsp'),
                      ),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('terms_and_condition_link'),
                        style: TextStyle(
                          fontSize: 54.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w),
                child: InkWell(
                  /* onTap: () => ExtendedNavigator.of(context).push(
                  Routes.bankList,
                  arguments: BankListArguments(
                    icNo: widget.icNo,
                    docDoc: widget.docDoc,
                    docRef: widget.docRef,
                    packageCode: widget.packageCode,
                    diCode: widget.diCode,
                  ),
                ), */
                  onTap: () {
                    setState(() {
                      isVisible = true;
                    });
                  },
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.h,
                      ),
                      hintText: selectedBankName.isNotEmpty
                          ? selectedBankName
                          : 'Select Bank',
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                      ),
                    ),
                    onChanged: null,
                    items: null,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(message, style: TextStyle(color: Colors.red)),
              CustomButton(
                onPressed: () {
                  if (selectedBankId.isNotEmpty && _isAgreed) {
                    message = '';
                    fpxSendB2CAuthRequest(bankId: selectedBankId);
                  } else {
                    setState(() {
                      message = AppLocalizations.of(context)
                          .translate('agree_and_select_bank');
                    });
                  }
                },
                buttonColor: Color(0xffdd0e0e),
                title: AppLocalizations.of(context).translate('proceed'),
              ),
              Expanded(
                child: Padding(
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
              ),
            ],
          ),
          bankList(),
          LoadingModel(
            isVisible: isLoading,
          ),
        ],
      ),
    );
  }
}
