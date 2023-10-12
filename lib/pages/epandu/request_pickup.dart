import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/base/page_base_class.dart';
import 'package:epandu/common_library/services/repository/pickup_repository.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

@RoutePage(name: 'RequestPickup')
class RequestPickup extends StatefulWidget {
  const RequestPickup({super.key});

  @override
  State<RequestPickup> createState() => _RequestPickupState();
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

  String? _direction = '';
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffffcd11)],
          stops: [0.45, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          // title: Text(
          //   AppLocalizations.of(context)!.translate('request_pickup'),
          // ),
          title: FadeInImage(
            alignment: Alignment.center,
            height: 110.h,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage(
              ImagesConstant().logo3,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                context.router.push(const PickupHistory());
              },
              icon: const Icon(
                Icons.history,
              ),
            ),
          ],
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
                SizedBox(
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
                      labelStyle: const TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText:
                          AppLocalizations.of(context)!.translate('date'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
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
                        return AppLocalizations.of(context)!
                            .translate('date_required');
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 1300.w,
                  child: DateTimeField(
                    focusNode: _timeFocus,
                    format: timeFormat,
                    controller: _timeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 50.h,
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xff808080),
                      ),
                      labelText:
                          AppLocalizations.of(context)!.translate('time'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.av_timer),
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
                        return AppLocalizations.of(context)!
                            .translate('time_required');
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 1300.w,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      labelText:
                          AppLocalizations.of(context)!.translate('direction'),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[700]!, width: 1.6),
                        // borderRadius: BorderRadius.circular(0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.directions),
                    ),
                    value: _direction!.isEmpty ? null : _direction,
                    items: <String>['Home', 'Driving Institute']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _direction = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)!
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
                    ? const SpinKitFoldingCube(
                        color: Colors.blue,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: const Color(0xffdd0e0e),
                          minimumSize: Size(420.w, 45.h),
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        onPressed: _submit,
                        child: Text(
                          AppLocalizations.of(context)!.translate('submit_btn'),
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(60),
                            fontWeight: FontWeight.w600,
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

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
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          barrierDismissable: false,
          title: const Center(
            child: Icon(
              Icons.check_circle_outline,
              size: 120,
              color: Colors.green,
            ),
          ),
          content: AppLocalizations.of(context)!.translate('pickup_added'),
          type: DialogType.general,
          customActions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
              onPressed: () => context.router
                  .pushAndPopUntil(const Home(), predicate: (r) => false),
            ),
          ],
        );
      } else {
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          type: DialogType.error,
          content: result.message.toString(),
          onPressed: () => context.router.pop(),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}
