import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/kpp_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

@RoutePage(name: 'PinActivation')
class PinActivation extends StatefulWidget {
  final String data;

  const PinActivation(this.data, {super.key});

  @override
  _PinActivationState createState() => _PinActivationState();
}

class _PinActivationState extends State<PinActivation> {
  final kppRepo = KppRepo();

  final primaryColor = ColorConstant.primaryColor;

  final _formKey = GlobalKey<FormState>();

  String? pinMessage = '';

  String? _pin;

  bool _isLoading = false;
  // var _height = ScreenUtil().setHeight(900);

  _submitButton() {
    return Container(
      child: _isLoading
          ? SpinKitFoldingCube(
              color: primaryColor,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(420.w, 45.h),
                backgroundColor: const Color(0xffdd0e0e),
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(color: Colors.white),
              ),
              onPressed: () => _submit(context),
              child: Text(
                AppLocalizations.of(context)!.translate('submit_btn'),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(56),
                ),
              ),
            ),
    );
  }

  _submit(context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      setState(() {
        // _height = ScreenUtil().setHeight(900);
        _isLoading = true;
      });

      var result = await kppRepo.pinActivation(
          context: context, pinNumber: _pin, groupId: widget.data);

      if (result.isSuccess) {
        setState(() {
          pinMessage = '';
          // snapshot = result.data['PaperNo'];
        });

        // _getTheoryQuestionPaperNoWithCreditControl();
        context.router.pop();
      } else {
        setState(() {
          pinMessage = result.message;
        });
      }
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
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
              AppLocalizations.of(context)!.translate('activate_pin_title')),
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
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, top: 90.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.elasticOut,
                width: double.infinity,
                // height: _height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
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
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setHeight(35),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('pin_lbl'),
                            fillColor: Colors.grey.withOpacity(.25),
                            filled: true,
                            prefixIcon: const Icon(Icons.account_circle),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
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
                          height: ScreenUtil().setHeight(60),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Wrap(
                            children: <Widget>[
                              Text(AppLocalizations.of(context)!
                                  .translate('activate_pin')),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                pinMessage!.isNotEmpty
                                    ? Text(
                                        pinMessage!,
                                        style: const TextStyle(color: Colors.red),
                                      )
                                    : const SizedBox.shrink(),
                                _submitButton(),
                                SizedBox(height: ScreenUtil().setHeight(30)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
