// import 'package:epandu/pages/edompet/edompet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/pages/profile/profile_page.dart' as profilepage;
import 'package:epandu/pages/settings/settings.dart' as settingspage;
import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:epandu/common_library/services/repository/profile_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import '../../router.gr.dart';

@RoutePage(name: 'ProfileTab')
class ProfileTab extends StatefulWidget {
  final positionStream;

  const ProfileTab(this.positionStream, {super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ProfileTab> {
  final List<Tab> myTabs = <Tab>[
    const Tab(
      icon: Icon(
        Icons.account_circle,
        size: 28.0,
      ),
    ),
    /* Tab(
      icon: new Icon(
        Icons.account_balance_wallet,
        size: 28.0,
      ),
    ), */
    const Tab(
      icon: Icon(
        Icons.settings,
        size: 28.0,
      ),
    ),
  ];
  TabController? _tabController;
  int _tabIndex = 0;
  final profileRepo = ProfileRepo();
  final epanduRepo = EpanduRepo();
  final localStorage = LocalStorage();
  final primaryColor = ColorConstant.primaryColor;
  final customDialog = CustomDialog();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  var paymentResponse;
  var paymentData;

  var attendanceResponse;
  var attendanceData;

  String enrollmentMessage = '';
  String paymentMessage = '';
  String attendanceMessage = '';

  UserProfile? userProfile;
  var enrollData;
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController!.addListener(_getTabSelection);

    _getUserProfile();
    // _getUserInfo();
  }

  _getUserProfile() async {
    setState(() {
      isLoading = true;
    });

    var result = await profileRepo.getUserProfile(context: context);

    if (result.isSuccess) {
      setState(() {
        userProfile = UserProfile(
          name: result.data![0].name,
          nickName: result.data![0].nickName,
          eMail: result.data![0].eMail,
          postcode: result.data![0].postcode,
          phone: result.data![0].phone,
          countryName: result.data![0].countryName,
          stateName: result.data![0].stateName,
          icNo: result.data![0].icNo,
          birthDate: result.data![0].birthDate,
          race: result.data![0].race,
          nationality: result.data![0].nationality,
          picturePath: result.data![0].picturePath != null &&
                  result.data![0].picturePath!.isNotEmpty
              ? (result.data![0].picturePath ?? '')
                  .replaceAll(removeBracket, '')
                  .split('\r\n')[0]
              : '',
          cdlGroup: result.data![0].cdlGroup,
          enqLdlGroup: result.data![0].enqLdlGroup,
        );
      });

      localStorage.saveName(result.data![0].name ?? '');
      localStorage.saveNickName(result.data![0].nickName ?? '');
      localStorage.saveEmail(result.data![0].eMail ?? '');
      localStorage.saveUserPhone(result.data![0].phone ?? '');
      localStorage.saveCountry(result.data![0].countryName ?? '');
      localStorage.saveState(result.data![0].stateName ?? '');
      localStorage.saveStudentIc(result.data![0].icNo ?? '');
      localStorage.saveBirthDate(result.data![0].birthDate ?? '');
      localStorage.saveRace(result.data![0].race ?? '');
      localStorage.saveNationality(result.data![0].nationality ?? '');
      localStorage.saveGender(result.data![0].gender ?? '');
      localStorage.saveCdl(result.data![0].cdlGroup ?? '');
      localStorage.saveLdl(result.data![0].enqLdlGroup ?? '');

      if (result.data![0].picturePath != null) {
        localStorage.saveProfilePic((result.data![0].picturePath ?? '')
            .replaceAll(removeBracket, '')
            .split('\r\n')[0]);
      }
    } else {
      _getUserInfo();
      /* customDialog.show(
        context: context,
        content: result.message,
        type: DialogType.WARNING,
      ); */
    }

    // _getEnrollByCode();
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  _getUserInfo() async {
    String? getName = await localStorage.getName();
    String? getNickName = await localStorage.getNickName();
    String? getEmail = await localStorage.getEmail();
    String? getPostcode = await localStorage.getPostCode();
    String? getPhone = await localStorage.getUserPhone();
    String? getCountry = await localStorage.getCountry();
    String? getState = await localStorage.getState();
    String? getStudentIc = await localStorage.getStudentIc();

    String? getBirthDate = await localStorage.getBirthDate();
    String? getRace = await localStorage.getRace();
    String? getNationality = await localStorage.getNationality();
    String? getProfilePic = await localStorage.getProfilePic();
    String? getCdl = await localStorage.getCdl();
    String? getLdl = await localStorage.getLdl();

    if (!mounted) return;
    setState(() {
      userProfile = UserProfile(
        name: getName,
        nickName: getNickName,
        eMail: getEmail,
        postcode: getPostcode,
        phone: getPhone,
        countryName: getCountry,
        stateName: getState,
        icNo: getStudentIc,
        birthDate: getBirthDate,
        race: getRace,
        nationality: getNationality,
        picturePath: getProfilePic != null && getProfilePic.isNotEmpty
            ? getProfilePic.replaceAll(removeBracket, '').split('\r\n')[0]
            : '',
        cdlGroup: getCdl,
        enqLdlGroup: getLdl,
      );
    });
  }

  // _getEnrollByCode() async {
  //   var result = await epanduRepo.getEnrollByCode();

  //   if (result.isSuccess) {
  //     enrollData = result.data;
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  _getTabSelection() {
    setState(() {
      _tabIndex = _tabController!.index;
    });
  }

  _getTitle() {
    switch (_tabIndex) {
      case 0:
        return Text(AppLocalizations.of(context)!.translate('profile_title'));
      // case 1:
      //   return Text(AppLocalizations.of(context).translate('edompet_title'));
      case 1:
        return Text(AppLocalizations.of(context)!.translate('settings_lbl'));
    }
  }

  _getActions() {
    switch (_tabIndex) {
      case 0:
        return <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                return editProfileBtn('mobile');
              }
              return editProfileBtn('tablet');
            },
          ),
        ];
    }
  }

  editProfileBtn(device) {
    return Container(
      padding: device == 'mobile'
          ? EdgeInsets.symmetric(vertical: 70.h)
          : EdgeInsets.symmetric(vertical: 40.h),
      margin: EdgeInsets.only(right: 15.w),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
          shape: const StadiumBorder(),
        ),
        onPressed: () async {
          await context.router
              .push(const UpdateProfile())
              .then((value) => _getUserInfo());
        },
        child: Text(AppLocalizations.of(context)!.translate('edit_profile')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.amber.shade300, primaryColor],
            stops: const [0.5, 1],
            radius: 0.9,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: _getTitle(),
            actions: _getActions(),
          ),
          backgroundColor: Colors.transparent,
          body: TabBarView(controller: _tabController, children: [
            profilepage.Profile(
              userProfile: userProfile,
              enrollData: enrollData,
              isLoading: isLoading,
            ),
            // Edompet(),
            settingspage.Settings(widget.positionStream),
          ]),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 10.0),
                  blurRadius: 15.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade700,
              tabs: myTabs,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}
