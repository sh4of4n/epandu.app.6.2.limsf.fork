// import 'package:epandu/custom_icon/my_custom_icons_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

class HomePageHeader extends StatelessWidget {
  final String? instituteLogo;
  final positionStream;

  HomePageHeader({this.instituteLogo, this.positionStream});

  final formatter = NumberFormat('#,##0.00');
  final image = ImagesConstant();

  enableSelectDi(BuildContext context) {
    List<RegisteredDiArmasterProfile?> diList = [];

    for (int i = 0; i < Hive.box('di_list').length; i += 1) {
      diList.add(Hive.box('di_list').getAt(i) as RegisteredDiArmasterProfile?);
    }

    if (Hive.box('di_list').length > 1)
      return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () => selectDi(context, diList),
          child: Icon(Icons.keyboard_arrow_down),
        ),
      );
    else
      return Expanded(
        flex: 1,
        child: Container(),
      );
  }

  selectDi(BuildContext context, diList) {
    context.router.replace(
      SelectDrivingInstitute(diList: diList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: AspectRatio(
            aspectRatio: 28 / 9,
            child: FadeInImage(
              alignment: Alignment.center,
              height: 350.h,
              fit: BoxFit.fitWidth,
              placeholder: MemoryImage(kTransparentImage),
              image: (instituteLogo!.isNotEmpty
                  ? NetworkImage(instituteLogo!)
                  : MemoryImage(kTransparentImage)) as ImageProvider<Object>,
            ),
          ),
        ),
        enableSelectDi(context),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () => context.router.push(
              ProfileTab(positionStream: positionStream),
            ),
            child: Image.asset(
              image.profileRed,
              width: 150.w,
            ),
          ),
        ),
      ],
    );
  }
}
