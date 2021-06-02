import 'package:epandu/common_library/services/repository/epandu_repository.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QueueNumber extends StatefulWidget {
  final data;

  QueueNumber({@required this.data});

  @override
  _QueueNumberState createState() => _QueueNumberState();
}

class _QueueNumberState extends State<QueueNumber> {
  final epanduRepo = EpanduRepo();
  final primaryColor = ColorConstant.primaryColor;
  final image = ImagesConstant();
  final customDialog = CustomDialog();
  Future getCurrentQueue;
  bool isLoading = false;
  var checkInData;

  @override
  void initState() {
    super.initState();

    getCurrentQueue = getLastCallingJpjTestQueueNumber();
    _getJpjTestCheckIn();
  }

  getLastCallingJpjTestQueueNumber() async {
    var result =
        await epanduRepo.getLastCallingJpjTestQueueNumber(context: context);

    if (result.isSuccess) {
      return result.data;
    } else {
      return result.message;
    }
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
        content: result.message,
        type: DialogType.WARNING,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.data != null &&
                    widget.data[0].regDate.substring(0, 10) != null)
                  Text(
                    widget.data[0].regDate.substring(0, 10),
                    style: TextStyle(
                      fontSize: 60.sp,
                    ),
                  ),
                if (widget.data != null &&
                    widget.data[0].regDate.substring(11, 20) != null)
                  Text(
                    widget.data[0].regDate.substring(11, 20),
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
          if (widget.data != null && widget.data[0].groupId != null)
            Text(
              widget.data[0].groupId,
              style: TextStyle(
                fontSize: 150.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (widget.data != null && widget.data[0].queueNo != null)
            Text(
              widget.data[0].queueNo,
              style: TextStyle(
                fontSize: 150.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          FutureBuilder(
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
          ),
          SizedBox(height: 40.h),
          if (widget.data != null && widget.data[0].fullname != null)
            Text(
              widget.data[0].fullname,
              style: TextStyle(
                fontSize: 70.sp,
              ),
            ),
          SizedBox(height: 20.h),
          if (widget.data != null && widget.data[0].nricNo != null)
            Text(
              widget.data[0].nricNo,
              style: TextStyle(
                fontSize: 65.sp,
              ),
            ),
          SizedBox(height: 20.h),
          !isLoading
              ? QrImage(
                  embeddedImage: AssetImage(image.ePanduIcon),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(40, 40),
                  ),
                  data:
                      '{"Table1":[{"group_id": "${checkInData[0].groupId}", "test_code": "${checkInData[0].testCode}", "nric_no": "${checkInData[0].nricNo}"}]}',
                  version: QrVersions.auto,
                  size: 250.0,
                )
              : SpinKitFoldingCube(
                  color: ColorConstant.primaryColor,
                ),
        ],
      ),
    );
  }
}
