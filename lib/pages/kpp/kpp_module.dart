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

  final List<Color> _iconColors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getTheoryQuestionPaperNoWithCreditControl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getTheoryQuestionPaperNoWithCreditControl() async {
    String groupId = widget.data;

    var result = await kppRepo.getTheoryQuestionPaperNoWithCreditControl(
        context: context, groupId: groupId);

    if (result.isSuccess) {
      _getRandomColors(result.data);

      if (mounted)
        setState(() {
          message = '';
          snapshot = result.data;
        });
    } else {
      if (mounted)
        setState(() {
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
                              color: Colors.white),
                      label: snapshot[index].paperNo.contains('COB')
                          ? AppLocalizations.of(context)
                                  .translate('color_blind_lbl') +
                              ' ${index + 1}'
                          : null),
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
                    paperNo: 'DEMO-BW',
                  ),
                  iconColor: Colors.green[600],
                  label:
                      AppLocalizations.of(context).translate('color_blind_lbl'),
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
                    paperNo: 'DEMO-50',
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
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
            child: ButtonTheme(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 12.0,
              ),
              shape: StadiumBorder(),
              buttonColor: Colors.amber[700],
              child: RaisedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  PIN_ACTIVATION,
                  arguments: widget.data,
                ),
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).translate('more_question_lbl'),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(65),
                  ),
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
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate('choose_module')),
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
    );
  }
}
