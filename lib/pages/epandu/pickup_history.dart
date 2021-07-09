import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/repository/pickup_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

class PickupHistory extends StatefulWidget {
  @override
  _PickupHistoryState createState() => _PickupHistoryState();
}

class _PickupHistoryState extends State<PickupHistory> {
  final pickupRepo = PickupRepo();
  final primaryColor = ColorConstant.primaryColor;
  final image = ImagesConstant();

  Future? _getPickUpData;

  final _headerText = TextStyle(
    fontSize: 58.sp,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    super.initState();

    _getPickUpData = _getPickUpByIcNo();
  }

  _getPickUpByIcNo() async {
    var result = await pickupRepo.getPickUpByIcNo(context: context);

    if (result.isSuccess) {
      return result.data;
    }
    return result.message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffffcd11)],
          stops: [0.65, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('pickup_history')),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 60.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Color(0xffdd0e0e),
              textStyle: TextStyle(color: Colors.white),
              padding: EdgeInsets.all(12),
            ),
            onPressed: () => context.router.push(RequestPickup()),
            child: Icon(
              Icons.add,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          height: ScreenUtil().screenHeight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FadeInImage(
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    image.advertBanner,
                  ),
                ),
                FutureBuilder(
                  future: _getPickUpData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container(
                          height: 1000.h,
                          child: Center(
                            child: SpinKitFoldingCube(
                              color: primaryColor,
                            ),
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.data is String)
                          return Container(
                            height: 1000.h,
                            child: Center(
                              child: Text(
                                snapshot.data,
                              ),
                            ),
                          );
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50.h, horizontal: 100.w),
                          child: Table(
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.grey[400]!),
                                )),
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('date'),
                                      style: _headerText,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('time'),
                                      style: _headerText,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('to'),
                                      style: _headerText,
                                    ),
                                  ),
                                ],
                              ),
                              for (var data in snapshot.data)
                                TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey[400]!),
                                  )),
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.h),
                                      child: Text(
                                        data.pickupDate.substring(0, 10),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.h),
                                      child: Text(data.pickupTime),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.h),
                                      child: Text(data.destination),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        );
                      default:
                        return Container(
                          height: 1000.h,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('get_pickup_fail'),
                            ),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
