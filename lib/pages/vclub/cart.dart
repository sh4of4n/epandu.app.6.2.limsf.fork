import 'package:auto_route/auto_route.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/services/provider/cart_status.dart';
import 'package:epandu/common_library/services/repository/products_repository.dart';
import 'package:epandu/common_library/services/repository/sales_order_repository.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Cart extends StatefulWidget {
  final String? name;
  final String? dbcode;

  Cart({this.name, this.dbcode});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final salesOrderRepo = SalesOrderRepo();
  final productsRepo = ProductsRepo();
  final customDialog = CustomDialog();
  final primaryColor = ColorConstant.primaryColor;
  final formatter = NumberFormat('#,##0.00');
  final unescape = HtmlUnescape();

  String? tlNettOrdAmt = '0.00';
  var activeSlsTrnData;
  var slsDetailData;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _getActiveSlsTrnByDb();
  }

  Future<dynamic> _getActiveSlsTrnByDb() async {
    setState(() {
      _isLoading = true;
    });

    var result = await salesOrderRepo.getActiveSlsTrnByDb(
      context: context,
      dbcode: widget.dbcode,
      isCart: 'true',
    );

    if (result.isSuccess) {
      // return result.data;
      var slsDetail = await _getSlsDetailByDocNo(
        context,
        result.data[0].docDoc,
        result.data[0].docRef,
      );

      if (mounted)
        setState(() {
          tlNettOrdAmt = result.data[0].tlNettOrdAmt;
          activeSlsTrnData = result.data;
          slsDetailData = slsDetail;
        });
    } else {
      if (mounted)
        setState(() {
          slsDetailData = result.message;
        });
    }

    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  Future<dynamic> _getSlsDetailByDocNo(context, docDoc, docRef) async {
    var result = await salesOrderRepo.getSlsDetailByDocNo(
      context: context,
      docDoc: docDoc,
      docRef: docRef,
    );

    if (result.isSuccess) {
      return result.data;
    }
    return result.message;
  }

  _showOrdPrice(snapshot) {
    if (double.tryParse(snapshot.discAmt)! > 0)
      return Row(
        children: <Widget>[
          Text(
            (formatter.format(
              double.tryParse(snapshot.ordPrice)! *
                  double.tryParse(snapshot.ordQty)!,
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

  _editItem(snapshot) {
    context.router
        .push(
          CartItemEdit(
            stkCode: snapshot.stkCode,
            stkDesc1: snapshot.stkDesc1,
            stkDesc2: snapshot.stkDesc2,
            qty: formatter.format(double.tryParse(snapshot.ordQty)),
            price: formatter.format(double.tryParse(snapshot.ordPrice)),
            discRate: formatter.format(double.tryParse(snapshot.discRate)),
            isOfferedItem: snapshot.offeredItem,
            scheduledDeliveryDate: snapshot.expDlvdt,
            uom: snapshot.ordUom,
            batchNo: snapshot.batchNo,
            slsKey: snapshot.key,
          ),
        )
        .then((value) => _getActiveSlsTrnByDb());
  }

  _deleteItemDialog(snapshot, index) async {
    customDialog.show(
      context: context,
      content: Text('Do you want to remove this product?'),
      customActions: <Widget>[
        TextButton(
          child: Text('Yes'),
          onPressed: () async {
            Provider.of<CartStatus>(context, listen: false)
                .updateCartBadge(cartItem: snapshot.length - 1);

            if (snapshot.length - 1 == 0) {
              Provider.of<CartStatus>(context, listen: false).setShowBadge(
                showBadge: false,
              );
            }

            context.router.pop(context);

            if (mounted)
              setState(() {
                _isLoading = true;
                tlNettOrdAmt = '0.00';
              });

            await _deleteSlsDtlByDocRefKey(
              context: context,
              snapshot: snapshot[index],
            );

            _getActiveSlsTrnByDb();
          },
        ),
        TextButton(
          child: Text('No'),
          onPressed: () => context.router.pop(context),
        ),
      ],
      type: DialogType.GENERAL,
    );
  }

  _deleteSlsDtlByDocRefKey({context, required snapshot}) async {
    var result = await salesOrderRepo.deleteSlsDtlByDocRefKey(
      context: context,
      docDoc: snapshot.docDoc,
      docRef: snapshot.docRef,
      key: snapshot.key,
    );

    if (result.isSuccess)
      return Response(true, data: result);
    else
      return Response(false, message: result.message);
  }

  _checkout() {
    context.router.push(
      Checkout(
        slsDetailData: slsDetailData,
        name: unescape.convert(widget.name!),
        dbcode: widget.dbcode,
        date: activeSlsTrnData[0].ordDate,
        docDoc: activeSlsTrnData[0].docDoc,
        docRef: activeSlsTrnData[0].docRef,
        qty: activeSlsTrnData[0].tlOrdQty,
        totalAmount: activeSlsTrnData[0].tlNettOrdAmt,
      ),
    );
  }

  _renderCart() {
    if (_isLoading == true) {
      return Column(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              width: ScreenUtil().setWidth(1350),
              height: ScreenUtil().setHeight(450),
              color: Colors.grey[300],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              width: ScreenUtil().setWidth(1350),
              height: ScreenUtil().setHeight(450),
              color: Colors.grey[300],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              width: ScreenUtil().setWidth(1350),
              height: ScreenUtil().setHeight(450),
              color: Colors.grey[300],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              width: ScreenUtil().setWidth(1350),
              height: ScreenUtil().setHeight(450),
              color: Colors.grey[300],
            ),
          ),
        ],
      );
    } else if (slsDetailData != null && _isLoading == false) {
      if (slsDetailData is String) {
        return Container(
          height: ScreenUtil().screenHeight - ScreenUtil().setHeight(880),
          child: Center(
            child: Text(slsDetailData,
                style: TextStyle(fontSize: ScreenUtil().setSp(60))),
          ),
        );
      }
      return Container(
        height: ScreenUtil().screenHeight - ScreenUtil().setHeight(880),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: slsDetailData.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: Column(
                children: <Widget>[
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Text(slsDetailData[index].stkCode),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(slsDetailData[index].stkDesc1),
                        ],
                      ),
                      if (slsDetailData[index].batchNo != null)
                        TableRow(
                          children: [
                            Text(slsDetailData[index].batchNo),
                          ],
                        ),
                      TableRow(
                        children: [
                          Text(
                              '${formatter.format(double.tryParse(slsDetailData[index].ordQty))} ${slsDetailData[index].ordUom}'),
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
                              _showOrdPrice(slsDetailData[index]),
                              Text(
                                formatter.format(double.tryParse(
                                    slsDetailData[index].nettOrdAmt)),
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(56),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () => _editItem(slsDetailData[index]),
                            icon: Icon(Icons.edit, color: Colors.grey[700]),
                          ),
                          IconButton(
                            onPressed: () =>
                                _deleteItemDialog(slsDetailData, index),
                            icon: Icon(Icons.delete, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
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
    return Center(
      child: Text('Failed to load cart items, please try again later.'),
    );
  }

  _getBottomSheet() {
    if (slsDetailData is String) {
      return Container(width: 0, height: 0);
    } else if (slsDetailData != null && slsDetailData.length > 0) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(50),
          horizontal: ScreenUtil().setWidth(50),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5, 5),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Total: ' + tlNettOrdAmt!,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(65),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(50)),
            ButtonTheme(
              minWidth: ScreenUtil().setWidth(420),
              padding: EdgeInsets.symmetric(vertical: 11.0),
              buttonColor: primaryColor,
              shape: StadiumBorder(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                ),
                onPressed: _checkout,
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
      );
    }
    return Container(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        /* actions: <Widget>[
          IconButton(
            onPressed: () =>
                context.router.push(Routes.salesOrderCategory),
            icon: Icon(Icons.add),
          ),
        ], */
      ),
      bottomSheet: _getBottomSheet(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil().screenWidth,
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    unescape.convert(widget.name!),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(65),
                    ),
                  ),
                  Text(widget.dbcode!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Divider(
                height: 1.0,
                color: Colors.grey[700],
              ),
            ),
            _renderCart(),
          ],
        ),
      ),
    );
  }
}
