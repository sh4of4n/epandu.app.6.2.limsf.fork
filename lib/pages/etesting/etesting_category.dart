import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

// import 'bottom_menu.dart';

@RoutePage(name: 'EtestingCategory')
class EtestingCategory extends StatelessWidget {
  final authRepo = AuthRepo();
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    color: Colors.black,
  );
  final myImage = ImagesConstant();

  EtestingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
          iconTheme: const IconThemeData(
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
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () => context.router.push(const ComingSoon()),
                    title: Text('Tempahan Ujian', style: iconText),
                  ),
                  Divider(color: Colors.grey[400]),
                  ListTile(
                    onTap: () => context.router.push(const CheckInSlip()),
                    title: Text('Rekod Ujian Memandu', style: iconText),
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
