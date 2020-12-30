import 'package:auto_route/auto_route.dart';
import 'package:epandu/services/provider/cart_status.dart';
import 'package:epandu/common_library/services/repository/sales_order_repository.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../router.gr.dart';

class Checkout extends StatefulWidget {
  final slsDetailData;
  final String name;
  final String dbcode;
  final String date;
  final String docDoc;
  final String docRef;
  final String qty;
  final String totalAmount;

  Checkout({
    this.slsDetailData,
    this.name,
    this.dbcode,
    this.date,
    this.docDoc,
    this.docRef,
    this.qty,
    this.totalAmount,
  });

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final salesOrderRepo = SalesOrderRepo();
  final customDialog = CustomDialog();
  final primaryColor = ColorConstant.primaryColor;
  final formatter = NumberFormat('#,##0.00');

  TextStyle labelStyle = TextStyle(
    fontSize: 58.sp,
  );

  TextStyle amountStyle = TextStyle(
    fontSize: 58.sp,
    fontWeight: FontWeight.w600,
  );

  bool _isLoading = false;
  String _message = '';

  _renderCart() {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      // height: ScreenUtil().screenHeight - 1200.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.slsDetailData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(60.w, 20.h, 0, 0),
            child: Column(
              children: <Widget>[
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text(widget.slsDetailData[index].stkCode),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(widget.slsDetailData[index].stkDesc1),
                      ],
                    ),
                    if (widget.slsDetailData[index].batchNo != null)
                      TableRow(
                        children: [
                          Text(widget.slsDetailData[index].batchNo),
                        ],
                      ),
                    TableRow(
                      children: [
                        Text(
                            '${formatter.format(double.tryParse(widget.slsDetailData[index].ordQty))} ${widget.slsDetailData[index].ordUom}'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _showOrdPrice(widget.slsDetailData[index]),
                            Text(
                              formatter.format(double.tryParse(
                                  widget.slsDetailData[index].nettOrdAmt)),
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(56),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Divider(
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _showOrdPrice(snapshot) {
    if (double.tryParse(snapshot.discAmt) > 0)
      return Row(
        children: <Widget>[
          Text(
            (formatter.format(
              double.tryParse(snapshot.ordPrice) *
                  double.tryParse(snapshot.ordQty),
            )),
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: ScreenUtil().setSp(56),
                fontWeight: FontWeight.w500),
          ),
          SizedBox(width: ScreenUtil().setWidth(40)),
          Text(
            snapshot.discRate + '%',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

    return Container(width: 0, height: 0);
  }

  _checkout(context) async {
    setState(() {
      _isLoading = true;
    });

    var result = await salesOrderRepo.saveCartToSalesOrder(
      context: context,
      docDoc: widget.docDoc,
      docRef: widget.docRef,
      signatureImage: null,
      signatureImageBase64String: '',
    );

    if (result.isSuccess) {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Center(
          child: Icon(
            Icons.check_circle_outline,
            size: 120,
          ),
        ),
        content: Text('Your item has been checked out.'),
        customActions: <Widget>[
          FlatButton(
            child: Text('Done'),
            onPressed: () {
              Provider.of<CartStatus>(context, listen: false).setShowBadge(
                showBadge: false,
              );

              Provider.of<CartStatus>(context, listen: false).updateCartBadge(
                cartItem: 0,
              );

              ExtendedNavigator.of(context).popUntil(
                ModalRoute.withName(Routes.valueClub),
              );
            },
          ),
        ],
        type: DialogType.GENERAL,
      );
    } else {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        title: Center(
          child: Icon(
            Icons.check_circle_outline,
            size: 120,
          ),
        ),
        content: Text(result.message),
        type: DialogType.ERROR,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(65),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Text('Date', style: labelStyle),
                    Text(
                      DateFormat('yyyy-MM-dd').format(
                        DateTime.parse(widget.date.substring(0, 10)),
                      ),
                      textAlign: TextAlign.right,
                      style: labelStyle,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Sales order no',
                      style: labelStyle,
                    ),
                    Text(
                      widget.docRef,
                      textAlign: TextAlign.right,
                      style: labelStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 50.h,
            ),
            child: Divider(
              height: 1.0,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: _renderCart(),
          ),
          Center(
            child: _message.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Text(
                      _message,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox.shrink(),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity',
                      style: labelStyle,
                    ),
                    Text(
                      'Total',
                      style: labelStyle,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatter.format(double.tryParse(widget.qty)),
                    textAlign: TextAlign.right,
                    style: amountStyle,
                  ),
                  Text(
                    widget.totalAmount,
                    textAlign: TextAlign.right,
                    style: amountStyle,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 50.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _isLoading
                        ? SpinKitHourGlass(
                            color: primaryColor,
                          )
                        : ButtonTheme(
                            minWidth: ScreenUtil().setWidth(420),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            buttonColor: primaryColor,
                            shape: StadiumBorder(),
                            child: RaisedButton(
                              onPressed: () => _checkout(context),
                              textColor: Colors.white,
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(56),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
