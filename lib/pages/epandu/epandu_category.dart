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
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
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
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                crossAxisCount: 4,
                // childAspectRatio: 0.9,

                children: [
                  GestureDetector(
                    onTap: () {
                      context.router.push(Enrollment());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/menu/enrollment-icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(AppLocalizations.of(context)!
                            .translate('enroll_lbl')),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(Records());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/menu/payment-icon.png',
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Payment Record',
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(Booking());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/menu/booking-icon.png',
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('booking_lbl'),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.router.push(Booking());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/menu/training-icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Training Record',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(RequestPickup());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            ImagesConstant().pickupIcon,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.translate('pickup'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // context.router.push(RequestPickup());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/menu/account-icon.png',
                          ),
                        ),
                        Text(
                          'Account',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(KppCategory());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/menu/eLearning-icon.png',
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.translate('elearning'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(ComingSoon());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/menu/info-icon.png',
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.translate('info'),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // ListView(
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     ListTile(
              //       onTap: () => context.router.push(ComingSoon()),
              //       title: Text(AppLocalizations.of(context)!.translate('info'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     ListTile(
              //       onTap: () => context.router.push(Enrollment()),
              //       title: Text(
              //           AppLocalizations.of(context)!.translate('enroll_lbl'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     ListTile(
              //       onTap: () => context.router.push(Booking()),
              //       title: Text(
              //           AppLocalizations.of(context)!.translate('booking_lbl'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     ListTile(
              //       onTap: () => context.router.push(KppCategory()),
              //       title: Text(
              //           AppLocalizations.of(context)!.translate('elearning'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     ListTile(
              //       onTap: () => context.router.push(Records()),
              //       title: Text(
              //           AppLocalizations.of(context)!.translate('records'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     ListTile(
              //       onTap: () => context.router.push(RequestPickup()),
              //       title: Text(
              //           AppLocalizations.of(context)!.translate('pickup'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     /* ListTile(
              //       onTap: () =>
              //           context.router.push(Routes.comingSoon),
              //       title: Text(
              //           AppLocalizations.of(context).translate('webinar'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]),
              //     ListTile(
              //       onTap: () =>
              //           context.router.push(Routes.chatHome),
              //       title: Text(AppLocalizations.of(context).translate('chat'),
              //           style: iconText),
              //     ),
              //     Divider(color: Colors.grey[400]), */
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
