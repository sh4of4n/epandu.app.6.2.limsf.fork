import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repo/bill_repo.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

class BillSelection extends StatelessWidget {
  final primaryColor = ColorConstant.primaryColor;
  final billRepo = BillRepo();

  final Box<dynamic> serviceList = Hive.box('serviceList');

  Future<dynamic> _getService(context) async {
    if (serviceList.get('serviceList') == null) {
      var result = await billRepo.getService(context: context);

      return result.data;
    }
    return serviceList.get('serviceList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('bill_lbl')),
        elevation: 0,
        backgroundColor: primaryColor,
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
          FutureBuilder(
            future: _getService(context),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: MediaQuery.of(context).size.height / 530,
                  ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, BILL_DETAIL,
                          arguments: snapshot.data[index]),
                      child: GridTile(
                        child:
                            Image.network(snapshot.data[index].telcoImageUri),
                      ),
                    );
                  },
                );
              }
              return SpinKitFoldingCube(
                color: primaryColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
