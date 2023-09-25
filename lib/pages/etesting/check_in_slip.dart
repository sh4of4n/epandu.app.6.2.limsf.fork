import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/common_library/utils/loading_model.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage(name: 'CheckInSlip')
class CheckInSlip extends StatefulWidget {
  const CheckInSlip({super.key});

  @override
  _CheckInSlipState createState() => _CheckInSlipState();
}

class _CheckInSlipState extends State<CheckInSlip> {
  final epanduRepo = EpanduRepo();
  final primaryColor = ColorConstant.primaryColor;
  final image = ImagesConstant();
  final customDialog = CustomDialog();
  bool isLoading = false;
  var checkInData;

  @override
  void initState() {
    super.initState();

    _getJpjTestCheckIn();
  }

  Future<void> _getJpjTestCheckIn() async {
    setState(() {
      isLoading = true;
    });

    var result = await epanduRepo.getJpjTestCheckIn();

    if (result.isSuccess) {
      checkInData = result.data;
    } else {
      customDialog.show(
        context: context,
        barrierDismissable: false,
        content: result.message!,
        onPressed: () {
          context.router.pop();
          context.router.pop();
        },
        type: DialogType.WARNING,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  renderQr() {
    if (!isLoading && checkInData != null) {
      return QrImageView(
        embeddedImage: AssetImage(image.ePanduIcon),
        embeddedImageStyle: const QrEmbeddedImageStyle(
          size: Size(40, 40),
        ),
        data:
            '{"Table1":[{"group_id": "${checkInData[0].groupId}", "test_code": "${checkInData[0].testCode}", "nric_no": "${checkInData[0].nricNo}"}]}',
        version: QrVersions.auto,
        size: 250.0,
      );
    } else if (checkInData == null) {
      return Container();
    }
    const SpinKitFoldingCube(
      color: ColorConstant.primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: FadeInImage(
          alignment: Alignment.center,
          height: 110.h,
          placeholder: MemoryImage(kTransparentImage),
          image: AssetImage(
            image.logo3,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (checkInData != null &&
                        checkInData[0].regDate.substring(0, 10) != null)
                      Text(
                        checkInData[0].regDate.substring(0, 10),
                        style: TextStyle(
                          fontSize: 60.sp,
                        ),
                      ),
                    if (checkInData != null &&
                        checkInData[0].regDate.substring(11, 19) != null)
                      Text(
                        checkInData[0].regDate.substring(11, 19),
                        style: TextStyle(
                          fontSize: 60.sp,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Nombor Giliran Anda',
                style: TextStyle(
                  fontSize: 70.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Kelas',
                style: TextStyle(
                  fontSize: 70.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.h),
              if (checkInData != null && checkInData[0].groupId != null)
                Text(
                  checkInData[0].groupId,
                  style: TextStyle(
                    fontSize: 150.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (checkInData != null && checkInData[0].queueNo != null)
                Text(
                  checkInData[0].queueNo,
                  style: TextStyle(
                    fontSize: 150.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              /* FutureBuilder(
              future: getCurrentQueue,
              builder: (BuildContext conext, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                      padding: EdgeInsets.all(15.0),
                      margin:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 8.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: SpinKitFoldingCube(
                          color: primaryColor,
                        ),
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.data is String) {
                      return Center(
                        child: Text(snapshot.data),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(height: 40.h),
                            Text(
                              'Nombor Giliran Sekarang',
                              style: TextStyle(
                                fontSize: 70.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data[index].queueNo,
                              style: TextStyle(
                                fontSize: 120.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  default:
                    return Center(
                      child: Text('Gagal mendapatkan nombor giliran sekarang.'),
                    );
                }
              },
            ), */
              SizedBox(height: 40.h),
              if (checkInData != null && checkInData[0].fullname != null)
                Text(
                  checkInData[0].fullname,
                  style: TextStyle(
                    fontSize: 70.sp,
                  ),
                ),
              SizedBox(height: 20.h),
              if (checkInData != null && checkInData[0].nricNo != null)
                Text(
                  checkInData[0].nricNo,
                  style: TextStyle(
                    fontSize: 65.sp,
                  ),
                ),
              SizedBox(height: 20.h),
              renderQr(),
            ],
          ),
          LoadingModel(
            isVisible: isLoading,
          ),
        ],
      ),
    );
  }
}
