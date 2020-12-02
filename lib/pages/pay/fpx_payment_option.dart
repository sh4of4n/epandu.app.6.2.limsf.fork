import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/services/repository/fpx_repository.dart';
import 'package:flutter/material.dart';
import 'package:epandu/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/utils/custom_button.dart';

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
  // List<String> paymentOption = ['Online Banking', 'Credit Card', 'Debit Card'];
  String selectedOption = '';
  final image = ImagesConstant();
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
                    Text(AppLocalizations.of(context).translate('package_lbl')),
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
                    Text(AppLocalizations.of(context).translate('total_lbl')),
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
                  AppLocalizations.of(context).translate('agree_to') + ' ',
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
              onTap: () => ExtendedNavigator.of(context).push(
                Routes.bankList,
                arguments: BankListArguments(
                  icNo: widget.icNo,
                  docDoc: widget.docDoc,
                  docRef: widget.docRef,
                  packageCode: widget.packageCode,
                  diCode: widget.diCode,
                ),
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0.h,
                  ),
                  hintText: 'Select Bank',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700], width: 1.6),
                  ),
                ),
                onChanged: null,
                items: null,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          CustomButton(
            onPressed: () {},
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
    );
  }
}
