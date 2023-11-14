import 'package:auto_route/auto_route.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/common_library/services/repository/sales_order_repository.dart';
// import 'package:epandu/common_library/services/repository/stock_enquiry_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

@RoutePage(name: 'CartItemEdit')
class CartItemEdit extends StatefulWidget {
  final String? stkCode;
  final String? stkDesc1;
  final String? stkDesc2;
  final String? qty;
  final String? price;
  final String? discRate;
  final String? isOfferedItem;
  final String? scheduledDeliveryDate;
  final String? uom;
  final String? batchNo;
  final String? slsKey;

  const CartItemEdit({
    super.key,
    this.stkCode,
    this.stkDesc1,
    this.stkDesc2,
    this.qty,
    this.price,
    this.discRate,
    this.isOfferedItem,
    this.scheduledDeliveryDate,
    this.uom,
    this.batchNo,
    this.slsKey,
  });

  @override
  State<CartItemEdit> createState() => _CartItemEditState();
}

class _CartItemEditState extends State<CartItemEdit> with PageBaseClass {
  // final stockEnquiryRepo = StockEnquiryRepo();
  final salesOrderRepo = SalesOrderRepo();
  final primaryColor = ColorConstant.primaryColor;
  final customDialog = CustomDialog();
  final formatter = NumberFormat('#,##0.00');
  final dateFormat = DateFormat("yyyy-MM-dd");
  String? customerName;
  String dbcode = 'TBS';

  DateTime? scheduleDate;
  String _unitPrice = '';
  String _discount = '';
  String _qty = '';
  String _batchNo = '';
  double _totalAmount = 0.00;
  String _message = '';
  bool _saveBtnIsLoading = false;
  bool _isOfferedItem = false;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _qtyFocus = FocusNode();

  final _unitPriceController = TextEditingController();
  final _discountController = TextEditingController();
  final _qtyController = TextEditingController();
  final _batchNoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _unitPriceController.addListener(_unitPriceValue);
    _discountController.addListener(_discountValue);
    _qtyController.addListener(_qtyValue);
    _batchNoController.addListener(_batchNoValue);

    setState(() {
      bool isOffered = false;

      if (widget.isOfferedItem == 'true') {
        isOffered = true;
      }

      if (widget.scheduledDeliveryDate != null) {
        scheduleDate =
            DateTime.parse(widget.scheduledDeliveryDate!.substring(0, 10));
      }

      _isOfferedItem = isOffered;
      _unitPriceController.text = widget.price!;
      _discountController.text = widget.discRate ?? '0.00';
      _qtyController.text = widget.qty ?? '1';
      _batchNoController.text = widget.batchNo ?? '';
    });

    _calculateTotalAmount();
  }

  _unitPriceValue() {
    _unitPriceController.selection = TextSelection.fromPosition(
        TextPosition(offset: _unitPriceController.text.length));

    setState(() {
      _unitPrice = _unitPriceController.text;
    });
  }

  _discountValue() {
    _discountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _discountController.text.length));

    setState(() {
      _discount = _discountController.text;
    });
  }

  _qtyValue() {
    _qtyController.selection = TextSelection.fromPosition(
        TextPosition(offset: _qtyController.text.length));

    setState(() {
      _qty = _qtyController.text;
    });
  }

  _batchNoValue() {
    setState(() {
      _batchNo = _batchNoController.text;
    });
  }

  _calculateTotalAmount() {
    if (_unitPriceController.text.isNotEmpty &&
        _discountController.text.isNotEmpty &&
        _qtyController.text.isNotEmpty) {
      _totalAmount = (double.tryParse(
                  _unitPriceController.text.replaceAll(',', ''))! -
              (double.tryParse(_unitPriceController.text.replaceAll(',', ''))! *
                  double.tryParse(
                      _discountController.text.replaceAll(',', ''))! /
                  100)) *
          double.tryParse(_qtyController.text)!;
    } else {
      _totalAmount = 0.00;
    }
  }

  _addItemForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
          vertical: ScreenUtil().setHeight(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              width: ScreenUtil().setWidth(1400),
              child: TextFormField(
                cursorWidth: 0,
                controller: _qtyController,
                focusNode: _qtyFocus,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) async {
                  if (_qtyController.text.isEmpty) {
                    _qtyController.text = '0';
                  } else {
                    var result = await salesOrderRepo.formatQty(
                        controller: _qtyController);

                    _qtyController.text = result!;
                  }

                  _calculateTotalAmount();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(65),
                      horizontal: ScreenUtil().setWidth(70)),
                  hintStyle: TextStyle(
                    color: primaryColor,
                  ),
                  labelText: 'Quantity',
                  fillColor: Colors.grey.withOpacity(.25),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      /* setState(() {
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => _qtyController.text = '1');
                      }); */

                      _qtyController.text = '0';

                      _calculateTotalAmount();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Quantity is required.';
                  } else if (int.tryParse(value)! < 1) {
                    return 'Quantity must be above 0';
                  }
                  return null;
                },
              ),
            ),
            // SizedBox(height: ScreenUtil().setHeight(40)),
          ],
        ),
      ),
    );
  }

  _saveButton() {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(70),
      ),
      child: _saveBtnIsLoading
          ? SpinKitHourGlass(
              color: primaryColor,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(420.w, 45.h),
                backgroundColor: const Color(0xffdd0e0e),
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(color: Colors.white),
              ),
              onPressed: _submit,
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(60),
                ),
              ),
            ),
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        _saveBtnIsLoading = true;
        _message = '';
      });

      if (double.tryParse(_discount.replaceAll(',', ''))! <= 100) {
        var result = await salesOrderRepo.saveActiveSlsDtlByDb(
          context: context,
          dbcode: dbcode,
          stkCode: widget.stkCode ?? '',
          stkDesc1: widget.stkDesc1 ?? '',
          stkDesc2: widget.stkDesc2 ?? '',
          batchNo: _batchNo,
          itemQty: _qty.isNotEmpty ? _qty : '0.00',
          itemUom: widget.uom ?? '',
          itemPrice:
              _unitPrice.isNotEmpty ? _unitPrice.replaceAll(',', '') : '0.00',
          discAmt: (formatter.format(
              double.tryParse(_discount.replaceAll(',', ''))! *
                  double.tryParse(_unitPrice.replaceAll(',', ''))! /
                  100)),
          discRate:
              _discount.isNotEmpty ? _discount.replaceAll(',', '') : '0.00',
          isOfferItem: _isOfferedItem,
          scheduleDeliveryDateString: scheduleDate != null
              ? dateFormat.format(scheduleDate!).substring(0, 10)
              : '',
          key: widget.slsKey,
          isCart: 'true',
          signatureImage: null,
          signatureImageBase64String: '',
        );

        if (result.isSuccess) {
          setState(() {
            _message = '';
            _saveBtnIsLoading = false;
          });

          /* context.router.push(
            Routes.cart,
            arguments: CartArguments(
              name: customerName,
              dbcode: dbcode,
            ),
          ); */
          if (!context.mounted) return;
          context.router.pop();
        } else {
          setState(() {
            _message = 'Failed to save sales order. Please try again later.';
            _saveBtnIsLoading = false;
          });
        }
      } else {
        setState(() {
          _message = 'Discount must not be above 100%.';
          _saveBtnIsLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Order'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(40),
                vertical: ScreenUtil().setHeight(50),
              ),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      const Text('Item'),
                      Text(widget.stkCode ?? 'No item name',
                          textAlign: TextAlign.left),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Description'),
                      Text(widget.stkDesc1 ?? 'No item description',
                          textAlign: TextAlign.left),
                    ],
                  ),
                  // TableRow(
                  //   children: [
                  //     Text('Quantity'),
                  //     Text(widget.qty ?? '0.00', textAlign: TextAlign.left),
                  //   ],
                  // ),
                  TableRow(
                    children: [
                      const Text('Price'),
                      Text(widget.price ?? '0.00', textAlign: TextAlign.left),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey[400],
            ),
            _addItemForm(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Total Cost: ',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(70),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formatter.format(_totalAmount),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(70),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _message.isNotEmpty
                        ? Text(
                            _message,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox.shrink(),
                    _saveButton(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
