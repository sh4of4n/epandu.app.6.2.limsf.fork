import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:epandu/widgets/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  final userProfile;
  final isLoading;

  Profile({this.userProfile, this.isLoading});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with AutomaticKeepAliveClientMixin<Profile> {
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final profileRepo = ProfileRepo();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

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
  bool get wantKeepAlive => true;

  _profileImage() {
    if (widget.userProfile?.picturePath != null &&
        widget.userProfile.picturePath.isNotEmpty) {
      return Image.network(
        widget.userProfile.picturePath,
        width: 600.w,
        height: 600.w,
        fit: BoxFit.cover,
      );
    }
    return Icon(
      Icons.account_circle,
      color: Colors.grey[850],
      size: 70,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: <Widget>[
        SingleChildScrollView(
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
                        _profileImage(),
                        _userInfo(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        LoadingModel(
          isVisible: widget.isLoading,
          // opacity: 0.8,
          color: primaryColor,
        ),
      ],
    );
  }

  _userInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(120.0)),
      child: Container(
        child: Column(
          children: <Widget>[
            if (widget.userProfile?.name != null)
              Text('${widget.userProfile?.name}', style: _titleStyle),
            if (widget.userProfile?.name != null)
              ListTile(
                leading: Icon(Icons.account_box),
                title:
                    Text(AppLocalizations.of(context).translate('ic_name_lbl')),
                subtitle:
                    Text('${widget.userProfile?.name}', style: _subtitleStyle),
              ),
            if (widget.userProfile?.nickName != null)
              ListTile(
                leading: Icon(Icons.account_box),
                title: Text(
                    AppLocalizations.of(context).translate('nick_name_lbl')),
                subtitle: Text('${widget.userProfile?.nickName}',
                    style: _subtitleStyle),
              ),
            if (widget.userProfile?.icNo != null)
              ListTile(
                leading: Icon(Icons.perm_identity),
                title: Text(AppLocalizations.of(context).translate('ic_lbl')),
                subtitle:
                    Text('${widget.userProfile?.icNo}', style: _subtitleStyle),
              ),
            if (widget.userProfile?.phone != null)
              ListTile(
                leading: Icon(Icons.phone),
                title:
                    Text(AppLocalizations.of(context).translate('contact_no')),
                subtitle:
                    Text('${widget.userProfile?.phone}', style: _subtitleStyle),
              ),
            if (widget.userProfile?.eMail != null)
              ListTile(
                leading: Icon(Icons.email),
                title:
                    Text(AppLocalizations.of(context).translate('email_lbl')),
                subtitle: Text(
                    widget.userProfile?.eMail != null
                        ? '${widget.userProfile?.eMail}'
                        : AppLocalizations.of(context).translate('no_email'),
                    style: _subtitleStyle),
              ),
            if (widget.userProfile?.birthDate != null)
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(AppLocalizations.of(context).translate('dob_lbl')),
                subtitle: Text(
                    '${widget.userProfile.birthDate.isNotEmpty ? widget.userProfile.birthDate.substring(0, 10) : ''}',
                    style: _subtitleStyle),
              ),
            /* if (_nationality != null)
              ListTile(
                leading: Icon(Icons.flag),
                title: Text(
                    AppLocalizations.of(context).translate('nationality_lbl')),
                subtitle: Text('$_nationality', style: _subtitleStyle),
              ), */
            SizedBox(height: ScreenUtil().setHeight(20)),
            /* if (_state != null && _country != null)
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
                onPressed: () => Navigator.push(context, ENROLL),
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
