import 'package:epandu/common_library/services/location.dart';
import 'package:epandu/common_library/services/repository/vclub_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'merchant_card.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MerchantList extends StatefulWidget {
  final merchantType;

  MerchantList(this.merchantType);

  @override
  _MerchantListState createState() => _MerchantListState();
}

class _MerchantListState extends State<MerchantList> {
  final primaryColor = ColorConstant.primaryColor;
  final vClubRepo = VclubRepo();
  Location location = Location();

  final image = ImagesConstant();

  String _message = '';
  bool _isLoading = true;
  int _startIndex = 0;
  List<dynamic> items = [];

  ScrollController _scrollController = new ScrollController();

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();

    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 10;
          });

          if (_message.isEmpty) _getMerchant();
        }
      });
  }

  _getCurrentLocation() async {
    await location.getCurrentLocation();

    _getMerchant();
  }

  _getMerchant() async {
    var result = await vClubRepo.getMerchant(
      context: context,
      keywordSearch: '',
      merchantType: widget.merchantType,
      startIndex: _startIndex,
      noOfRecords: 10,
      latitude:
          location.latitude != null ? location.latitude.toString() : '999',
      longitude:
          location.longitude != null ? location.longitude.toString() : '999',
      maxRadius: 30,
    );

    if (result.isSuccess) {
      if (result.data.length > 0) if (mounted)
        setState(() {
          for (int i = 0; i < result.data.length; i += 1) {
            items.add(result.data[i]);
          }
        });
      else if (mounted)
        setState(() {
          _isLoading = false;
        });
    } else {
      if (mounted)
        setState(() {
          _message = result.message;
          _isLoading = false;
        });
    }
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
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
          stops: [0.45, 0.65],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: FadeInImage(
                  alignment: Alignment.center,
                  placeholder: MemoryImage(kTransparentImage),
                  image: AssetImage(
                    image.selectInstituteBanner,
                  ),
                ),
              ),
              _merchantList(),
            ],
          ),
        ),
      ),
    );
  }

  _merchantList() {
    if (items.length == 0 && _message.isNotEmpty) {
      return Center(
        child: Text(_message),
      );
    } else if (items.length > 0) {
      return ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          for (var item in items)
            MerchantCard(
              name: item.name ?? '',
              desc: item.merchantDesc ?? '',
              imageLink: item.merchantIconFilename != null
                  ? item.merchantIconFilename
                      .replaceAll(removeBracket, '')
                      .split('\r\n')[0]
                  : '',
              cityName: item.cityName ?? '',
              distance: item.distance != null
                  ? double.tryParse(item.distance).toStringAsFixed(2)
                  : '',
              businessHours: item.businessHour ?? '',
              businessDay: item.businessDay ?? '',
            ),
          if (_isLoading)
            Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.white,
              child: Container(
                width: ScreenUtil().setWidth(1400),
                height: ScreenUtil().setHeight(600),
                color: Colors.grey[300],
              ),
            ),
        ],
      );
    }
    return _loadingShimmer();
  }

  _loadingShimmer({int length}) {
    return Container(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: length ?? 4,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    width: ScreenUtil().setWidth(1400),
                    height: ScreenUtil().setHeight(600),
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
