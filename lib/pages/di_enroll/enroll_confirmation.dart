import 'package:auto_route/auto_route.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/custom_dialog.dart';
import 'package:epandu/widgets/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/utils/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/services/repository/fpx_repository.dart';

import '../../app_localizations.dart';
import '../../router.gr.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class EnrollConfirmation extends StatefulWidget {
  final String packageCode;
  final String packageDesc;
  final String termsAndCondition;

  EnrollConfirmation({
    this.packageCode,
    this.packageDesc,
    this.termsAndCondition,
  });

  @override
  _EnrollConfirmationState createState() => _EnrollConfirmationState();
}

class _EnrollConfirmationState extends State<EnrollConfirmation> {
  final fpxRepo = FpxRepo();
  final authRepo = AuthRepo();
  final profileRepo = ProfileRepo();
  final localStorage = LocalStorage();
  final customDialog = CustomDialog();
  final removeBracket = RemoveBracket.remove;

  String _icNo = '';
  String _name = '';
  String _eMail = '';
  String _birthDate = '';
  String _race = '';
  String _nationality = '';
  String _gender = '';

  var packageDetlList;

  bool isLoading = false;
  bool _isAgreed = false;
  String message = '';

  @override
  void initState() {
    super.initState();

    _getUserProfile();
  }

  _getUserProfile() async {
    setState(() {
      isLoading = true;
    });

    var result = await profileRepo.getUserProfile(context: context);

    if (result.isSuccess) {
      setState(() {
        _name = result.data[0].name;
        _eMail = result.data[0].eMail;
        _icNo = result.data[0].icNo;
        _birthDate = result.data[0].birthDate;
        _race = result.data[0].race;
        _nationality = result.data[0].nationality;
        _gender = result.data[0].gender;
      });

      localStorage.saveName(result.data[0].name);
      localStorage.saveNickName(result.data[0].nickName);
      localStorage.saveEmail(result.data[0].eMail);
      localStorage.saveUserPhone(result.data[0].phone);
      localStorage.saveCountry(result.data[0].countryName);
      localStorage.saveState(result.data[0].stateName);
      localStorage.saveStudentIc(result.data[0].icNo);
      localStorage.saveBirthDate(result.data[0].birthDate);
      localStorage.saveRace(result.data[0].race);
      localStorage.saveNationality(result.data[0].nationality);
      localStorage.saveGender(result.data[0].gender);
      if (result.data[0].picturePath != null)
        localStorage.saveProfilePic(result.data[0].picturePath
            .replaceAll(removeBracket, '')
            .split('\r\n')[0]);
    } else {
      _getUserInfo();
    }

    if (_icNo == null ||
        _birthDate == null ||
        _race == null ||
        _eMail == null ||
        _gender == null) {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        content:
            AppLocalizations.of(context).translate('complete_your_profile'),
        customActions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('ok_btn')),
            onPressed: () => ExtendedNavigator.of(context).pushAndRemoveUntil(
              Routes.updateProfile,
              ModalRoute.withName(Routes.home),
            ),
          ),
        ],
        type: DialogType.GENERAL,
      );
    }

    getPackageDetlList();
  }

  _getUserInfo() async {
    String _getName = await localStorage.getName();
    String _getEmail = await localStorage.getEmail();
    String _getStudentIc = await localStorage.getStudentIc();

    String _getBirthDate = await localStorage.getBirthDate();
    String _getRace = await localStorage.getRace();
    String _getNationality = await localStorage.getNationality();
    String _getGender = await localStorage.getGender();

    setState(() {
      _name = _getName;
      _eMail = _getEmail;
      _icNo = _getStudentIc;
      _birthDate = _getBirthDate;
      _race = _getRace;
      _nationality = _getNationality;
      _gender = _getGender;
    });
  }

  getPackageDetlList() async {
    var diCode = await localStorage.getMerchantDbCode();

    var result = await authRepo.getPackageDetlList(
      context: context,
      diCode: diCode,
      packageCode: widget.packageCode,
    );

    if (result.isSuccess) {
      setState(() {
        packageDetlList = result.data;
      });
    } else {
      setState(() {
        packageDetlList = null;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  saveEnrollmentPackageWithParticular() async {
    if (_isAgreed) {
      setState(() {
        message = '';
        isLoading = true;
      });

      var diCode = await localStorage.getMerchantDbCode();

      var result = await authRepo.saveEnrollmentPackageWithParticular(
        context: context,
        diCode: diCode,
        icNo: _icNo,
        name: _name,
        email: _eMail,
        packageCode: packageDetlList[0].packageCode,
        gender: _gender,
        dateOfBirthString: _birthDate,
        nationality: _nationality,
        race: _race,
        userProfileImageBase64String: "",
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
          content:
              AppLocalizations.of(context).translate('select_payment_method'),
          type: DialogType.GENERAL,
          customActions: <Widget>[
            FlatButton(
              child: Text(
                  AppLocalizations.of(context).translate('pay_at_institute')),
              onPressed: () => ExtendedNavigator.of(context).popUntil(
                ModalRoute.withName(Routes.home),
              ),
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('pay_online')),
              onPressed: createOrder,
            ),
          ],
        );
      } else {
        customDialog.show(
          context: context,
          barrierDismissable: false,
          type: DialogType.GENERAL,
          content: result.message.toString(),
          customActions: [
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('view_order')),
              onPressed: createOrder,
            ),
          ],
        );
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        message = AppLocalizations.of(context)
            .translate('agree_to_terms_and_condition');
      });
    }
  }

  createOrder() async {
    ExtendedNavigator.of(context).pop();

    setState(() {
      isLoading = true;
    });

    var diCode = await localStorage.getMerchantDbCode();

    var result = await fpxRepo.createOrder(
      context: context,
      diCode: diCode,
      icNo: _icNo,
      packageCode: packageDetlList[0].packageCode,
    );

    if (result.isSuccess) {
      ExtendedNavigator.of(context).push(
        Routes.orderList,
        arguments: OrderListArguments(
          icNo: _icNo,
          packageCode: packageDetlList[0].packageCode,
        ),
      );
    } else {
      customDialog.show(
        context: context,
        type: DialogType.ERROR,
        content: result.message.toString(),
        onPressed: () => ExtendedNavigator.of(context).pop(),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('enroll_lbl'),
        ),
        actions: [
          IconButton(
            onPressed: () => ExtendedNavigator.of(context).pushAndRemoveUntil(
              Routes.updateProfile,
              ModalRoute.withName(Routes.home),
            ),
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.w, vertical: 50.h),
                  child: Table(
                    children: [
                      if (_icNo != null)
                        TableRow(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('ic_lbl')),
                            Text(_icNo),
                          ],
                        ),
                      if (_name != null)
                        TableRow(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('name_lbl')),
                            Text(_name),
                          ],
                        ),
                      if (packageDetlList != null &&
                          packageDetlList[0].merchantNo != null)
                        TableRow(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('institute_lbl')),
                            Text(packageDetlList[0].merchantNo),
                          ],
                        ),
                      if (packageDetlList != null &&
                          packageDetlList[0].packageCode != null)
                        TableRow(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('package_lbl')),
                            Text(packageDetlList[0].packageCode,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      /* if (packageDetlList != null &&
                          packageDetlList[0].prodDesc != null)
                        TableRow(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('description')),
                            Text(packageDetlList[0].prodDesc),
                          ],
                        ), */
                      /* if (packageDetlList != null &&
                          packageDetlList[0].amt != null)
                        TableRow(
                          children: [
                            Text(AppLocalizations.of(context)
                                .translate('amount')),
                            Text(
                              'RM' + packageDetlList[0].amt,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 56.sp,
                              ),
                            ),
                          ],
                        ), */
                    ],
                  ),
                ),
                if (packageDetlList != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('package_includes'),
                          style: TextStyle(
                              fontSize: 54.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: packageDetlList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Table(
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                        '${index + 1})  ${packageDetlList[index].prodDesc}'),
                                    Text('RM' + packageDetlList[index].amt),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 40.h),
                Container(
                  width: 1300.w,
                  height: 1000.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: HtmlWidget(
                          widget.termsAndCondition,
                        ),
                      ),
                    ],
                  ),
                ),
                LabeledCheckbox(
                  label: AppLocalizations.of(context)
                      .translate('terms_and_condition'),
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  value: _isAgreed,
                  onChanged: (bool value) {
                    setState(() {
                      _isAgreed = value;
                    });
                  },
                ),
                if (message.isNotEmpty)
                  Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                CustomButton(
                  onPressed: saveEnrollmentPackageWithParticular,
                  buttonColor: Color(0xffdd0e0e),
                  title: AppLocalizations.of(context).translate('enroll_lbl'),
                ),
              ],
            ),
          ),
          LoadingModel(
            isVisible: isLoading,
          ),
        ],
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}

/* 
Container(
  width: 1300.w,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomButton(
        minWidth: 500.w,
        onPressed: () =>
            ExtendedNavigator.of(context).push(Routes.enrollment),
        buttonColor: Color(0xffdd0e0e),
        title: AppLocalizations.of(context)
            .translate('pay_at_institute'),
      ),
      CustomButton(
        minWidth: 500.w,
        onPressed: () {},
        buttonColor: Color(0xffdd0e0e),
        title: AppLocalizations.of(context).translate('pay_online'),
      ),
    ],
  ),
),
*/
