import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import 'package:epandu/common_library/services/model/chat_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageItem extends StatelessWidget {
  final Message? message;
  final int? previousItemDate;
  final ScrollController? scrollController;
  final LocalStorage localStorage = LocalStorage();
  final String? userId;

  MessageItem(
      {this.message,
      this.previousItemDate,
      this.userId,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(message!.sentDateTime!);
    var formattedDate = DateFormat.yMMMd().format(date);
    var formattedTime = DateFormat.jm().format(date);
    if (message!.author == userId) {
      return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: previousItemDate == 0
                ? Text(formattedDate,
                    textAlign: TextAlign.center,
                    style:
                        new TextStyle(fontSize: 60.0.sp, color: Colors.black54))
                : formattedDate ==
                        DateFormat.yMMMd().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                message!.sentDateTime!))
                    ? Container()
                    : Text(formattedDate,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 60.0.sp, color: Colors.black54)),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding:
                            EdgeInsets.fromLTRB(30.0.w, 30.0.h, 30.0.w, 30.0.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black26)),
                        child: Text(message!.data!,
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontSize: 70.0.sp, color: Colors.black))),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(formattedTime,
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                            fontSize: 45.0.sp, color: Colors.black54)),
                  )
                ],
              )),
          SizedBox(height: 35.h)
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: previousItemDate == 0
                ? Text(formattedDate,
                    textAlign: TextAlign.center,
                    style:
                        new TextStyle(fontSize: 60.0.sp, color: Colors.black54))
                : formattedDate ==
                        DateFormat.yMMMd().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                message!.sentDateTime!))
                    ? Container()
                    : Text(formattedDate,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 60.0.sp, color: Colors.black54)),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding:
                            EdgeInsets.fromLTRB(30.0.w, 30.0.h, 30.0.w, 30.0.h),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(message!.data!,
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontSize: 70.0.sp, color: Colors.black))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(formattedTime,
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                            fontSize: 45.0.sp, color: Colors.black54)),
                  )
                ],
              )),
          SizedBox(height: 30.h)
        ],
      );
    }
  }
}
