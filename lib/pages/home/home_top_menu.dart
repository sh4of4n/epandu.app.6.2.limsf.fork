import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as badges;
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/services/provider/notification_count.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../chat/chatnotification_count.dart';

class HomeTopMenu extends StatefulWidget {
  final iconText;
  final getDiProfile;
  final getActiveFeed;

  const HomeTopMenu({
    super.key,
    this.iconText,
    this.getDiProfile,
    this.getActiveFeed,
  });

  @override
  State<HomeTopMenu> createState() => _HomeTopMenuState();
}

class _HomeTopMenuState extends State<HomeTopMenu> {
  final epanduRepo = EpanduRepo();
  final myImage = ImagesConstant();
  final customDialog = CustomDialog();
  String barcode = "";
  final inboxRepo = InboxRepo();
  final localStorage = LocalStorage();

  getUnreadNotificationCount() async {
    var result = await inboxRepo.getUnreadNotificationCount();

    if (result.isSuccess) {
      if (!context.mounted) return;
      if (int.tryParse(result.data[0].msgCount)! > 0) {
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: true,
        );

        Provider.of<NotificationCount>(context, listen: false)
            .updateNotificationBadge(
          notificationBadge: int.tryParse(result.data[0].msgCount),
        );
      } else {
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: false,
        );
      }
    } else {
      if (!context.mounted) return;
      Provider.of<NotificationCount>(context, listen: false).setShowBadge(
        showBadge: false,
      );
    }
  }

  /* registerUserToDi(barcode) async {
    ScanResponse scanResponse = ScanResponse.fromJson(jsonDecode(barcode));

    var result = await authRepo.registerUserToDI(
      context: context,
      // name: scanResponse.name,
      // phoneCountryCode: scanResponse.phoneCountryCode,
      // phone: scanResponse.phone,
      // userId: scanResponse.userId,
      scanCode: barcode,
    );

    if (result.isSuccess) {
      Navigator.push(context, REGISTER_USER_TO_DI,
          arguments: ScanResultArgument(
            barcode: scanResponse,
            status: 'success',
          ));
    } else {
      Navigator.push(context, REGISTER_USER_TO_DI,
          arguments: ScanResultArgument(
            barcode: scanResponse,
            status: 'fail',
          ));
    }
  } */

  @override
  Widget build(BuildContext context) {
    bool showBadge = context.watch<NotificationCount>().showBadge;
    int? badgeNo = context.watch<NotificationCount>().notificationBadge;
    int notificationCount = 0;
    List<ChatNotification> chatNotificationCount =
        context.watch<ChatNotificationCount>().getChatNotificationCountList;
    for (var chatNotification in chatNotificationCount) {
      notificationCount += chatNotification.notificationBadge!;
    }
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Table(
            // border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  InkWell(
                    onTap: () => context.router.push(
                      Scan(
                        getActiveFeed: widget.getActiveFeed,
                        getDiProfile: widget.getDiProfile,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            MyCustomIcons.scanIcon,
                            size: 26,
                            color: Color(0xff808080),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('scan_lbl'),
                              style: widget.iconText),
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () => context.router.push(Pay()),
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           MyCustomIcons.scan_helper,
                  //           size: 26,
                  //           color: Color(0xff808080),
                  //         ),
                  //         SizedBox(height: ScreenUtil().setHeight(20)),
                  //         Text(
                  //             AppLocalizations.of(context)!
                  //                 .translate('pay_lbl'),
                  //             style: widget.iconText),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () => context.router.push(const Pay()),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.card_giftcard,
                            size: 26,
                            color: Color(0xff808080),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Text('Reward', style: widget.iconText),
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () => context.router.push(Invite()),
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       vertical: 8.0,
                  //     ),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           MyCustomIcons.invite_icon,
                  //           size: 26,
                  //           color: Color(0xff808080),
                  //         ),
                  //         SizedBox(height: ScreenUtil().setHeight(20)),
                  //         Text(
                  //           AppLocalizations.of(context)!
                  //               .translate('invite_lbl'),
                  //           style: widget.iconText,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () => context.router.push(const Invite()),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.share,
                            size: 26,
                            color: Color(0xff808080),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Text(
                            'Share',
                            style: widget.iconText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Image.memory(kTransparentImage,
                            width: ScreenUtil().setWidth(150)),
                      ],
                    ),
                  ), */
                  InkWell(
                    onTap: () => context.router.push(const IdentityBarcode()),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            MyCustomIcons.idIcon,
                            size: 26,
                            color: Color(0xff808080),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Text(
                              AppLocalizations.of(context)!.translate('id_lbl'),
                              style: widget.iconText),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => context.router
                        .push(const Inbox())
                        .then((value) => getUnreadNotificationCount()),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          badges.Badge(
                            showBadge: showBadge,
                            badgeContent: Text(
                              '$badgeNo',
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: const Icon(
                              MyCustomIcons.inboxIcon,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Text(
                              AppLocalizations.of(context)!
                                  .translate('inbox_lbl'),
                              style: widget.iconText),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => context.router.push(const RoomList()),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          badges.Badge(
                            showBadge: notificationCount > 0 ? true : false,
                            badgeContent: Text(
                              '$notificationCount',
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: const Icon(
                              Icons.chat,
                              size: 26,
                              color: Color(0xff808080),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Text(AppLocalizations.of(context)!.translate('chat'),
                              style: widget.iconText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        /* Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () =>
                context.router.push(Routes.epanduCategory),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: EdgeInsets.only(
                top: 85.h,
              ),
              // margin: EdgeInsets.only(bottom: 80.h),
              child: Column(
                children: <Widget>[
                  FadeInImage(
                    alignment: Alignment.center,
                    placeholder: MemoryImage(kTransparentImage),
                    height: 90.h,
                    image: AssetImage(
                      myImage.logo2,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(AppLocalizations.of(context).translate('log_in'),
                      style: widget.iconText),
                ],
              ),
            ),
          ),
        ), */
      ],
    );
  }
}
