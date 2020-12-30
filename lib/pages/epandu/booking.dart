import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final image = ImagesConstant();
  final epanduRepo = EpanduRepo();
  Future getDTestByCode;
  final primaryColor = ColorConstant.primaryColor;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final textStyle = TextStyle(
    fontSize: 65.sp,
    color: Colors.black,
  );

  final textStyleBold = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 65.sp,
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();

    getDTestByCode = _getDTestByCode();
  }

  _getDTestByCode() async {
    var response = await epanduRepo.getDTestByCode(context: context);

    if (response.isSuccess) {
      return response.data;
    } else {
      return response.message;
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
          title: Text(AppLocalizations.of(context).translate('booking')),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 50.h),
          child: RaisedButton(
            shape: CircleBorder(),
            color: Color(0xffdd0e0e),
            textColor: Colors.white,
            padding: EdgeInsets.all(12),
            onPressed: () =>
                ExtendedNavigator.of(context).push(Routes.addBooking),
            child: Icon(
              Icons.add,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  image.advertBanner,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              FutureBuilder(
                future: getDTestByCode,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(
                        height: 1000.h,
                        child: Center(
                          child: SpinKitFoldingCube(
                            color: Colors.blue,
                          ),
                        ),
                      );
                    case ConnectionState.done:
                      if (snapshot.data is String) {
                        return Container(
                          height: 1000.h,
                          child: Center(
                            child: Text(snapshot.data),
                          ),
                        );
                      }
                      return Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 100.w),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index].testDate
                                              .substring(0, 10),
                                          style: textStyle,
                                        ),
                                        if (snapshot.data[index].time != null)
                                          Text(
                                            snapshot.data[index].time,
                                            style: textStyle,
                                          ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        snapshot.data[index].groupId != null
                                            ? Text(
                                                snapshot.data[index].groupId,
                                                style: textStyle,
                                              )
                                            : Text(''),
                                        snapshot.data[index].classes != null
                                            ? Text(
                                                snapshot.data[index].classes,
                                                style: textStyle,
                                              )
                                            : Text(''),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        if (snapshot
                                                .data[index].testTypeValue !=
                                            null)
                                          Text(
                                            'Status: ' +
                                                snapshot
                                                    .data[index].testTypeValue,
                                            style: textStyleBold,
                                          ),
                                        Text(''),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 40.h),
                                      child: Divider(
                                        height: 1.0,
                                        thickness: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      );
                    default:
                      return Center(
                        child: Text(snapshot.data),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
