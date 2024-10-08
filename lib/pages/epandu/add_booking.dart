import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/epandu_model.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/new_custom_dialog.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';

@RoutePage(name: 'AddBooking')
class AddBooking extends StatefulWidget {
  const AddBooking({super.key});

  @override
  State<AddBooking> createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  final _formKey = GlobalKey<FormState>();
  final ePanduRepo = EpanduRepo();
  final image = ImagesConstant();
  final customDialog = CustomDialog();

  List<GroupIdTest> testListGroupId = [];
  List<TestTypeTest> testListTestType = [];
  List<Test> testList = [];
  var courseSectionlist;

  String? groupId = '';
  String? testType = '';
  String? section = '';
  String? testDate = '';

  final dateFormat = DateFormat('yyyy-MM-dd', 'en_MY');

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _getTestListGroupIdByIcNo();
  }

  _getTestListGroupIdByIcNo() async {
    await EasyLoading.show();
    Response<List<GroupIdTest>?> response =
        await ePanduRepo.getTestListGroupIdByIcNo(
    );
    await EasyLoading.dismiss();
    if (!mounted) return;
    if (response.isSuccess) {
      setState(() {
        testListGroupId = response.data ?? [];
      });
    } else {
      if (!context.mounted) return;
      // await customDialog.show(
      //   context: context,
      //   content: AppLocalizations.of(context)!.translate('no_enrolled_class'),
      //   barrierDismissable: false,
      //   customActions: <Widget>[
      //     TextButton(
      //       child: Text(AppLocalizations.of(context)!.translate('ok_btn')),
      //       onPressed: () => context.router.popUntil(
      //         ModalRoute.withName('EpanduCategory'),
      //       ),
      //     )
      //   ],
      //   type: DialogType.general,
      // );
      await NewCustomDialog().show(
        context: context,
        content: AppLocalizations.of(context)!.translate('no_enrolled_class'),
        barrierDismissible: false,
      );
      if (!mounted) return;
      context.router.pop();
    }
  }

  _getTestListTestType() async {
    Response<List<TestTypeTest>?> response =
        await ePanduRepo.getTestListTestType(
      context: context,
      groupId: groupId,
    );

    if (response.isSuccess) {
      setState(() {
        testListTestType = response.data ?? [];
      });
    }
  }

  _getCourseSectionList() async {
    var response = await ePanduRepo.getCourseSectionList(
      context: context,
      groupId: groupId,
    );

    if (response.isSuccess) {
      setState(() {
        courseSectionlist = response.data;
      });
    } else {
      return response.message;
    }
  }

  _getTestList() async {
    Response<List<Test>?> response = await ePanduRepo.getTestList(
      context: context,
      groupId: groupId,
      testType: testType,
    );

    if (response.isSuccess) {
      setState(() {
        testList = response.data ?? [];
      });
    } else {
      return response.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: const Color(0xfffdc013),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('booking')),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeInImage(
                alignment: Alignment.center,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(
                  image.advertBanner,
                ),
              ),
              SizedBox(height: 20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 60.w),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 60.w,
                          ),
                          labelText:
                              AppLocalizations.of(context)!.translate('group_id'),
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
                        ),
                        disabledHint: Text(
                            AppLocalizations.of(context)!.translate('group_id')),
                        value: groupId!.isEmpty ? null : groupId,
                        onChanged: (value) {
                          setState(() {
                            groupId = value;
                            testType = '';
                            testDate = '';
                            testListTestType = [];
                            testList = [];
                            courseSectionlist = null;
    
                            _getTestListTestType();
                            _getCourseSectionList();
    
                            if (groupId!.isNotEmpty && testType!.isNotEmpty) {
                              _getTestList();
                            }
                          });
                        },
                        items: testListGroupId
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value.groupId,
                            child: Text(value.groupId),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('group_id_required');
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 60.w),
                      child: DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 60.w,
                          ),
                          labelText:
                              AppLocalizations.of(context)!.translate('type'),
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
                        ),
                        disabledHint: Text(
                            AppLocalizations.of(context)!.translate('type'),
                            style: const TextStyle(color: Color(0xff808080))),
                        value: testType!.isEmpty ? null : testType,
                        onChanged: (value) {
                          setState(() {
                            testType = value;
    
                            if (groupId!.isNotEmpty && testType!.isNotEmpty) {
                              testDate = '';
                              testList = [];
                              _getTestList();
                            }
                          });
                        },
                        items:
                            /* testList == null
                            ? null
                            : testList.map<DropdownMenuItem<dynamic>>((value) {
                                return DropdownMenuItem<dynamic>(
                                  value: value.testType,
                                  child: Text(value.testType),
                                );
                              }).toList(), */
                            testListTestType
                                .map<DropdownMenuItem<dynamic>>((value) {
                          return DropdownMenuItem<dynamic>(
                            value: value.testType,
                            child: Text(value.testType ?? ''),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('type_required');
                          }
                          return null;
                        },
                      ),
                    ),
                    if (testType == 'Practical')
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 60.w),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 60.w,
                            ),
                            labelText: AppLocalizations.of(context)!
                                .translate('section'),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue[700]!, width: 1.6),
                              // borderRadius: BorderRadius.circular(0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          disabledHint: Text(
                              AppLocalizations.of(context)!.translate('section'),
                              style: const TextStyle(color: Color(0xff808080))),
                          value: section!.isEmpty ? null : section,
                          onChanged: (value) {
                            setState(() {
                              section = value;
                            });
                          },
                          items: courseSectionlist
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.section,
                              child: Text(value.section),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!
                                  .translate('section_required');
                            }
                            return null;
                          },
                        ),
                      ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20.h, horizontal: 60.w),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 60.w,
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
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue[700]!, width: 1.6),
                            // borderRadius: BorderRadius.circular(0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        disabledHint: Text(
                          AppLocalizations.of(context)!.translate('date'),
                          style: const TextStyle(
                            color: Color(0xff808080),
                          ),
                        ),
                        value: testDate!.isEmpty ? null : testDate,
                        onChanged: (value) {
                          setState(() {
                            testDate = value;
                          });
                        },
                        items: testList.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: (value.testDate ?? '').substring(0, 10),
                            child: Text((value.testDate ?? '').substring(0, 10)),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!
                                .translate('date_required');
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  _submitButton() {
    return Container(
      child: _isLoading
          ? const SpinKitFoldingCube(
              color: Colors.blue,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(420.w, 45.h),
                backgroundColor: const Color(0xffdd0e0e),
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                shape: const StadiumBorder(),
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
    );
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      String? userId = await LocalStorage().getUserId();

      setState(() {
        _isLoading = true;
        // _message = '';
      });
      if (!context.mounted) return;
      var result = await ePanduRepo.saveBookingTest(
        context: context,
        groupId: groupId,
        testType: testType,
        testDate: testDate,
        courseSection: section,
        userId: userId,
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
          content: AppLocalizations.of(context)!.translate('booking_success'),
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
