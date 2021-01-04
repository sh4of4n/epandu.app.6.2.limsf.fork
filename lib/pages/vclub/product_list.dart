import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/products_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../router.gr.dart';

class ProductList extends StatefulWidget {
  final String stkCat;
  final String keywordSearch;

  ProductList({this.stkCat, this.keywordSearch});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final productsRepo = ProductsRepo();
  final customDialog = CustomDialog();
  final primaryColor = ColorConstant.primaryColor;
  final unescape = new HtmlUnescape();
  final formatter = NumberFormat('#,##0.00');
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  String _message = '';
  bool _isLoading = true;

  final RegExp exp =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  int _startIndex = 0;
  List<dynamic> items = [];

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    getStock();

    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 20;
          });

          if (_message.isEmpty) getStock();
        }
      });
  }

  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  getStock() async {
    var _result = await productsRepo.getStock(
        context: context,
        stkCat: Uri.encodeComponent(widget.stkCat),
        keywordSearch: widget.keywordSearch,
        bgnLimit: _startIndex,
        endLimit: 20);

    if (_result.isSuccess) {
      if (_result.data.length > 0)
        setState(() {
          for (int i = 0; i < _result.data.length; i += 1) {
            items.add(_result.data[i]);
          }
        });
      else
        setState(() {
          _isLoading = false;
        });

      if (_result.data.length < 20)
        setState(() {
          _isLoading = false;
        });
    } else {
      setState(() {
        _message = _result.message;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: _productList(),
    );
  }

  _productList() {
    if (items.length == 0 && _message.isNotEmpty) {
      return Center(
        child: Text(_message),
      );
    } else if (items.length > 0) {
      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.symmetric(vertical: 30.h),
        controller: _scrollController,
        children: <Widget>[
          for (var item in items)
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              // padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 7.0,
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -5.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => ExtendedNavigator.of(context).push(
                  Routes.product,
                  arguments: ProductArguments(
                    image: item.stkpicturePath != null
                        ? item.stkpicturePath
                            .replaceAll(removeBracket, '')
                            .split('\r\n')[0]
                        : '',
                    price: item.stkpriceUnitPrice,
                    qty: double.tryParse(item.stkqtyYtdAvailableQty) != null
                        ? formatter
                            .format(double.tryParse(item.stkqtyYtdAvailableQty))
                        : item.stkqtyYtdAvailableQty,
                    stkCode: item.stkCode,
                    stkDesc1: item.stkDesc1,
                    stkDesc2: item.stkDesc2,
                    uom: item.uom,
                    products: items,
                  ),
                ),
                child: GridTile(
                  child: _loadImage(
                      context: context,
                      title: item.stkCode,
                      images: item.stkpicturePath),
                  footer: GridTileBar(
                    backgroundColor: Color(0xB3353536),
                    // width: 220.w,
                    title: Text(
                      item.stkCode,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          if (_isLoading)
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
              child: Column(
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.white,
                    child: Container(
                      width: ScreenUtil().setWidth(1400),
                      height: ScreenUtil().setHeight(350),
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Divider(
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }
    return _loadingShimmer();
  }

  _loadingShimmer({int length}) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: length ?? 20,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Container(
                  width: ScreenUtil().setWidth(1400),
                  height: ScreenUtil().setHeight(350),
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Divider(
                  height: 1.0,
                  color: Colors.grey[400],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _loadImage({context, title, images}) {
    if (images != null) {
      List<String> imageArray = images.replaceAll(exp, '').split('\r\n');

      return Image.network(
        imageArray[1],
        height: 500.h,
      );
    }
    return SizedBox(
      // width: 180.w,
      height: 500.h,
      child: Icon(Icons.broken_image, size: 40),
    );
  }

  /* _loadCustomDialog(context, imageArray) {
    int index = 0;
    return customDialog.show(
      context: context,
      content: Container(
        width: ScreenUtil().setWidth(1000),
        height: ScreenUtil().setHeight(1000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /* IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                if (index > 0) index -= 1;
              },
            ), */
            LimitedBox(
              maxWidth: ScreenUtil().setWidth(800),
              maxHeight: ScreenUtil().setHeight(1000),
              child: Image.network(
                imageArray[index],
              ),
            ),
            /* IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                if (index < imageArray.length - 1) index += 1;
              },
            ), */
          ],
        ),
      ),
      customActions: <Widget>[
        Center(
          child: FlatButton(
            child: Text(
              'Close',
              style: TextStyle(fontSize: ScreenUtil().setSp(60)),
            ),
            onPressed: () {
              ExtendedNavigator.of(context).pop(context);
            },
          ),
        ),
      ],
      type: DialogType.GENERAL,
    );
  } */
}
