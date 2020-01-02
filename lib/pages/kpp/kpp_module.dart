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
  final _formKey = GlobalKey<FormState>();
  final customDialog = CustomDialog();
  var snapshot;
  String message = '';
  String _pin;

  final List<Color> _iconColors = [];

  @override
  void initState() {
    super.initState();

    _getExamNo();
  }

  _getExamNo() async {
    String groupId = widget.data;

    var result = await kppRepo.getExamNo(groupId);

    if (result.isSuccess) {
      _getRandomColors(result.data['PaperNo']);

      setState(() {
        message = '';
        snapshot = result.data['PaperNo'];
      });
    } else {
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
      GridView.builder(
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
                      icon: snapshot.data[index]["paper_no"].contains('COB')
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
    } else if (snapshot == null && message.isEmpty) {
      return Center(
        child: SpinKitFoldingCube(
          color: primaryColor,
        ),
      );
    }

    return customDialog.show(
      context: context,
      title: AppLocalizations.of(context).translate('activate_pin_title'),
      content: activationForm(),
      type: DialogType.GENERAL,
      customActions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('submit_btn')),
          onPressed: () {},
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('cancel_btn')),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
      barrierDismissable: false,
    );
  }

  activationForm() {
    return Column(
      children: <Widget>[
        Text(AppLocalizations.of(context).translate('activate_pin')),
        Form(
          key: _formKey,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              hintStyle: TextStyle(
                color: primaryColor,
              ),
              labelText: AppLocalizations.of(context).translate('phone_lbl'),
              fillColor: Colors.grey.withOpacity(.25),
              filled: true,
              prefixIcon: Icon(Icons.account_circle),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(30),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onSaved: (value) {
              if (value != _pin) {
                _pin = value;
              }
            },
          ),
        ),
      ],
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
