import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_color/random_color.dart';

import 'kpp_module_icon.dart';

class KppModule extends StatefulWidget {
  final data;

  KppModule(this.data);

  @override
  _KppModuleState createState() => _KppModuleState();
}

class _KppModuleState extends State<KppModule> {
  final kppRepo = KppRepo();
  final primaryColor = ColorConstant.primaryColor;
  RandomColor _randomColor = RandomColor();

  final List<Color> _iconColors = [];

  _getExamNo() async {
    String groupId = widget.data;

    var result = await kppRepo.getExamNo(groupId);

    if (result.isSuccess) {
      _getRandomColors(result.data['PaperNo']);

      return result.data['PaperNo'];
    }
  }

  _getRandomColors(result) {
    for (var i = 0; i < result.length; i++) {
      _iconColors.add(
        _randomColor.randomColor(
          // colorHue: ColorHue.multiple(
          //     colorHues: [ColorHue.green, ColorHue.blue]),
          colorBrightness: ColorBrightness.dark,
          colorSaturation: ColorSaturation.highSaturation,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text('Choose your module'),
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
          FutureBuilder(
            future: _getExamNo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: MediaQuery.of(context).size.height / 530,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            KppModuleIcon(
                                component: KPP_EXAM,
                                argument: KppModuleArguments(
                                  groupId: widget.data,
                                  paperNo: snapshot.data[index]["paper_no"],
                                ),
                                iconColor: _iconColors[index],
                                snapshot: snapshot,
                                index: index,
                                icon: snapshot.data[index]["paper_no"]
                                        .contains('COB')
                                    ? Icon(Icons.color_lens,
                                        size: ScreenUtil().setSp(250),
                                        color: Colors.white)
                                    : Icon(Icons.library_books,
                                        size: ScreenUtil().setSp(250),
                                        color: Colors.white)),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
              return Center(
                child: SpinKitFoldingCube(
                  color: primaryColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
