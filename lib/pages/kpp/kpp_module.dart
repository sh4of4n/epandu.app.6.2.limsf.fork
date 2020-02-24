import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/api/model/kpp_model.dart';
import 'package:epandu/services/repo/kpp_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
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
  final customDialog = CustomDialog();
  var snapshot;
  String message = '';
  String pinMessage = '';
  String appBarTitle = '';

  final List<Color> _iconColors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getTheoryQuestionPaperNoWithCreditControl();
  }

  _getTheoryQuestionPaperNoWithCreditControl() async {
    String groupId = widget.data;

    var result = await kppRepo.getTheoryQuestionPaperNoWithCreditControl(
        context: context, groupId: groupId);

    if (result.isSuccess) {
      _getRandomColors(result.data);

      setState(() {
        appBarTitle = AppLocalizations.of(context).translate('choose_module');
        message = '';
        snapshot = result.data;
      });
    } else {
      setState(() {
        appBarTitle =
            AppLocalizations.of(context).translate('activate_pin_title');
        message = result.message;
      });
    }
  }

  _getRandomColors(result) {
    for (var i = 0; i < result.length; i++) {
      _iconColors.add(
        _randomColor.randomColor(
          // colorHue: ColorHue.multiple(
          //     colorHues: [ColorHue.green, ColorHue.blue]),
          colorBrightness: ColorBrightness.dark,
          colorSaturation: ColorSaturation.mediumSaturation,
        ),
      );
    }
  }

  _renderModule() {
    if (snapshot != null) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: MediaQuery.of(context).size.height / 530,
        ),
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.length,
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
                        paperNo: snapshot[index].paperNo,
                      ),
                      iconColor: _iconColors[index],
                      snapshot: snapshot,
                      index: index,
                      icon: snapshot[index].paperNo.contains('COB')
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
    } else if (snapshot == null && message.isNotEmpty) {
      return Column(
        children: <Widget>[
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: MediaQuery.of(context).size.height / 530,
            ),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 17.0),
                child: KppModuleIcon(
                  component: KPP_EXAM,
                  argument: KppModuleArguments(
                    groupId: widget.data,
                    paperNo: 'COB 1',
                  ),
                  iconColor: Colors.green[600],
                  label: 'COB-1',
                  icon: Icon(Icons.color_lens,
                      size: ScreenUtil().setSp(250), color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 17.0),
                child: KppModuleIcon(
                  component: KPP_EXAM,
                  argument: KppModuleArguments(
                    groupId: widget.data,
                    paperNo: 'DEMO',
                  ),
                  iconColor: Colors.blue[600],
                  label: 'DEMO',
                  icon: Icon(Icons.library_books,
                      size: ScreenUtil().setSp(250), color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, PIN_ACTIVATION,
                  arguments: widget.data),
              child: Text(
                'Get more questions.',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(70),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Center(
      child: SpinKitFoldingCube(
        color: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.amber.shade50,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(appBarTitle),
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
            _renderModule(),
          ],
        ),
      ),
    );
  }
}
