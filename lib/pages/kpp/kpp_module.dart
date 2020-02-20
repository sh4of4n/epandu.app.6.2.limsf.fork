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
import 'package:google_fonts/google_fonts.dart';
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
  String pinMessage = '';
  String _pin;
  var _height = ScreenUtil.getInstance().setHeight(900);
  bool _isLoading = false;
  String appBarTitle = '';

  final List<Color> _iconColors = [];

  @override
  void initState() {
    super.initState();

    _getExamNo();
  }

  _getExamNo() async {
    String groupId = widget.data;

    var result = await kppRepo.getExamNo(context: context, groupId: groupId);

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
      return Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 90.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1500),
          curve: Curves.elasticOut,
          width: double.infinity,
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0,
              ),
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(35),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                      hintStyle: TextStyle(
                        color: primaryColor,
                      ),
                      labelText:
                          AppLocalizations.of(context).translate('pin_lbl'),
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
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('pin_required_msg');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != _pin) {
                        _pin = value;
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(60),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Wrap(
                      children: <Widget>[
                        Text(AppLocalizations.of(context)
                            .translate('activate_pin')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          pinMessage.isNotEmpty
                              ? Text(
                                  pinMessage,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox.shrink(),
                          _submitButton(),
                          SizedBox(height: ScreenUtil().setHeight(30)),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              KPP_EXAM,
                              arguments: KppModuleArguments(
                                groupId: widget.data,
                                paperNo: 'DEMO',
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('demo_desc_1'),
                                style: GoogleFonts.dosis(
                                  fontWeight: FontWeight.w500,
                                  textStyle: TextStyle(color: Colors.black),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .translate('demo_desc_2'),
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(55),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Center(
      child: SpinKitFoldingCube(
        color: primaryColor,
      ),
    );
  }

  _submitButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ButtonTheme(
              minWidth: ScreenUtil.getInstance().setWidth(420),
              padding: EdgeInsets.symmetric(vertical: 11.0),
              buttonColor: primaryColor,
              shape: StadiumBorder(),
              child: RaisedButton(
                onPressed: _submit,
                textColor: Colors.white,
                child: Text(
                  AppLocalizations.of(context).translate('submit_btn'),
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(56),
                  ),
                ),
              ),
            ),
    );
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FocusScope.of(context).requestFocus(new FocusNode());

      setState(() {
        _height = ScreenUtil.getInstance().setHeight(900);
        _isLoading = true;
      });

      var result = await kppRepo.pinActivation(
          context: context, pinNumber: _pin, groupId: widget.data);

      if (result.isSuccess) {
        setState(() {
          pinMessage = '';
          message = '';
          // snapshot = result.data['PaperNo'];
        });

        _getExamNo();
      } else {
        setState(() {
          pinMessage = result.message;
        });
      }
    } else {
      setState(() {
        _height = ScreenUtil.getInstance().setHeight(1000);
      });
    }

    setState(() {
      _isLoading = false;
    });
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
