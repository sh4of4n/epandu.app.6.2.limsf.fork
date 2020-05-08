import 'package:epandu/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../app_localizations.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final primaryColor = ColorConstant.primaryColor;
  final format = DateFormat("yyyy-MM-dd");

  /* final TextStyle _titleStyle = TextStyle(
    fontSize: 65.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  ); */

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 56.sp,
    fontWeight: FontWeight.w400,
    color: Color(
      0xff666666,
    ),
  );

  final epanduRepo = EpanduRepo();

  int _startIndex = 0;
  String _message = '';
  List<dynamic> items = [];
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _getData();

    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 20;
          });

          if (_message.isEmpty) _getData();
        }
      });
  }

  _getData() async {
    setState(() {
      _isLoading = true;
    });

    var response = await epanduRepo.getCollectionByStudent(
        context: context, startIndex: _startIndex);

    if (response.isSuccess) {
      if (response.data.length > 0) if (mounted)
        setState(() {
          for (int i = 0; i < response.data.length; i += 1) {
            items.add(response.data[i]);
          }
          _isLoading = false;
        });
      // return response.data;
    } else {
      if (mounted)
        setState(() {
          _message = response.message;
          _isLoading = false;
        });
      // return response.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            primaryColor,
          ],
          stops: [0.45, 0.95],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context).translate('payment_lbl')),
        ),
        body: _paymentHistoryList(),
      ),
    );
  }

  _paymentHistoryList() {
    if (_message.isNotEmpty) {
      return Center(
        child: Text(_message),
      );
    } else if (items.length > 0) {
      return Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              children: <Widget>[
                for (var item in items)
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      PAYMENT_HISTORY_DETAIL,
                      arguments: item.recpNo,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50.w, 50.h, 50.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    '${item.trandate.substring(0, 10)}',
                                    style: _subtitleStyle,
                                  ),
                                  Text(
                                    'REC ${item.recpNo}',
                                    style: _subtitleStyle,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: item.trnDesc != null
                                        ? Text(
                                            '${item.trnDesc}',
                                            style: _subtitleStyle,
                                          )
                                        : Text(
                                            // AppLocalizations.of(context)
                                            //     .translate('no_description'),
                                            '',
                                            style: _subtitleStyle,
                                          ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      'RM${NumberFormat('#,##0.00').format(double.tryParse(item.payAmount))}',
                                      style: _subtitleStyle,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: Divider(
                              color: Colors.grey[300],
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          )
                          /* index + 1 != snapshot.data.length
                                ? Padding(
                                    padding: EdgeInsets.only(top: 50.h),
                                    child: Divider(
                                      color: Colors.grey[300],
                                      height: 1.0,
                                      thickness: 1.0,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 50.h),
                                  ), */
                        ],
                      ),
                    ),
                  ),
                if (_isLoading)
                  Column(
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
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Divider(
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
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
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
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
}
