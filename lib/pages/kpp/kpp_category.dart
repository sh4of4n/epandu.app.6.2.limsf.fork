import 'dart:convert';
import 'dart:typed_data';

import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'kpp_category_icon.dart';

class KppCategory extends StatefulWidget {
  @override
  _KppCategoryState createState() => _KppCategoryState();
}

class _KppCategoryState extends State<KppCategory> {
  final kppRepo = KppRepo();
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  Uint8List instituteLogo;
  bool isLogoLoaded = false;
  final primaryColor = ColorConstant.primaryColor;

  @override
  void initState() {
    super.initState();

    _getInstituteLogo();
  }

  _getInstituteLogo() async {
    String instituteLogoBase64 = await localStorage.getInstituteLogo();

    if (instituteLogoBase64.isEmpty) {
      var result = await kppRepo.getInstituteLogo(context: context);

      if (result.data != null) {
        Uint8List decodedImage = base64Decode(result.data);

        setState(() {
          instituteLogo = decodedImage;
          isLogoLoaded = true;
        });
      }
    } else {
      Uint8List decodedImage = base64Decode(instituteLogoBase64);

      setState(() {
        instituteLogo = decodedImage;
        isLogoLoaded = true;
      });
    }
  }

  _customContainer() {
    return Container(
      width: 294,
      height: 154,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate('choose_category')),
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
              AnimatedCrossFade(
                crossFadeState: isLogoLoaded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 1500),
                firstChild: instituteLogo != null
                    ? Image.memory(
                        instituteLogo,
                        semanticLabel: 'ePandu',
                      )
                    : _customContainer(),
                secondChild: _customContainer(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    KppCategoryIcon(
                      component: MODULE,
                      argument: 'KPP-D',
                      width: ScreenUtil().setWidth(600),
                      height: ScreenUtil().setHeight(500),
                      borderWidth: 5.0,
                      borderColor: Colors.indigoAccent,
                      image: image.car,
                    ),
                    KppCategoryIcon(
                      component: MODULE,
                      argument: 'KPP-B',
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

  void dispose() {
    super.dispose();
  }
}
