import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/common_library/services/repository/kpp_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';
import 'kpp_category_icon.dart';

@RoutePage(name: 'KppCategory')
class KppCategory extends StatefulWidget {
  const KppCategory({super.key});

  @override
  State<KppCategory> createState() => _KppCategoryState();
}

class _KppCategoryState extends State<KppCategory> {
  final authRepo = AuthRepo();
  final kppRepo = KppRepo();
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  String? instituteLogo = '';
  bool isLogoLoaded = false;
  final primaryColor = ColorConstant.primaryColor;

  @override
  void initState() {
    super.initState();

    _getDiProfile();
  }

  _getDiProfile() async {
    String? instituteLogoPath = await localStorage.getInstituteLogo();

    if (instituteLogoPath != null && instituteLogoPath.isEmpty) {
      if (!context.mounted) return;
      var result = await authRepo.getDiProfile(context: context);

      if (result.isSuccess && result.data != null) {
        // Uint8List decodedImage = base64Decode(
        //     result.data);

        setState(() {
          instituteLogo = result.data;
          isLogoLoaded = true;
        });
      }
    } else {
      // Uint8List decodedImage = base64Decode(instituteLogoPath);

      setState(() {
        instituteLogo = instituteLogoPath;
        isLogoLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.translate('choose_category')),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              height: ScreenUtil().setHeight(1000),
            ),
          ),
          Column(
            children: <Widget>[
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: (instituteLogo!.isNotEmpty
                    ? NetworkImage(instituteLogo!)
                    : MemoryImage(kTransparentImage)) as ImageProvider<Object>,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(80),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    KppCategoryIcon(
                      component: KppModule(data: 'KPP-D'),
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(500),
                      borderWidth: 5.0,
                      borderColor: Colors.indigoAccent,
                      image: image.car,
                    ),
                    KppCategoryIcon(
                      component: KppModule(data: 'KPP-B'),
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(500),
                      borderWidth: 5.0,
                      borderColor: Colors.blue,
                      image: image.motor,
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

  @override
  void dispose() {
    super.dispose();
  }
}
