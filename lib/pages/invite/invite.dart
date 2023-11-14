import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

@RoutePage(name: 'Invite')
class Invite extends StatefulWidget with PageBaseClass {
  const Invite({super.key});

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> with PageBaseClass {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  bool _isLoading = false;
  final primaryColor = ColorConstant.primaryColor;
  final image = ImagesConstant();

  // hardcode +60 for now
  String? _countryCode = '+60';
  String? _phone = '';
  String? _name = '';
  String? _message = '';
  TextStyle _messageStyle = const TextStyle(color: Colors.red);

  final AuthRepo authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return defaultLayout();
      }
      return tabLayout();
    });
  }

  defaultLayout() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfffdc013),
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.translate('invite_your_friends_lbl'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Opacity(
                opacity: 0.9,
                child: FadeInImage(
                  height: 1100.h,
                  width: ScreenUtil().screenWidth,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    image.friend,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 110.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CountryCodePicker(
                            onChanged: (value) {
                              setState(() {
                                _countryCode = value.code;
                              });
                            },
                            padding: EdgeInsets.only(top: 62.h),
                            initialSelection: 'MY',
                            favorite: const ['+60', 'MY'],
                            showFlagMain: true,
                            alignLeft: false,
                            enabled: false,
                            textStyle: TextStyle(
                              fontSize: 58.sp,
                              color: const Color(0xff808080),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              focusNode: _phoneFocus,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 0, 0, -60.h),
                                /* hintStyle: TextStyle(
                                    color: Colors.blue,
                                  ), */
                                hintText: AppLocalizations.of(context)!
                                    .translate('phone_lbl'),
                              ),
                              onFieldSubmitted: (term) {
                                fieldFocusChange(
                                    context, _phoneFocus, _nameFocus);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .translate('phone_required_msg');
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != _phone) {
                                  _phone = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 130.w),
                      child: TextFormField(
                        focusNode: _nameFocus,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, -60.h),
                          /* hintStyle: TextStyle(
                                      color: Colors.blue,
                                    ), */
                          hintText: AppLocalizations.of(context)!
                              .translate('nick_name_lbl'),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .translate('name_required_msg');
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != _name) {
                            _name = value;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _message!.isNotEmpty
                          ? Text(
                              _message!,
                              style: _messageStyle,
                            )
                          : const SizedBox.shrink(),
                      Container(
                        child: _isLoading
                            ? const SpinKitFoldingCube(
                                color: Colors.blue,
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: const Color(0xffdd0e0e),
                                  minimumSize: Size(420.w, 45.h),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11.0),
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                onPressed: _submit,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('invite_btn'),
                                  style: TextStyle(
                                    fontSize: 60.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
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
    );
  }

  tabLayout() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfffdc013),
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.translate('invite_your_friends_lbl'),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Opacity(
                opacity: 0.9,
                child: FadeInImage(
                  height: 1100.h,
                  width: ScreenUtil().screenWidth,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    image.friend,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100.w, 35.h, 100.w, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 35.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 105.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CountryCodePicker(
                              onChanged: (value) {
                                setState(() {
                                  _countryCode = value.code;
                                });
                              },
                              padding: EdgeInsets.only(top: 52.h),
                              initialSelection: 'MY',
                              favorite: const ['+60', 'MY'],
                              showFlagMain: true,
                              alignLeft: false,
                              enabled: false,
                              textStyle: TextStyle(
                                fontSize: 40.sp,
                                color: const Color(0xff808080),
                              ),
                            ),
                            Container(
                              width: 865.w,
                              margin: EdgeInsets.only(left: 10.w),
                              child: TextFormField(
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  color: const Color(0xff808080),
                                ),
                                focusNode: _phoneFocus,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[700]!, width: 1.6),
                                    // borderRadius: BorderRadius.circular(30),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 0, 0, -60.h),
                                  /* hintStyle: TextStyle(
                                      color: Colors.blue,
                                    ), */
                                  hintText: AppLocalizations.of(context)!
                                      .translate('phone_lbl'),
                                ),
                                onFieldSubmitted: (term) {
                                  fieldFocusChange(
                                      context, _phoneFocus, _nameFocus);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .translate('phone_required_msg');
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  if (value != _phone) {
                                    _phone = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 105.w),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: const Color(0xff808080),
                          ),
                          focusNode: _nameFocus,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue[700]!, width: 1.6),
                              // borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, -60.h),
                            /* hintStyle: TextStyle(
                                        color: Colors.blue,
                                      ), */
                            hintText: AppLocalizations.of(context)!
                                .translate('nick_name_lbl'),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .translate('name_required_msg');
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != _name) {
                              _name = value;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _message!.isNotEmpty
                          ? Text(
                              _message!,
                              style: _messageStyle,
                            )
                          : const SizedBox.shrink(),
                      Container(
                        child: _isLoading
                            ? const SpinKitFoldingCube(
                                color: Colors.blue,
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(420.w, 45.h),
                                  backgroundColor: const Color(0xffdd0e0e),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11.0),
                                  shape: const StadiumBorder(),
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                onPressed: _submit,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate('invite_btn'),
                                  style: TextStyle(
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
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
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      String? userId = await LocalStorage().getUserId();

      setState(() {
        _isLoading = true;
        _message = '';
      });
      if (!context.mounted) return;
      var result = await authRepo.getUserByUserPhone(
        context: context,
        countryCode: _countryCode,
        phone: _phone!.replaceAll(' ', ''),
        userId: userId,
        name: _name,
        scenario: 'INVITE',
      );

      if (result.isSuccess) {
        setState(() {
          _message = result.message;
          _messageStyle = const TextStyle(color: Colors.green);
        });
      } else {
        setState(() {
          _message = result.message;
          _messageStyle = const TextStyle(color: Colors.red);
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
