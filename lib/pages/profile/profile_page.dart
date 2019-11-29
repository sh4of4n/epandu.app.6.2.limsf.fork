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
  String _nationality = '';
  String _gender = '';
  String _studentIc = '';
  String _address = '';
  String _country = '';
  String _state = '';
  String _postCode = '';

  TextStyle _titleStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
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
    String _getNationality = await localStorage.getNationality();
    String _getGender = await localStorage.getGender();
    String _getStudentIc = await localStorage.getStudentIc();
    String _getAddress = await localStorage.getAddress();
    String _getCountry = await localStorage.getCountry();
    String _getState = await localStorage.getState();
    String _getPostCode = await localStorage.getPostCode();

    setState(() {
      _name = _getName;
      _email = _getEmail;
      _phone = _getPhone;
      _nationality = _getNationality;
      _gender = _getGender;
      _studentIc = _getStudentIc;
      _address = _getAddress;
      _country = _getCountry;
      _state = _getState;
      _postCode = _getPostCode;
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
        Positioned(
          bottom: 0.0,
          child: Container(
            height: ScreenUtil.getInstance().setHeight(2000),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30.0),
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
                width: ScreenUtil.getInstance().setWidth(450),
                height: ScreenUtil.getInstance().setWidth(450),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 170.0),
          width: ScreenUtil.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _name != 'null'
                  ? Text('$_name', style: _titleStyle)
                  : SizedBox.shrink(),
              SizedBox(height: 5.0),
              _nationality != 'null' && _gender != 'null'
                  ? Text(
                      '${_nationality != "null" ? _nationality : ""}${_gender != "null" ? ", $_gender" : ""}',
                      style: _subtitleStyle)
                  : SizedBox.shrink(),
              SizedBox(height: 5.0),
              _phone != 'null'
                  ? Text('$_phone', style: _subtitleStyle)
                  : SizedBox.shrink(),
              SizedBox(height: 5.0),
              _email != 'null'
                  ? Text('$_email', style: _subtitleStyle)
                  : SizedBox.shrink(),
              SizedBox(height: 5.0),
              // TODO: IcNo, Add, Country, state, postCode
            ],
          ),
        ),
      ],
    );
  }
}
