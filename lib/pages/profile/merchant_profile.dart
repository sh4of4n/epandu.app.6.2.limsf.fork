import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epandu/common_library/services/model/vclub_model.dart';
import 'package:epandu/common_library/services/repository/vclub_repository.dart';
import 'package:epandu/common_library/services/response.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

@RoutePage(name: 'MerchantProfile')
class MerchantProfile extends StatefulWidget {
  const MerchantProfile({super.key});

  @override
  State<MerchantProfile> createState() => _MerchantProfileState();
}

class _MerchantProfileState extends State<MerchantProfile> {
  final vClubRepo = VclubRepo();
  final localStorage = LocalStorage();
  final myImage = ImagesConstant();
  final primaryColor = ColorConstant.primaryColor;
  Future? getMerchant;

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  final TextStyle _subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade700,
  );

  @override
  void initState() {
    super.initState();

    getMerchant = getMerchantApi();
  }

  Future getMerchantApi() async {
    String? dbCode = await localStorage.getMerchantDbCode();
    if (!context.mounted) return;
    Response<List<Merchant>?> result = await vClubRepo.getMerchantByCode(
      merchantNo: dbCode ?? '',
    );

    if (result.isSuccess) {
      return result.data;
    }
    return result.message;
  }

  _profileImage(data) {
    if (data.merchantIconFilename != null &&
        data.merchantIconFilename.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: CachedNetworkImage(
          imageUrl: data.merchantIconFilename
              .replaceAll(removeBracket, '')
              .split('\r\n')[0],
          fit: BoxFit.contain,
        ),
      );
    }
    return Icon(
      Icons.account_circle,
      color: Colors.grey[850],
      size: 70,
    );
  }

  _merchantInfo(data) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTile(
            title: const Text('Name'),
            subtitle: Text(data.name ?? '-', style: _subtitleStyle)),
        ListTile(
            title: const Text('Description'),
            subtitle: Text(data.merchantDesc ?? '-')),
        ListTile(
            title: const Text('City'),
            subtitle: Text(data.cityName ?? '-', style: _subtitleStyle)),
        ListTile(
            title: const Text('Business Hours'),
            subtitle: Text(data.businessHour ?? '-', style: _subtitleStyle)),
        ListTile(
            title: const Text('Business Day'),
            subtitle: Text(data.businessDay ?? '-', style: _subtitleStyle)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.amber.shade300, primaryColor],
          stops: const [0.5, 1],
          radius: 0.9,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Merchant Profile'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getMerchant,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(
                    height: ScreenUtil().screenHeight,
                    child: const Center(
                      child: SpinKitFoldingCube(
                        color: Colors.blue,
                      ),
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.data is String) {
                    return Center(
                      child: Text(snapshot.data),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            _profileImage(snapshot.data[0]),
                            _merchantInfo(snapshot.data[0]),
                          ],
                        ),
                      ),
                    ),
                  );
                default:
                  return const Center(
                    child: Text(
                        'Failed to get merchant profile. Please try again.'),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
