import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import 'bottom_menu.dart';

class ValueClub extends StatelessWidget {
  final myImage = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('value_club')),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60.w),
              child: FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                // height: ScreenUtil().setHeight(100),
                image: AssetImage(
                  myImage.vClubBanner,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffbfd730),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
              margin: EdgeInsets.symmetric(horizontal: 60.w),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // childAspectRatio: MediaQuery.of(context).size.height / 530,
                ),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, BILL_SELECTION),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.billPayment,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AIRTIME_SELECTION),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.airtime,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'TOUR'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.tourism,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'HOCHIAK'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.hochiak,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'HIGHEDU'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.higherEducation,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'JOB'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.jobs,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'RIDE'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.rideSharing,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'DI'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.drivingSchools,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, MERCHANT_LIST,
                          arguments: 'WORKSHOP'),
                      child: FadeInImage(
                        alignment: Alignment.center,
                        placeholder: MemoryImage(kTransparentImage),
                        // height: ScreenUtil().setHeight(100),
                        image: AssetImage(
                          myImage.workshops,
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
    );
  }
}
