import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:epandu/common_library/utils/custom_snackbar.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
// import 'package:epandu/common_library/utils/map_launcher.dart';

class DirectoryDetail extends StatefulWidget {
  final snapshot;

  DirectoryDetail(this.snapshot);

  @override
  _DirectoryDetailState createState() => _DirectoryDetailState();
}

class _DirectoryDetailState extends State<DirectoryDetail> {
  final customSnackbar = CustomSnackbar();
  final primaryColor = ColorConstant.primaryColor;
  final localStorage = LocalStorage();
  final location = Location();
  String address;
  TextStyle _titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  TextStyle _textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();

    _getAddress();
  }

  _getAddress() async {
    double lat = double.tryParse(await localStorage.getUserLatitude());
    double long = double.tryParse(await localStorage.getUserLongitude());

    await location.getAddress(lat, long);

    if (mounted) {
      setState(() {
        address = location.address;
      });
    }
  }

  _phone() async {
    if (widget.snapshot.phone == null) {
      customSnackbar.show(
        context,
        message: AppLocalizations.of(context).translate('no_contacts'),
        duration: 5000,
        type: MessageType.INFO,
      );
    } else {
      String trimNumber =
          widget.snapshot.phone.replaceAll('-', '').replaceAll(' ', '');

      await launch('tel:$trimNumber');
    }
  }

  _openDestination(context) async {
    try {
      final title = widget.snapshot.sosContactName;
      final description = "";
      final coords = Coords(double.tryParse(widget.snapshot.latitude),
          double.tryParse(widget.snapshot.longtitude));
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                            coords: coords,
                            title: title,
                            description: description,
                          );
                        },
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  /* _showMyLocation() async {
    double lat = double.tryParse(await localStorage.getUserLatitude());
    double long = double.tryParse(await localStorage.getUserLongitude());

    try {
      final title = widget.snapshot.sosContactName;
      final description = "";
      final coords = Coords(lat, long);
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  } */

  _remark() {
    if (widget.snapshot.remark != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).translate('remark_lbl'),
              style: _titleStyle),
          Text(widget.snapshot.remark, style: _textStyle),
        ],
      );
    }
    return Container(height: 0, width: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate('information_title')),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              height: ScreenUtil().setHeight(1000),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 8.0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('subtype_lbl'),
                      style: _titleStyle),
                  Text(widget.snapshot.sosContactSubtype ?? '',
                      style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(AppLocalizations.of(context).translate('area_code_lbl'),
                      style: _titleStyle),
                  Text(widget.snapshot.areaCode ?? '', style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .translate('contact_name_lbl'),
                      style: _titleStyle),
                  Text(widget.snapshot.sosContactName ?? '', style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(AppLocalizations.of(context).translate('address_lbl'),
                      style: _titleStyle),
                  Text(widget.snapshot.add ?? '', style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                      AppLocalizations.of(context)
                          .translate('current_location'),
                      style: _titleStyle),
                  Text(address ?? '', style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(AppLocalizations.of(context).translate('phone_lbl'),
                      style: _titleStyle),
                  Text(widget.snapshot.phone ?? '', style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(AppLocalizations.of(context).translate('distance_lbl'),
                      style: _titleStyle),
                  Text(
                      double.tryParse(widget.snapshot.distance)
                                  .toStringAsFixed(2) +
                              'km' ??
                          '',
                      style: _textStyle),
                  SizedBox(
                    height: 5.0,
                  ),
                  // Text(AppLocalizations.of(context).translate('to_lbl'),
                  //     style: _titleStyle),
                  // Text(
                  //     '${widget.snapshot.latitude}, ${widget.snapshot.longtitude}' ??
                  //         '',
                  //     style: _textStyle),
                  // SizedBox(
                  //   height: 5.0,
                  // ),
                  _remark(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RawMaterialButton(
                          fillColor: Colors.green,
                          shape: CircleBorder(),
                          onPressed: _phone,
                          child: Icon(Icons.phone, color: Colors.white),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        RawMaterialButton(
                          fillColor: Colors.blue,
                          shape: CircleBorder(),
                          onPressed: () => _openDestination(context),
                          child: Icon(Icons.navigation, color: Colors.white),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        /* RawMaterialButton(
                          fillColor: Colors.red,
                          shape: CircleBorder(),
                          onPressed: _showMyLocation,
                          child: Icon(Icons.location_on, color: Colors.white),
                          padding: const EdgeInsets.all(10.0),
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
