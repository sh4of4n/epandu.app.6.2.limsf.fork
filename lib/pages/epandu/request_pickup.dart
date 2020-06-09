import 'dart:io';

import 'package:epandu/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/services/repository/pickup_repository.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestPickup extends StatefulWidget {
  @override
  _RequestPickupState createState() => _RequestPickupState();
}

class _RequestPickupState extends State<RequestPickup> with PageBaseClass {
  final _formKey = GlobalKey<FormState>();
  final pickupRepo = PickupRepo();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("h:mm a");

  final _dateFocus = FocusNode();
  final _timeFocus = FocusNode();

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  final customDialog = CustomDialog();

  String _direction = '';
  String _date = '';
  String _time = '';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _dateController.addListener(_dateValue);
    _timeController.addListener(_timeValue);
  }

  _dateValue() {
    setState(() {
      _date = _dateController.text;
    });
  }

  _timeValue() {
    setState(() {
      _time = _timeController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffffcd11)],
          stops: [0.45, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('request_pickup'),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  width: 1300.w,
                  child: DateTimeField(
                    focusNode: _dateFocus,
                    format: dateFormat,
                    controller: _dateController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 50.h,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: AppLocalizations.of(context).translate('date'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onFieldSubmitted: (term) {
                      fieldFocusChange(
                        context,
                        _dateFocus,
                        _timeFocus,
                      );
                    },
                    onShowPicker: (context, currentValue) async {
                      // if (Platform.isIOS) {
                      if (_dateController.text.isEmpty) {
                        setState(() {
                          _dateController.text =
                              DateFormat('yyyy-MM-dd').format(
                            DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day + 1),
                          );
                        });
                      }

                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CupertinoDatePicker(
                            initialDateTime: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day + 1),
                            onDateTimeChanged: (DateTime date) {
                              setState(() {
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(date);
                              });
                            },
                            minimumDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day + 1),
                            minimumYear: DateTime.now().year,
                            maximumYear: DateTime.now().year + 1,
                            mode: CupertinoDatePickerMode.date,
                          );
                        },
                      );
                      /* } else {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day + 1),
                            initialDate: currentValue ??
                                DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1),
                            lastDate: DateTime(
                                DateTime.now().year, DateTime.now().month + 1));
                      } */
                      return null;
                    },
                    validator: (value) {
                      if (_dateController.text.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('date_required');
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 1300.w,
                  child: DateTimeField(
                    focusNode: _timeFocus,
                    format: timeFormat,
                    controller: _timeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 50.h,
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText: AppLocalizations.of(context).translate('time'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.av_timer),
                    ),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return DateTimeField.convert(time);
                    },
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)
                            .translate('time_required');
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: 1300.w,
                  child: new DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      labelText:
                          AppLocalizations.of(context).translate('direction'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700], width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.directions),
                    ),
                    value: _direction.isEmpty ? null : _direction,
                    items: <String>['Home', 'Driving Institute']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _direction = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)
                            .translate('direction_required');
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                _isLoading
                    ? SpinKitFoldingCube(
                        color: Colors.blue,
                      )
                    : ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        shape: StadiumBorder(),
                        child: RaisedButton(
                          color: Color(0xffdd0e0e),
                          textColor: Colors.white,
                          onPressed: _submit,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('submit_btn'),
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(60),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
              ],
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
        _isLoading = true;
      });

      var result = await pickupRepo.savePickup(
        context: context,
        pickupDate: _date,
        pickupTime: DateFormat("HH:mm").format(DateFormat.jm().parse(_time)),
        destination: _direction,
      );

      if (result.isSuccess) {
        customDialog.show(
          context: context,
          barrierDismissable: false,
          title: Center(
            child: Icon(
              Icons.check_circle_outline,
              size: 120,
              color: Colors.green,
            ),
          ),
          content: AppLocalizations.of(context).translate('pickup_added'),
          type: DialogType.GENERAL,
          customActions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('ok_btn')),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, HOME, (r) => false),
            ),
          ],
        );
      } else {
        customDialog.show(
          context: context,
          type: DialogType.ERROR,
          content: result.message.toString(),
          onPressed: () => Navigator.pop(context),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
