import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
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
          colorBrightness: ColorBrightness.light,
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Choose your module'),
      ),
      body: FutureBuilder(
          future: _getExamNo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          KppModuleIcon(
                              component: KPP_QUESTIONS,
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
                                      size: 45.0, color: Colors.grey.shade800)
                                  : Icon(Icons.library_books,
                                      size: 40.0, color: Colors.grey.shade800)),
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
            ));
          }),
    );
  }
}
