import 'package:auto_route/auto_route.dart';
import 'package:epandu/app_localizations.dart';
import 'package:epandu/pages/payment/top_up_button.dart';
import 'package:epandu/services/api/model/bill_model.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../router.gr.dart';

class BillDetail extends StatefulWidget {
  final data;

  BillDetail(this.data);

  @override
  _BillDetailState createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  TextStyle _topUpStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600);
  TextStyle _labelStyle = TextStyle(fontSize: 18.0);

  String _account = '';
  String _amount = '0.00';
  String _message = '';

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final FocusNode _amountFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _accountController.addListener(_accountValue);
    _amountController.addListener(_amountValue);

    _getValues();
  }

  _accountValue() {
    setState(() {
      _account = _accountController.text;
    });
  }

  _amountValue() {
    setState(() {
      _amount = _amountController.text;
    });
  }

  _getValues() async {
    // String kUserPhone = await localStorage.getCountryCode() + await localStorage.getUserPhone();

    // _accountController.text = kUserPhone;
    _amountController.text = _amount;
  }

  _submitDetails() {
    if (_account.isNotEmpty && double.tryParse(_amount) > 0.00) {
      setState(() {
        _message = '';
      });

      BillArgs billArgs = BillArgs(
        account: _account,
        amount: _amount,
        serviceComm: widget.data,
      );

      ExtendedNavigator.of(context).pushNamed(Routes.billTransaction,
          arguments: BillTransactionArguments(data: billArgs));
    } else {
      setState(() {
        _message =
            AppLocalizations.of(context).translate('account_amount_required');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(AppLocalizations.of(context).translate('airtime_lbl'))),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                height: ScreenUtil().setHeight(1000),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Enter number to top-up', style: _labelStyle),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(1100),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                            keyboardType: TextInputType.phone,
                            controller: _accountController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              hintStyle: TextStyle(
                                color: primaryColor,
                              ),
                              labelText: AppLocalizations.of(context)
                                  .translate('account_lbl'),
                              fillColor: Colors.grey.withOpacity(.25),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Image.network(widget.data.telcoImageUri,
                            width: ScreenUtil().setWidth(200),
                            height: ScreenUtil().setHeight(200)),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Text('Select a top-up amount', style: _labelStyle),
                    SizedBox(height: ScreenUtil().setHeight(50)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '5.00';
                              },
                              value: 'RM5.00',
                              textStyle: _topUpStyle,
                            ),
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '10.00';
                              },
                              value: 'RM10.00',
                              textStyle: _topUpStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(50)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '15.00';
                              },
                              value: 'RM15.00',
                              textStyle: _topUpStyle,
                            ),
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '30.00';
                              },
                              value: 'RM30.00',
                              textStyle: _topUpStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(50)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '50.00';
                              },
                              value: 'RM50.00',
                              textStyle: _topUpStyle,
                            ),
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '60.00';
                              },
                              value: 'RM60.00',
                              textStyle: _topUpStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(50)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TopUpButton(
                              onTap: () {
                                _amountController.text = '100.00';
                              },
                              value: 'RM100.00',
                              textStyle: _topUpStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(50)),
                    if (_message.isNotEmpty)
                      Text(
                        _message,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: ScreenUtil().setHeight(50)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .translate('total_lbl'),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              LimitedBox(
                                maxWidth: ScreenUtil().setWidth(400),
                                child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  keyboardType: TextInputType.number,
                                  focusNode: _amountFocus,
                                  onChanged: (text) {
                                    if (text.isEmpty) {
                                      _amountController.text = '0.00';
                                    }
                                  },
                                  onTap: () => _amountController.selection =
                                      TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _amountController.text.length,
                                  ),
                                  controller: _amountController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      // borderSide:
                                      //     BorderSide(color: Colors.transparent),
                                      // borderRadius: BorderRadius.circular(30),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      // borderSide:
                                      //     BorderSide(color: Colors.transparent),
                                      // borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ButtonTheme(
                            padding: EdgeInsets.all(0.0),
                            shape: StadiumBorder(),
                            child: RaisedButton(
                              onPressed: _submitDetails,
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent.shade700,
                                      Colors.blue
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 15.0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('next_btn'),
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(56),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    _amountFocus.dispose();

    super.dispose();
  }
}
