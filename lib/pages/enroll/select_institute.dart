import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/common_library/services/model/auth_model.dart';
// import 'package:epandu/common_library/services/model/auth_model.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/repository/auth_repository.dart';
import 'package:epandu/utils/app_config.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

@RoutePage(name: 'SelectInstitute')
class SelectInstitute extends StatefulWidget {
  final data;

  const SelectInstitute(this.data, {super.key});

  @override
  State<SelectInstitute> createState() => _SelectInstituteState();
}

class _SelectInstituteState extends State<SelectInstitute> {
  final authRepo = AuthRepo();
  final appConfig = AppConfig();

  final primaryColor = ColorConstant.primaryColor;
  // Future _getInstitutes;

  final RegExp exp =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  Location location = Location();
  String? _message = '';
  bool _isLoading = true;
  int _startIndex = 0;
  List<dynamic> items = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // _getInstitutes = _getDiList();

    _getCurrentLocation();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _startIndex += 10;
        });

        if (_message!.isEmpty) _getDiNearMe();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  _getCurrentLocation() async {
    await location.getCurrentLocation();

    _getDiNearMe();
  }

  /* Future<dynamic> _getDiList() async {
    var result = await authRepo.getDiList(
      context: context,
    );

    if (result.isSuccess) {
      return result.data;
    }

    return result.message;
  } */

  Future<dynamic> _getDiNearMe() async {
    var result = await authRepo.getDiNearMe(
      merchantNo: appConfig.diCode,
      startIndex: _startIndex,
      noOfRecords: 10,
      latitude:
          location.latitude != null ? location.latitude.toString() : '999',
      longitude:
          location.longitude != null ? location.longitude.toString() : '999',
      maxRadius: 50,
    );

    if (result.isSuccess) {
      if (result.data.length > 0) {
        if (mounted) {
          setState(() {
            for (int i = 0; i < result.data.length; i += 1) {
              items.add(result.data[i]);
            }
          });
        } else if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _message = result.message;
          _isLoading = false;
        });
      }
    }
  }

  _loadImage(snapshot) {
    return FadeInImage(
      alignment: Alignment.center,
      placeholder: MemoryImage(kTransparentImage),
      width: 250.w,
      // height: ScreenUtil().setHeight(350),
      image: (snapshot.merchantIconFilename != null &&
              snapshot.merchantIconFilename.isNotEmpty
          ? NetworkImage(snapshot.merchantIconFilename
              .replaceAll(exp, '')
              .split('\r\n')[0])
          : MemoryImage(kTransparentImage)) as ImageProvider<Object>,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            primaryColor,
          ],
          stops: const [0.45, 0.95],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            // backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(AppLocalizations.of(context)!
                .translate('select_institute_lbl'))),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: _diNearMe(),
        ),
      ),
    );
  }

  _diNearMe() {
    if (items.isEmpty && _message!.isNotEmpty) {
      return Center(
        child: Text(_message!),
      );
    } else if (items.isNotEmpty) {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          for (var item in items)
            InkWell(
              onTap: () => context.router.push(
                SelectClass(
                  data: EnrollmentData(
                    icNo: widget.data.icNo,
                    name: widget.data.name,
                    email: widget.data.email,
                    // groupId: widget.data.groupId,
                    gender: widget.data.gender,
                    dateOfBirthString: widget.data.dateOfBirthString,
                    nationality: widget.data.nationality,
                    race: widget.data.race,
                    profilePic: widget.data.profilePic,
                    diCode: item.merchantNo,
                  ),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  50.w,
                  30.h,
                  50.w,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _loadImage(item),
                    SizedBox(
                      width: 1000.w,
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item.name ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(item.add1 != null
                              ? item.add1.replaceAll('\r\n', ' ')
                              : ''),
                          Text(item.phoneOff1 ?? ''),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30)),
                            child: const Divider(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  width: ScreenUtil().setWidth(1350),
                  height: ScreenUtil().setHeight(400),
                  color: Colors.grey[300],
                ),
              ),
            ),
        ],
      );
    }
    return _loadingShimmer();
  }

  _loadingShimmer({int? length}) {
    return Container(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: length ?? 4,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.white,
                  child: Container(
                    width: ScreenUtil().setWidth(1350),
                    height: ScreenUtil().setHeight(400),
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
