import 'package:epandu/services/repository/vclub_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../app_localizations.dart';
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

  final image = ImagesConstant();

  Future _getMerchantList;

  @override
  void initState() {
    super.initState();

    _getMerchantList = _getMerchant();
  }

  _getMerchant() async {
    var result = await vClubRepo.getMerchant(
      context: context,
      keywordSearch: '',
      merchantType: widget.merchantType,
      startIndex: -1,
      noOfRecords: -1,
    );

    if (result.isSuccess) {
      return result.data;
    }
    return result.message;
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
        body: Container(
          height: ScreenUtil.screenHeightDp,
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
              FutureBuilder(
                  future: _getMerchantList,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Expanded(
                          child: SpinKitFoldingCube(
                            color: Colors.blue,
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.data is String)
                          return Expanded(
                              child: Center(child: Text(snapshot.data)));
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MerchantCard(
                                name: snapshot.data[index].name ?? '',
                                desc: snapshot.data[index].merchantDesc ?? '',
                                imageLink:
                                    snapshot.data[index].merchantIconFilename ??
                                        '',
                              );
                            },
                          ),
                        );
                      default:
                        return Expanded(
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('get_merchant_list_fail'),
                            ),
                          ),
                        );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
