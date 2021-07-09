import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantCard extends StatelessWidget {
  final String? name;
  final String? desc;
  final String? imageLink;
  final String? cityName;
  final String? distance;
  final String? businessHours;
  final String? businessDay;

  MerchantCard({
    this.name,
    this.desc,
    this.imageLink,
    this.cityName,
    this.distance,
    this.businessHours,
    this.businessDay,
  });

  final image = ImagesConstant();
  final headerStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 60.sp,
    color: Color(0xff5d6767),
  );
  final titleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 70.sp,
    color: Color(0xff5d6767),
  );
  final subtitleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 56.sp,
    color: Color(0xff5d6767),
  );
  final bottomStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 50.sp,
    color: Color(0xff5d6767),
    letterSpacing: -0.3,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 200.w,
            child: imageLink!.isEmpty
                ? Image.asset(image.logo2, width: 200.w)
                : Image.network(imageLink!, width: 200.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffa5b0ae)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                width: 1180.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RatingBar.builder(
                      initialRating: 4,
                      onRatingUpdate: (rating) => print(rating),
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 20.0,
                    ),
                    Text(cityName!, style: headerStyle),
                    Text(distance! + 'KM', style: headerStyle),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    left: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    right: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                width: 1180.w,
                child: Text(name!, style: titleStyle),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    left: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    right: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                width: 1180.w,
                child: Text(desc!, style: subtitleStyle),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    left: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    right: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                width: 1180.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      businessHours!,
                      style: bottomStyle,
                    ),
                    Container(
                      width: 600.w,
                      child: Text(
                        businessDay!,
                        style: bottomStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    left: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                    right: BorderSide(
                      color: Color(0xffa5b0ae),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                width: 1180.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('profile_title'),
                              style: bottomStyle),
                          Image.asset(image.profileIcon, height: 22),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('products'),
                              style: bottomStyle),
                          Image.asset(image.productsIcon, height: 22),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 250.w,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('location_map'),
                              style: bottomStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Image.asset(image.locationIcon, height: 22),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                              AppLocalizations.of(context)!.translate('review'),
                              style: bottomStyle),
                          Image.asset(image.reviewIcon, height: 22),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
