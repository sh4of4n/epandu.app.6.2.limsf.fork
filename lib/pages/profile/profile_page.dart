import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../router.gr.dart';

@RoutePage(name: 'Profile')
class Profile extends StatefulWidget {
  final userProfile;
  final enrollData;
  final isLoading;

  const Profile({super.key, this.userProfile, this.enrollData, this.isLoading});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with AutomaticKeepAliveClientMixin<Profile> {
  final image = ImagesConstant();
  final localStorage = LocalStorage();
  final profileRepo = ProfileRepo();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  final TextStyle _titleStyle = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  final TextStyle _tabTitleStyle = TextStyle(
    fontSize: 60.sp,
    fontWeight: FontWeight.w800,
  );

  final TextStyle _tabSubtitleStyle = TextStyle(
    fontSize: 45.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  final iconText = TextStyle(
    fontSize: ScreenUtil().setSp(60),
    color: Colors.black,
  );

  final primaryColor = ColorConstant.primaryColor;

  @override
  bool get wantKeepAlive => true;

  _profileImage() {
    if (widget.userProfile?.picturePath != null &&
        widget.userProfile.picturePath.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: widget.userProfile.picturePath,
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

  defaultLayout() {
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
                  child: SizedBox(
                    width: ScreenUtil().screenWidth,
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
      child: Column(
        children: <Widget>[
          if (widget.userProfile?.name != null)
            ListTile(
              leading: const Icon(Icons.account_box),
              title:
                  Text(AppLocalizations.of(context)!.translate('ic_name_lbl')),
              subtitle:
                  Text('${widget.userProfile?.name}', style: _subtitleStyle),
            ),
          if (widget.userProfile?.nickName != null)
            ListTile(
              leading: const Icon(Icons.account_box),
              title: Text(
                  AppLocalizations.of(context)!.translate('nick_name_lbl')),
              subtitle: Text('${widget.userProfile?.nickName}',
                  style: _subtitleStyle),
            ),
          if (widget.userProfile?.icNo != null)
            ListTile(
              leading: const Icon(Icons.perm_identity),
              title: Text(AppLocalizations.of(context)!.translate('ic_lbl')),
              subtitle:
                  Text('${widget.userProfile?.icNo}', style: _subtitleStyle),
            ),
          if (widget.userProfile?.phone != null)
            ListTile(
              leading: const Icon(Icons.phone),
              title:
                  Text(AppLocalizations.of(context)!.translate('contact_no')),
              subtitle:
                  Text('${widget.userProfile?.phone}', style: _subtitleStyle),
            ),
          if (widget.userProfile?.eMail != null)
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(AppLocalizations.of(context)!.translate('email_lbl')),
              subtitle: Text(
                  widget.userProfile?.eMail != null
                      ? '${widget.userProfile?.eMail}'
                      : AppLocalizations.of(context)!.translate('no_email'),
                  style: _subtitleStyle),
            ),
          if (widget.userProfile?.postcode != null)
            ListTile(
              leading: const Icon(Icons.home),
              title:
                  Text(AppLocalizations.of(context)!.translate('postcode_lbl')),
              subtitle: Text(
                  widget.userProfile?.postcode != null
                      ? '${widget.userProfile?.postcode}'
                      : AppLocalizations.of(context)!.translate('no_postcode'),
                  style: _subtitleStyle),
            ),
          if (widget.userProfile?.birthDate != null)
            ListTile(
              leading: const Icon(Icons.date_range),
              title: Text(AppLocalizations.of(context)!.translate('dob_lbl')),
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
          InkWell(
            onTap: () => context.router.push(const EnrolmentInfo()),
            child: Column(
              children: <Widget>[
                FadeInImage(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(350),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    image.classIcon,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Text(
                  AppLocalizations.of(context)!.translate('enrolled_class'),
                  style: iconText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
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
    );
  }

  tabLayout() {
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                margin: EdgeInsets.symmetric(horizontal: 150.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: SizedBox(
                    width: ScreenUtil().screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: ScreenUtil().setHeight(40)),
                        _profileImage(),
                        _tabUserInfo(),
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

  _tabUserInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 220.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.userProfile?.name != null)
            Text('${widget.userProfile?.name}', style: _tabTitleStyle),
          if (widget.userProfile?.name != null)
            ListTile(
              leading: const Icon(Icons.account_box),
              title:
                  Text(AppLocalizations.of(context)!.translate('ic_name_lbl')),
              subtitle:
                  Text('${widget.userProfile?.name}', style: _tabSubtitleStyle),
            ),
          if (widget.userProfile?.nickName != null)
            ListTile(
              leading: const Icon(Icons.account_box),
              title: Text(
                  AppLocalizations.of(context)!.translate('nick_name_lbl')),
              subtitle: Text('${widget.userProfile?.nickName}',
                  style: _tabSubtitleStyle),
            ),
          if (widget.userProfile?.icNo != null)
            ListTile(
              leading: const Icon(Icons.perm_identity),
              title: Text(AppLocalizations.of(context)!.translate('ic_lbl')),
              subtitle:
                  Text('${widget.userProfile?.icNo}', style: _tabSubtitleStyle),
            ),
          if (widget.userProfile?.phone != null)
            ListTile(
              leading: const Icon(Icons.phone),
              title:
                  Text(AppLocalizations.of(context)!.translate('contact_no')),
              subtitle: Text('${widget.userProfile?.phone}',
                  style: _tabSubtitleStyle),
            ),
          if (widget.userProfile?.eMail != null)
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(AppLocalizations.of(context)!.translate('email_lbl')),
              subtitle: Text(
                  widget.userProfile?.eMail != null
                      ? '${widget.userProfile?.eMail}'
                      : AppLocalizations.of(context)!.translate('no_email'),
                  style: _tabSubtitleStyle),
            ),
          if (widget.userProfile?.postcode != null)
            ListTile(
              leading: const Icon(Icons.home),
              title:
                  Text(AppLocalizations.of(context)!.translate('postcode_lbl')),
              subtitle: Text(
                  widget.userProfile?.postcode != null
                      ? '${widget.userProfile?.postcode}'
                      : AppLocalizations.of(context)!.translate('no_postcode'),
                  style: _tabSubtitleStyle),
            ),
          if (widget.userProfile?.birthDate != null)
            ListTile(
              leading: const Icon(Icons.date_range),
              title: Text(AppLocalizations.of(context)!.translate('dob_lbl')),
              subtitle: Text(
                  '${widget.userProfile.birthDate.isNotEmpty ? widget.userProfile.birthDate.substring(0, 10) : ''}',
                  style: _tabSubtitleStyle),
            ),
          /* if (_nationality != null)
            ListTile(
              leading: Icon(Icons.flag),
              title: Text(
                  AppLocalizations.of(context).translate('nationality_lbl')),
              subtitle: Text('$_nationality', style: _subtitleStyle),
            ), */
          SizedBox(height: ScreenUtil().setHeight(20)),
          InkWell(
            onTap: () => context.router.push(const EnrolmentInfo()),
            child: Column(
              children: <Widget>[
                FadeInImage(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(350),
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    image.classIcon,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Text(
                  AppLocalizations.of(context)!.translate('enrolled_class'),
                  style: iconText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 600) {
        return defaultLayout();
      }
      return tabLayout();
    });
  }
}
