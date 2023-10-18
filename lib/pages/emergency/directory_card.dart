import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class DirectoryCard extends StatelessWidget {
  const DirectoryCard({
    Key? key,
    required this.title,
    required this.image,
    required this.phoneIcon,
    required this.directoryIcon,
    required this.iconText,
    this.phoneAction,
    this.directory,
  }) : super(key: key);

  final String title;
  final String image;
  final String phoneIcon;
  final String directoryIcon;
  final TextStyle iconText;
  final dynamic phoneAction;
  final dynamic directory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: <Widget>[
          FadeInImage(
            height: 250.h,
            // width: 400.w,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(
              image,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: phoneAction,
                child: Image.asset(
                  phoneIcon,
                  height: 150.h,
                ),
              ),
              InkWell(
                onTap: directory != null
                    ? () => context.router.push(directory)
                    : null,
                child: Image.asset(
                  directoryIcon,
                  height: 150.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            title,
            style: iconText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
