import 'package:epandu/app_localizations.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class SelectInstitute extends StatefulWidget {
  @override
  _SelectInstituteState createState() => _SelectInstituteState();
}

class _SelectInstituteState extends State<SelectInstitute> {
  final authRepo = AuthRepo();

  final primaryColor = ColorConstant.primaryColor;
  Future _getInstitutes;

  final RegExp exp =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  void initState() {
    super.initState();

    _getInstitutes = _getDiList();
  }

  Future<dynamic> _getDiList() async {
    var result = await authRepo.getDiList(
      context: context,
    );

    if (result.isSuccess) {
      return result.data;
    }

    return result.message;
  }

  _loadImage(snapshot) {
    return FadeInImage(
      alignment: Alignment.center,
      placeholder: MemoryImage(kTransparentImage),
      width: 250.w,
      // height: ScreenUtil().setHeight(350),
      image: snapshot.appBackgroundPhotoPath.isNotEmpty
          ? NetworkImage(snapshot.appBackgroundPhotoPath
              .replaceAll(exp, '')
              .split('\r\n')[0])
          : MemoryImage(kTransparentImage),
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
          stops: [0.45, 0.95],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(AppLocalizations.of(context)
                .translate('select_institute_lbl'))),
        body: FutureBuilder(
          future: _getInstitutes,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: SpinKitFoldingCube(
                    color: primaryColor,
                  ),
                );
              case ConnectionState.done:
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, SELECT_CLASS,
                          arguments: snapshot.data[index].diCode),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setWidth(50),
                            ScreenUtil().setWidth(30),
                            ScreenUtil().setWidth(50),
                            0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _loadImage(snapshot.data[index]),
                            Container(
                              width: 1000.w,
                              // decoration: BoxDecoration(
                              //   border: Border.all(),
                              // ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snapshot.data[index].name ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(snapshot.data[index].add != null
                                      ? snapshot.data[index].add
                                          .replaceAll('\r\n', ' ')
                                      : ''),
                                  Text(snapshot.data[index].phone ?? ''),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(30)),
                                    child: Divider(
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
                    );
                  },
                );
              default:
                return Center(
                  child: Text(
                    AppLocalizations.of(context).translate('get_di_list_fail'),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
