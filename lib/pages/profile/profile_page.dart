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
  String _email = '';
  String _phone = '';
  // String _nationality = '';
  // String _gender = '';
  // String _studentIc = '';
  // String _address = '';
  String _country = '';
  String _state = '';
  // String _postCode = '';

  TextStyle _titleStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  @override
  void initState() {
    super.initState();

    _getUserInfo();
  }

  _getUserInfo() async {
    String _getName = await localStorage.getUsername();
    String _getEmail = await localStorage.getEmail();
    String _getPhone = await localStorage.getUserPhone();
    // String _getNationality = await localStorage.getNationality();
    // String _getGender = await localStorage.getGender();
    // String _getStudentIc = await localStorage.getStudentIc();
    // String _getAddress = await localStorage.getAddress();
    String _getCountry = await localStorage.getCountry();
    String _getState = await localStorage.getState();
    // String _getPostCode = await localStorage.getPostCode();

    setState(() {
      _name = _getName;
      _email = _getEmail;
      _phone = _getPhone.substring(2);
      _country = _getCountry;
      _state = _getState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /* Container(
            height: ScreenUtil.getInstance().setHeight(300),
            width: ScreenUtil.screenWidth,
            color: Colors.blue), */
        Container(
          height: ScreenUtil.getInstance().setHeight(1450),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(140.0),
              horizontal: ScreenUtil().setWidth(35.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 8.0),
                blurRadius: 10.0,
              )
            ],
          ),
        ),
        Container(
          width: ScreenUtil.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage(image.feedSample),
                    fit: BoxFit.cover,
                  ),
                ),
                width: ScreenUtil.getInstance().setWidth(280),
                height: ScreenUtil.getInstance().setWidth(280),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              _userInfo(),
            ],
          ),
        ),
      ],
    );
  }

  _userInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(120.0)),
      child: Column(
        children: <Widget>[
          if (_name != 'null') Text('$_name', style: _titleStyle),
          if (_phone != 'null')
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(AppLocalizations.of(context).translate('phone_lbl')),
              subtitle: Text('$_phone', style: _subtitleStyle),
            ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          if (_email != 'null')
            ListTile(
              leading: Icon(Icons.email),
              title: Text(AppLocalizations.of(context).translate('email_lbl')),
              subtitle: Text(
                  _email.isNotEmpty
                      ? '$_email'
                      : AppLocalizations.of(context).translate('no_email'),
                  style: _subtitleStyle),
            ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          if (_state != 'null' && _country != 'null')
            ListTile(
              leading: Icon(Icons.location_on),
              title:
                  Text(AppLocalizations.of(context).translate('location_lbl')),
              subtitle: Text(
                  _state.isNotEmpty && _country.isNotEmpty
                      ? '${_state != "null" ? _state : ""}${_country != "null" ? ", $_country" : ""}'
                      : AppLocalizations.of(context).translate('no_location'),
                  style: _subtitleStyle),
            ),
          /* ButtonTheme(
            padding: EdgeInsets.all(0.0),
            shape: StadiumBorder(),
            child: RaisedButton(
              onPressed: () => Navigator.pushNamed(context, ENROLL),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.shade700, Colors.blue],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 15.0,
                ),
                child: Text(
                  AppLocalizations.of(context).translate('enroll_lbl'),
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(56),
                  ),
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
