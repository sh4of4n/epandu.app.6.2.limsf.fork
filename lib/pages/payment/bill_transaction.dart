import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

class BillTransaction extends StatefulWidget {
  final data;

  BillTransaction(this.data);

  @override
  _BillTransactionState createState() => _BillTransactionState();
}

class _BillTransactionState extends State<BillTransaction> {
  final TextEditingController _trxController = TextEditingController();
  final primaryColor = ColorConstant.primaryColor;

  // String _trx = '';
  String _message = '';

  @override
  void initState() {
    super.initState();

    // _trxController.addListener(_trxValue);
  }

  // _trxValue() {
  //   setState(() {
  //     _trx = _trxController.text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: primaryColor,
            title: Text(AppLocalizations.of(context).translate('bill_lbl'))),
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
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 40.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(widget.data.serviceComm.telcoImageUri),
                    SizedBox(width: ScreenUtil().setWidth(80)),
                    Text(
                      widget.data.account,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(70)),
                    Container(
                      width: ScreenUtil().setWidth(1000),
                      child: TextField(
                        controller: _trxController,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintStyle: TextStyle(
                            color: primaryColor,
                          ),
                          labelText:
                              AppLocalizations.of(context).translate('trx_lbl'),
                          fillColor: Colors.grey.withOpacity(.25),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    _errorMessage(),
                    SizedBox(height: ScreenUtil().setHeight(100)),
                    ButtonTheme(
                      padding: EdgeInsets.all(0.0),
                      shape: StadiumBorder(),
                      child: RaisedButton(
                        onPressed: _completeTransaction,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent.shade700, Colors.blue],
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            '${AppLocalizations.of(context).translate('pay_lbl')} RM${widget.data.amount}',
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
            ),
          ],
        ),
      ),
    );
  }

  _completeTransaction() {
    if (_trxController.text.isEmpty || _trxController.text == null) {
      setState(() {
        _message = AppLocalizations.of(context).translate('trx_required');
      });
    } else {
      setState(() {
        _message = '';
      });
    }
  }

  _errorMessage() {
    if (_message.isNotEmpty) {
      return Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(30)),
          Text(_message, style: TextStyle(color: Colors.red)),
        ],
      );
    }
    return Container(height: 0, width: 0);
  }

  void dispose() {
    _trxController.dispose();
    super.dispose();
  }
}
