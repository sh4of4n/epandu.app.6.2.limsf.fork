import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:epandu/services/provider/cart_status.dart';
import 'package:epandu/common_library/services/repository/sales_order_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:epandu/common_library/utils/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../router.gr.dart' as route;
import 'package:epandu/common_library/services/repository/products_repository.dart';

class Product extends StatefulWidget {
  final String? stkCode;
  final String? stkDesc1;
  final String? stkDesc2;
  final String? qty;
  final String? price;
  final String? image;
  final String? uom;
  final products;

  Product({
    this.stkCode,
    this.stkDesc1,
    this.stkDesc2,
    this.qty,
    this.price,
    this.image,
    this.uom,
    this.products,
  });

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final salesOrderRepo = SalesOrderRepo();
  final productsRepo = ProductsRepo();
  final unescape = HtmlUnescape();
  final primaryColor = ColorConstant.primaryColor;
  final customDialog = CustomDialog();
  final customSnackbar = CustomSnackbar();
  final formatter = NumberFormat('#,##0.00');
  final dateFormat = DateFormat("yyyy-MM-dd");
  String? customerName;
  String dbcode = 'TBS';

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  DateTime? scheduleDate;
  String _batchNo = '';
  bool _saveBtnIsLoading = false;
  bool _isOfferedItem = false;

  String uomValue = '';

  TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 58.sp,
  );

  final reviewStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 60.sp,
    color: Color(0xff5d6767),
  );

  TextStyle headerBubble = TextStyle(
    fontSize: 66.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey[800],
  );

  TextStyle seeAll = TextStyle(
    fontSize: 60.sp,
    fontWeight: FontWeight.w500,
    color: Colors.blue,
  );

  final bubbleDecoration = BoxDecoration(
    color: Colors.white,
    // borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0.0, 1.0),
        blurRadius: 2.0,
      ),
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0.0, -1.0),
        blurRadius: 2.0,
      ),
    ],
  );

  // bool _showBadge = false;
  // int cartItems = 0;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }

  @override
  void initState() {
    super.initState();

    _getActiveSlsTrnByDb();
  }

  Future<dynamic> _getActiveSlsTrnByDb() async {
    var result = await salesOrderRepo.getActiveSlsTrnByDb(
      context: context,
      dbcode: 'TBS',
      isCart: 'true',
    );

    if (result.isSuccess) {
      // return result.data;
      _getSlsDetailByDocNo(
        context,
        result.data[0].docDoc,
        result.data[0].docRef,
      );
    }
  }

  Future<dynamic> _getSlsDetailByDocNo(context, docDoc, docRef) async {
    var result = await salesOrderRepo.getSlsDetailByDocNo(
      context: context,
      docDoc: docDoc,
      docRef: docRef,
    );

    if (result.isSuccess && mounted) {
      /* setState(() {
        _showBadge = true;
        cartItems = result.data.length;
      }); */

      Provider.of<CartStatus>(context, listen: false).setShowBadge(
        showBadge: true,
      );

      Provider.of<CartStatus>(context, listen: false).updateCartBadge(
        cartItem: result.data.length,
      );
    }
  }

  loadImage(image) {
    if (image != null)
      return Image.network(
        image.replaceAll(removeBracket, '').split('\r\n')[0],
        height: 300.h,
        gaplessPlayback: true,
      );

    return SizedBox(
      // width: 180.w,
      height: 300.h,
      child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
    );
  }

  _saveButton() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 50.h,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            minimumSize: Size(1300.w, 50.h),
            padding: EdgeInsets.symmetric(vertical: 11.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Color(0xffdd0e0e)),
            ),
            primary: Color(0xffdd0e0e),
            textStyle: TextStyle(color: Colors.white)),
        child: Text(
          'Add To Cart',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(60),
          ),
        ),
      ),
    );
  }

  _submit() async {
    setState(() {
      _saveBtnIsLoading = true;
    });

    var result = await salesOrderRepo.saveActiveSlsDtlByDb(
      context: context,
      dbcode: dbcode,
      stkCode: widget.stkCode ?? '',
      stkDesc1: widget.stkDesc1 ?? '',
      stkDesc2: widget.stkDesc2 ?? '',
      batchNo: _batchNo,
      itemQty: '1',
      itemUom: widget.uom ?? '',
      itemPrice: double.tryParse(widget.price!.replaceAll(',', ''))!
          .toStringAsFixed(2),
      discAmt: '0.00',
      discRate: '0.00',
      isOfferItem: _isOfferedItem,
      scheduleDeliveryDateString: scheduleDate != null
          ? dateFormat.format(scheduleDate!).substring(0, 10)
          : '',
      key: '',
      isCart: 'true',
      signatureImage: null,
      signatureImageBase64String: '',
    );

    if (result.isSuccess) {
      setState(() {
        _saveBtnIsLoading = false;
      });

      int cartItem = Provider.of<CartStatus>(context, listen: false).cartItem!;

      Provider.of<CartStatus>(context, listen: false).setShowBadge(
        showBadge: true,
      );

      Provider.of<CartStatus>(context, listen: false).updateCartBadge(
        cartItem: cartItem + 1,
      );

      customSnackbar.show(context,
          message: 'Item added to cart.', type: MessageType.SUCCESS);

      /* context.router.pushAndRemoveUntil(
            Routes.salesOrderCart,
            ModalRoute.withName(Routes.customerDetail),
            arguments: SalesOrderCartArguments(
              name: customerName,
              dbcode: dbcode,
            ),
          ); */
    } else {
      customDialog.show(
        context: context,
        content: 'Failed to save sales order. Please try again later.',
        type: DialogType.ERROR,
      );

      setState(() {
        // _message = 'Failed to save sales order. Please try again later.';
        _saveBtnIsLoading = false;
      });
    }
  }

  loadReview({required String name, required double rating}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name, style: reviewStyle),
            RatingBar.builder(
              initialRating: rating,
              onRatingUpdate: (rating) {
                print(rating);
              },
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemSize: 20.0,
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent urna elit, efficitur nec accumsan sit amet, bibendum at erat.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showBadge = context.watch<CartStatus>().showBadge;
    int? badgeNo = context.watch<CartStatus>().cartItem;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xfff7f7f7),
        appBar: AppBar(
          title: Text('Product'),
          actions: <Widget>[
            InkWell(
              onTap: () => context.router.push(
                route.Cart(
                  dbcode: 'TBS',
                  itemName: 'TBS',
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 30.h, right: 50.w, bottom: 20.h),
                child: badges.Badge(
                  badgeStyle:
                      badges.BadgeStyle(badgeColor: Colors.redAccent[700]!),
                  badgeAnimation: badges.BadgeAnimation.fade(),
                  showBadge: showBadge,
                  badgeContent: Text(
                    '$badgeNo',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              children: <Widget>[
                SizedBox(height: 20.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.stkCode != null && widget.stkCode!.isNotEmpty)
                        Text(
                          widget.stkCode!,
                          style: labelStyle,
                        ),
                      if (widget.stkDesc1 != null &&
                          widget.stkDesc1!.isNotEmpty)
                        Text(
                          unescape.convert(widget.stkDesc1!),
                          style: labelStyle,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                widget.image!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: GestureDetector(
                          // onTap: () => _loadCustomDialog(context, imageArray),
                          onTap: () => context.router.push(
                            route.ImageViewer(
                              title: widget.stkCode,
                              image: NetworkImage(widget.image!),
                            ),
                          ),
                          child: Image.network(
                            widget.image!,
                            width: 600.w,
                            height: 600.h,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 600.w,
                        height: 600.h,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[600],
                          size: 60,
                        ),
                      ),
                SizedBox(height: 20.h),
                Text(
                  formatter.format(double.tryParse(widget.price!)),
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 80.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    // margin: EdgeInsets.symmetric(horizontal: 50.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
                    decoration: bubbleDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Vouchers', style: labelStyle),
                        Row(
                          children: [
                            Icon(Icons.local_offer, color: Colors.grey[600]),
                            Icon(Icons.local_offer, color: Colors.grey[600]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    // margin: EdgeInsets.symmetric(horizontal: 50.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
                    decoration: bubbleDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Promotions', style: labelStyle),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 40.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
                  decoration: bubbleDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ratings & Reviews',
                          style: headerBubble, textAlign: TextAlign.start),
                      SizedBox(height: 30.h),
                      Container(
                        height: 1500.h,
                        /* child: Center(
                          child: Text('Ratings and reviews will load here.'),
                        ), */
                        child: Column(
                          children: [
                            loadReview(name: 'Rita N', rating: 4),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Divider(
                                color: Colors.grey[200],
                                height: 1,
                                thickness: 1,
                              ),
                            ),
                            loadReview(name: 'Mohd Zul', rating: 3),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Divider(
                                color: Colors.grey[200],
                                height: 1,
                                thickness: 1,
                              ),
                            ),
                            loadReview(name: 'Jannet Sullivan', rating: 5),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Divider(
                                color: Colors.grey[200],
                                height: 1,
                                thickness: 1,
                              ),
                            ),
                            loadReview(name: 'Senator Wakowsky', rating: 4),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'See all >>',
                            style: seeAll,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  // margin:
                  //     EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
                  decoration: bubbleDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Similar Products',
                        style: headerBubble,
                        textAlign: TextAlign.start,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          // childAspectRatio: MediaQuery.of(context).size.height / 530,
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 40.w),
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => context.router.replace(
                              route.Product(
                                image: widget.products[index].stkpicturePath !=
                                        null
                                    ? widget.products[index].stkpicturePath
                                        .replaceAll(removeBracket, '')
                                        .split('\r\n')[0]
                                    : '',
                                price: widget.products[index].stkpriceUnitPrice,
                                qty: double.tryParse(widget.products[index]
                                            .stkqtyYtdAvailableQty) !=
                                        null
                                    ? formatter.format(double.tryParse(widget
                                        .products[index].stkqtyYtdAvailableQty))
                                    : widget
                                        .products[index].stkqtyYtdAvailableQty,
                                stkCode: widget.products[index].stkCode,
                                stkDesc1: widget.products[index].stkDesc1,
                                stkDesc2: widget.products[index].stkDesc2,
                                uom: widget.products[index].uom,
                                products: widget.products,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                loadImage(
                                    widget.products[index].stkpicturePath),
                                SizedBox(height: 20.h),
                                Container(
                                    width: 220.w,
                                    child: Text(
                                      widget.products[index].stkCode,
                                      maxLines: 1,
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 320.h),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 17,
              child: _saveButton(),
            ),
            LoadingModel(
              isVisible: _saveBtnIsLoading,
            ),
          ],
        ),
      ),
    );
  }
}
