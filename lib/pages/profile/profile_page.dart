import 'package:epandu/app_localizations.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final image = ImagesConstant();
  final localStorage = LocalStorage();

  String _name = '';
  String _nickName = '';
  String _email = '';
  String _phone = '';
  String _studentIC = '';
  String _birthDate = '';
  String _race = '';
  String _nationality = '';
  String _country = '';
  String _state = '';

  TextStyle _titleStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  final primaryColor = ColorConstant.primaryColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getUserInfo();
  }

  _getUserInfo() async {
    String _getName = await localStorage.getName();
    String _getEmail = await localStorage.getEmail();
    String _getPhone =
        await localStorage.getCountryCode() + await localStorage.getUserPhone();
    String _getStudentIc = await localStorage.getStudentIc();
    String _getCountry = await localStorage.getCountry();
    String _getState = await localStorage.getState();
    String _getBirthDate = await localStorage.getBirthDate();
    String _getRace = await localStorage.getRace();
    String _getNationality = await localStorage.getNationality();
    String _getNickName = await localStorage.getNickName();

    setState(() {
      _name = _getName;
      _nickName = _getNickName;
      _email = _getEmail;
      _phone = _getPhone.isNotEmpty ? _getPhone.substring(2) : '';
      _country = _getCountry;
      _state = _getState;
      _studentIC = _getStudentIc;
      _birthDate =
          _getBirthDate.isNotEmpty ? _getBirthDate.substring(0, 10) : '';
      _race = _getRace;
      _nationality = _getNationality;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  width: ScreenUtil.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40.h),
                      Icon(
                        Icons.account_circle,
                        color: Colors.grey[850],
                        size: 70,
                      ),
                      /* Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage(image.feedSample),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: ScreenUtil().setWidth(280),
                        height: ScreenUtil().setWidth(280),
                      ), */

                      // SizedBox(height: ScreenUtil().setHeight(30)),
                      _userInfo(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _userInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(120.0)),
      child: Container(
        child: Column(
          children: <Widget>[
            if (_name != 'null') Text('$_name', style: _titleStyle),
            if (_name != 'null')
              ListTile(
                leading: Icon(Icons.account_box),
                title:
                    Text(AppLocalizations.of(context).translate('ic_name_lbl')),
                subtitle: Text('$_name', style: _subtitleStyle),
              ),
            ListTile(
              leading: Icon(Icons.account_box),
              title:
                  Text(AppLocalizations.of(context).translate('nick_name_lbl')),
              subtitle: Text('$_nickName', style: _subtitleStyle),
            ),
            if (_studentIC != 'null')
              ListTile(
                leading: Icon(Icons.perm_identity),
                title: Text(AppLocalizations.of(context).translate('ic_lbl')),
                subtitle: Text('$_studentIC', style: _subtitleStyle),
              ),
            if (_phone != 'null')
              ListTile(
                leading: Icon(Icons.phone),
                title:
                    Text(AppLocalizations.of(context).translate('contact_no')),
                subtitle: Text('$_phone', style: _subtitleStyle),
              ),
            if (_email != 'null')
              ListTile(
                leading: Icon(Icons.email),
                title:
                    Text(AppLocalizations.of(context).translate('email_lbl')),
                subtitle: Text(
                    _email.isNotEmpty
                        ? '$_email'
                        : AppLocalizations.of(context).translate('no_email'),
                    style: _subtitleStyle),
              ),
            if (_birthDate != 'null')
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(AppLocalizations.of(context).translate('dob_lbl')),
                subtitle: Text('$_birthDate', style: _subtitleStyle),
              ),
            SizedBox(height: ScreenUtil().setHeight(20)),
          ],
        ),
      ),
    );
  }
}
