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

  final primaryColor = ColorConstant.primaryColor;

  /* @override
  void initState() {
    super.initState();

    _getUserInfo();
  } */

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getUserInfo();
  }

  _getUserInfo() async {
    String _getName = await localStorage.getUsername();
    String _getEmail = await localStorage.getEmail();
    String _getPhone =
        await localStorage.getCountryCode() + await localStorage.getUserPhone();
    // String _getNationality = await localStorage.getNationality();
    // String _getGender = await localStorage.getGender();
    String _getStudentIc = await localStorage.getStudentIc();
    // String _getAddress = await localStorage.getAddress();
    String _getCountry = await localStorage.getCountry();
    String _getState = await localStorage.getState();
    String _getBirthDate = await localStorage.getBirthDate();
    String _getRace = await localStorage.getRace();
    String _getNationality = await localStorage.getNationality();
    String _getNickName = await localStorage.getNickName();
    // String _getPostCode = await localStorage.getPostCode();

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
            /* Container(
                    height: ScreenUtil().setHeight(300),
                    width: ScreenUtil.screenWidth,
                    color: Colors.blue), */
            /*Container(
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
            ),*/
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
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage(image.feedSample),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: ScreenUtil().setWidth(280),
                        height: ScreenUtil().setWidth(280),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(30)),
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
                title: Text("Name on IC/Passport"
                    //AppLocalizations.of(context).translate('login_id')
                    ),
                subtitle: Text('$_name', style: _subtitleStyle),
              ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Nick Name"
                  //AppLocalizations.of(context).translate('login_id')
                  ),
              subtitle: Text('$_nickName', style: _subtitleStyle),
            ),
            if (_studentIC != 'null')
              ListTile(
                leading: Icon(Icons.perm_identity),
                title: Text(
                  "IC/Passport",
                  //AppLocalizations.of(context).translate('ic_required_lbl')
                ),
                subtitle: Text('$_studentIC', style: _subtitleStyle),
              ),
            if (_phone != 'null')
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(AppLocalizations.of(context).translate('login_id')),
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
                title: Text("Date of Birth"
                    //AppLocalizations.of(context).translate('dob_required_lbl')
                    ),
                subtitle: Text('$_birthDate', style: _subtitleStyle),
              ),
            if (_nationality != 'null')
              ListTile(
                leading: Icon(Icons.flag),
                title: Text(
                    AppLocalizations.of(context).translate('nationality_lbl')),
                subtitle: Text('$_nationality', style: _subtitleStyle),
              ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            /* if (_state != 'null' && _country != 'null')
              ListTile(
                leading: Icon(Icons.location_on),
                title:
                    Text(AppLocalizations.of(context).translate('location_lbl')),
                subtitle: Text(
                    _state.isNotEmpty && _country.isNotEmpty
                        ? '${_state != "null" ? _state : ""}${_country != "null" ? ", $_country" : ""}'
                        : AppLocalizations.of(context).translate('no_location'),
                    style: _subtitleStyle),
              ), */
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
                      fontSize: ScreenUtil().setSp(56),
                    ),
                  ),
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
