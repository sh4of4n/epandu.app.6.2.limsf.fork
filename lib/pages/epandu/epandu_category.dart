import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

// import 'bottom_menu.dart';

class EpanduCategory extends StatelessWidget {
  final authRepo = AuthRepo();
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    color: Colors.black,
  );
  final myImage = ImagesConstant();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Color(0xffffd225),
          ],
          stops: [0.60, 0.8],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: FadeInImage(
            alignment: Alignment.center,
            height: 110.h,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(
              myImage.logo3,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        // bottomNavigationBar: BottomMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  myImage.advertBanner,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.comingSoon),
                    title: Text(AppLocalizations.of(context).translate('info'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.enrollment),
                    title: Text(
                        AppLocalizations.of(context).translate('enroll_lbl'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.booking),
                    title: Text(
                        AppLocalizations.of(context).translate('booking_lbl'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.kppCategory),
                    title: Text(
                        AppLocalizations.of(context).translate('elearning'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.records),
                    title: Text(
                        AppLocalizations.of(context).translate('records'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () => ExtendedNavigator.of(context)
                        .push(Routes.requestPickup),
                    title: Text(
                        AppLocalizations.of(context).translate('pickup'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.comingSoon),
                    title: Text(
                        AppLocalizations.of(context).translate('webinar'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () =>
                        ExtendedNavigator.of(context).push(Routes.chatHome),
                    title: Text(AppLocalizations.of(context).translate('chat'),
                        style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
