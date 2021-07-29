import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/fpx_repository.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/currency_input_controller.dart';
import 'package:epandu/common_library/utils/custom_button.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supercharged/supercharged.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

class Pay extends StatefulWidget {
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  final fpxRepo = FpxRepo();
  final profileRepo = ProfileRepo();
  final localStorage = LocalStorage();
  final customDialog = CustomDialog();
  final image = ImagesConstant();
  final _formKey = GlobalKey<FormState>();
  var paymentForData;
  var gatewayData;
  String? paymentFor = '';
  String? payBy = '';
  final removeBracket = RemoveBracket.remove;

  final amountController = CurrencyInputController();

  bool isLoading = false;

  String? _icNo = '';
  // String _name = '';
  String _eMail = '';
  String _birthDate = '';
  String _race = '';
  // String _nationality = '';
  String _gender = '';

  String message = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      amountController.text = '0.00';
    });

    amountController.addListener(amountValue);

    _getUserProfile();
  }

  amountValue() {
    amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: amountController.text.length),
    );
  }

  _getUserProfile() async {
    setState(() {
      isLoading = true;
    });

    var result = await profileRepo.getUserProfile(context: context);

    if (result.isSuccess) {
      setState(() {
        _icNo = result.data[0].icNo;
      });
    } else {
      _getUserInfo();
    }

    if (_icNo == null) {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        content:
            AppLocalizations.of(context)!.translate('complete_your_profile'),
        customActions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
            onPressed: () => context.router.pushAndPopUntil(
              UpdateProfile(),
              predicate: ModalRoute.withName('Home'),
            ),
          ),
        ],
        type: DialogType.GENERAL,
      );
    }

    Future.wait([
      getAppPaymentMenu(),
      getMerchantPaymentGateway(),
    ]);

    setState(() {
      isLoading = false;
    });
  }

  _getUserInfo() async {
    String? _getStudentIc = await localStorage.getStudentIc();

    setState(() {
      _icNo = _getStudentIc;
    });
  }

  Future<void> getAppPaymentMenu() async {
    var result = await fpxRepo.getAppPaymentMenu(context: context);

    if (result.isSuccess) {
      setState(() {
        paymentForData = result.data;
      });
    }
  }

  Future<void> getMerchantPaymentGateway() async {
    String? diCode = await localStorage.getMerchantDbCode();

    var result = await fpxRepo.getMerchantPaymentGateway(
        context: context, diCode: diCode);

    if (result.isSuccess) {
      setState(() {
        gatewayData = result.data;
      });
    }
  }

  createOrderWithAmt() async {
    if (payBy!.isNotEmpty && paymentFor!.isNotEmpty) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          isLoading = true;
          message = '';
        });

        String? diCode = await localStorage.getMerchantDbCode();

        var result = await fpxRepo.createOrderWithAmt(
          context: context,
          diCode: diCode,
          icNo: _icNo,
          packageCode: paymentFor,
          amountString: amountController.text.replaceAll(',', ''),
        );

        if (result.isSuccess) {
          context.router.push(
            FpxPaymentOption(
              icNo: _icNo,
              docDoc: result.data[0].docDoc,
              docRef: result.data[0].docRef,
              merchant: result.data[0].merchantNo,
              packageCode: paymentFor,
              packageDesc: result.data[0].packageDesc,
              diCode: diCode,
              totalAmount:
                  double.tryParse(result.data[0].tlOrdAmt)!.toStringAsFixed(2),
              amountString: result.data[0]
                  .tlOrdAmt, // same with totalAmount but used for different purposes, this is available in pay_page and not di_enrollment),
            ),
          );
          /* context.router.push(
            Routes.purchaseOrderList,
            arguments: PurchaseOrderListArguments(
              icNo: _icNo,
              packageCode: packageCode,
              diCode: diCode,
            ),
          ); */
        } else {
          customDialog.show(
            context: context,
            type: DialogType.ERROR,
            content: result.message.toString(),
            onPressed: () => context.router.pop(),
          );
        }

        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        message = AppLocalizations.of(context)!.translate('fill_all_fields');
      });
    }
  }

  defaultLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xffffd225),
          ],
          stops: [0.75, 1.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.translate('pay_lbl')),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: InkWell(
                  onTap: () async {
                    String? diCode = await localStorage.getMerchantDbCode();

                    if (paymentFor!.isNotEmpty)
                      context.router.push(
                        PurchaseOrderList(
                          icNo: _icNo,
                          packageCode: paymentFor,
                          diCode: diCode,
                        ),
                      );
                    else
                      setState(() {
                        message = AppLocalizations.of(context)!
                            .translate('select_payment_for');
                      });
                  },
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.translate('orders'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                // height: ScreenUtil().screenHeight,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.h,
                          ),
                          hintText: AppLocalizations.of(context)!
                              .translate('payment_for'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[700]!, width: 1.6),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            paymentFor = value;
                          });
                        },
                        items: paymentForData == null
                            ? null
                            : paymentForData
                                .map<DropdownMenuItem<String>>((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value.menuCode,
                                  child: Text(value.codeDesc),
                                );
                              }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('payment_for_required_msg');
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        cursorWidth: 0,
                        controller: amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          hintStyle: TextStyle(
                            color: ColorConstant.primaryColor,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff808080),
                          ),
                          labelText:
                              AppLocalizations.of(context)!.translate('amount'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[700]!, width: 1.6),
                            // borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => amountController.text = '0.00',
                            icon: Icon(Icons.close),
                          ),
                        ),
                        validator: (value) {
                          if (value!.replaceAll(',', '').toDouble()! <
                              double.tryParse(gatewayData[0].minAmt)!) {
                            // return 'Please enter amount above ${gatewayData[0].minAmt}';
                            return 'Transaction amount is Lower than the Minimum Limit RM${gatewayData[0].minAmt}';
                          } else if (value.replaceAll(',', '').toDouble()! >
                              30000.00)
                            return 'Maximum Transaction Limit Exceeded RM30,000';
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.h,
                          ),
                          hintText:
                              AppLocalizations.of(context)!.translate('pay_by'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[700]!, width: 1.6),
                            // borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            payBy = value;
                          });
                        },
                        items: gatewayData == null
                            ? null
                            : gatewayData
                                .map<DropdownMenuItem<String>>((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value.gatewayId,
                                  child: Text(value.gatewayId),
                                );
                              }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('pay_by_required_msg');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      if (message.isNotEmpty)
                        Text(message, style: TextStyle(color: Colors.red)),
                      CustomButton(
                        buttonColor: Color(0xffdd0e0e),
                        onPressed: createOrderWithAmt,
                        title:
                            AppLocalizations.of(context)!.translate('next_btn'),
                      ),
                      SizedBox(height: 30.h),
                      Image.asset(image.fpxLogo3, width: 1100.w),
                    ],
                  ),
                ),
              ),
              LoadingModel(
                isVisible: isLoading,
              ),
            ],
          ),
          /* body: Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  image.comingSoon,
                  height: 600.h,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 80.h),
                  width: 1300.w,
                  child: Text(
                    AppLocalizations.of(context).translate('coming_soon_msg'),
                  ),
                ),
              ],
            ),
          ), */
        ),
      ),
    );
  }

  tabLayout() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xffffd225),
          ],
          stops: [0.75, 1.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.translate('pay_lbl')),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: InkWell(
                  onTap: () async {
                    String? diCode = await localStorage.getMerchantDbCode();

                    if (paymentFor!.isNotEmpty)
                      context.router.push(
                        PurchaseOrderList(
                          icNo: _icNo,
                          packageCode: paymentFor,
                          diCode: diCode,
                        ),
                      );
                    else
                      setState(() {
                        message = AppLocalizations.of(context)!
                            .translate('select_payment_for');
                      });
                  },
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.translate('orders'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                // height: ScreenUtil().screenHeight,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        style: TextStyle(
                            color: Color(0xff5c5c5c), fontSize: 42.sp),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 42.sp,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.h,
                          ),
                          hintText: AppLocalizations.of(context)!
                              .translate('payment_for'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[700]!, width: 1.6),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            paymentFor = value;
                          });
                        },
                        items: paymentForData == null
                            ? null
                            : paymentForData
                                .map<DropdownMenuItem<String>>((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value.menuCode,
                                  child: Text(value.codeDesc),
                                );
                              }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('payment_for_required_msg');
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        cursorWidth: 0,
                        controller: amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          hintStyle: TextStyle(
                            color: ColorConstant.primaryColor,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff808080),
                            fontSize: 44.sp,
                          ),
                          labelText:
                              AppLocalizations.of(context)!.translate('amount'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[700]!, width: 1.6),
                            // borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => amountController.text = '0.00',
                            icon: Icon(Icons.close),
                          ),
                        ),
                        validator: (value) {
                          if (value!.replaceAll(',', '').toDouble()! <
                              double.tryParse(gatewayData[0].minAmt)!) {
                            // return 'Please enter amount above ${gatewayData[0].minAmt}';
                            return 'Transaction amount is Lower than the Minimum Limit RM${gatewayData[0].minAmt}';
                          } else if (value.replaceAll(',', '').toDouble()! >
                              30000.00)
                            return 'Maximum Transaction Limit Exceeded RM30,000';
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        style: TextStyle(
                          color: Color(0xff5c5c5c),
                          fontSize: 42.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.h,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 42.sp,
                          ),
                          hintText:
                              AppLocalizations.of(context)!.translate('pay_by'),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue[700]!, width: 1.6),
                            // borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            payBy = value;
                          });
                        },
                        items: gatewayData == null
                            ? null
                            : gatewayData
                                .map<DropdownMenuItem<String>>((dynamic value) {
                                return DropdownMenuItem<String>(
                                  value: value.gatewayId,
                                  child: Text(value.gatewayId),
                                );
                              }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('pay_by_required_msg');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      if (message.isNotEmpty)
                        Text(message, style: TextStyle(color: Colors.red)),
                      CustomButton(
                        minWidth: 250.w,
                        height: 140.h,
                        buttonColor: Color(0xffdd0e0e),
                        onPressed: createOrderWithAmt,
                        title:
                            AppLocalizations.of(context)!.translate('next_btn'),
                      ),
                      SizedBox(height: 30.h),
                      Image.asset(image.fpxLogo3, width: 1100.w),
                    ],
                  ),
                ),
              ),
              LoadingModel(
                isVisible: isLoading,
              ),
            ],
          ),
          /* body: Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  image.comingSoon,
                  height: 600.h,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 80.h),
                  width: 1300.w,
                  child: Text(
                    AppLocalizations.of(context).translate('coming_soon_msg'),
                  ),
                ),
              ],
            ),
          ), */
        ),
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
      },
    );
  }
}
