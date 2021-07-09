import 'package:epandu/common_library/services/repository/fpx_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/custom_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../router.gr.dart';

class FpxPaymentOption extends StatefulWidget {
  final String? icNo;
  final String? docDoc;
  final String? docRef;
  final String? merchant;
  final String? packageCode;
  final String? packageDesc;
  final String? diCode;
  final String? totalAmount;
  final String? amountString; // for Authorization Request

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
  bool isVisible = false;
  bool isLoading = false;
  Future? getBankList;
  final primaryColor = ColorConstant.primaryColor;

  String? selectedBankId = '';
  String? selectedBankName = '';

  String message = '';

  final tabTextStyle = TextStyle(fontSize: 40.sp);

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

  fpxSendB2CAuthRequest({required bankId}) async {
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
      context.router.push(
        Webview(
            url: result.data[0].responseData,
            backType: widget.amountString == null ? 'DI_ENROLLMENT' : 'HOME'),
      );
    } else {
      context.router.push(
        PaymentStatus(icNo: widget.icNo),
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
                            : ListTile(
                                leading: Image.network(
                                    bankList[index].split('~')[3]),
                                title: Text(bankList[index].split('~')[2] +
                                    ' (offline)'),
                              );
                      },
                    ),
                  );
                default:
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!
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

  defaultLayout() {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('payment_lbl')),
      ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(AppLocalizations.of(context)!
                              .translate('institute_lbl')),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(widget.merchant!),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(AppLocalizations.of(context)!
                              .translate('package_lbl')),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.packageCode!,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text('Desc'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.packageDesc!,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            AppLocalizations.of(context)!.translate('total_lbl'),
                            style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.totalAmount!,
                            style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Color(0xff5c5c5c)),
                    children: [
                      TextSpan(
                          text:
                              'By clicking on the "Proceed" button, you hereby agree with '),
                      TextSpan(
                        text: 'FPX\'s Terms & Conditions',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue[900],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async => await launch(
                              'https://www.mepsfpx.com.my/FPXMain/termsAndConditions.jsp'),
                        /* recognizer: TapGestureRecognizer()
                          ..onTap = () => context.router.push(
                                Routes.webview,
                                arguments: WebviewArguments(
                                    url:
                                        'https://www.mepsfpx.com.my/FPXMain/termsAndConditions.jsp'),
                              ), */
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w),
                child: InkWell(
                  /* onTap: () => context.router.push(
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
                      hintText: selectedBankName!.isNotEmpty
                          ? selectedBankName
                          : 'Select Bank',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                    ),
                    onChanged: null,
                    items: null,
                    iconDisabledColor: Colors.grey[900],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              if (message.isNotEmpty)
                Text(message, style: TextStyle(color: Colors.red)),
              CustomButton(
                onPressed: () {
                  if (selectedBankId!.isNotEmpty) {
                    message = '';
                    fpxSendB2CAuthRequest(bankId: selectedBankId);
                  } else {
                    setState(() {
                      message = AppLocalizations.of(context)!
                          .translate('agree_and_select_bank');
                    });
                  }
                },
                buttonColor: Color(0xffdd0e0e),
                title: AppLocalizations.of(context)!.translate('proceed'),
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

  tabLayout() {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('payment_lbl')),
      ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .translate('institute_lbl'),
                              style: tabTextStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(widget.merchant!, style: tabTextStyle),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .translate('package_lbl'),
                              style: tabTextStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.packageCode!,
                            style: tabTextStyle,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text('Desc', style: tabTextStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.packageDesc!,
                            style: tabTextStyle,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            AppLocalizations.of(context)!.translate('total_lbl'),
                            style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.totalAmount!,
                            style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Color(0xff5c5c5c), fontSize: 45.sp),
                    children: [
                      TextSpan(
                          text:
                              'By clicking on the "Proceed" button, you hereby agree with '),
                      TextSpan(
                        text: 'FPX\'s Terms & Conditions',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue[900],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async => await launch(
                              'https://www.mepsfpx.com.my/FPXMain/termsAndConditions.jsp'),
                        /* recognizer: TapGestureRecognizer()
                          ..onTap = () => context.router.push(
                                Routes.webview,
                                arguments: WebviewArguments(
                                    url:
                                        'https://www.mepsfpx.com.my/FPXMain/termsAndConditions.jsp'),
                              ), */
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55.w),
                child: InkWell(
                  /* onTap: () => context.router.push(
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
                      hintText: selectedBankName!.isNotEmpty
                          ? selectedBankName
                          : 'Select Bank',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      ),
                    ),
                    onChanged: null,
                    items: null,
                    iconDisabledColor: Colors.grey[900],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              if (message.isNotEmpty)
                Text(message, style: TextStyle(color: Colors.red)),
              CustomButton(
                minWidth: 340.w,
                height: 150.h,
                onPressed: () {
                  if (selectedBankId!.isNotEmpty) {
                    message = '';
                    fpxSendB2CAuthRequest(bankId: selectedBankId);
                  } else {
                    setState(() {
                      message = AppLocalizations.of(context)!
                          .translate('agree_and_select_bank');
                    });
                  }
                },
                buttonColor: Color(0xffdd0e0e),
                title: AppLocalizations.of(context)!.translate('proceed'),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return defaultLayout();
      }
      return tabLayout();
    });
  }
}
