import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/common_library/services/model/inbox_model.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hive/hive.dart';

import '../../router.gr.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  Future _getInboxList;
  final primaryColor = ColorConstant.primaryColor;
  final inboxRepo = InboxRepo();
  final inboxStorage = Hive.box('inboxStorage');
  final localStorage = LocalStorage();
  MsgOutBox msgOutBox;
  List<MsgOutBox> sortedInboxData = [];

  @override
  void initState() {
    super.initState();

    // Hive.box('ws_url').put('show_badge', false);
    _getInboxList = _getNotificationListByUserId();
  }

  _getNotificationListByUserId() async {
    var result = await inboxRepo.getNotificationListByUserId();

    if (result.isSuccess) {
      for (int i = 0; i < result.data.length; i += 1) {
        // save msgDoc and msgRef

        localStorage.saveMsgDoc(result.data[0].msgDoc);
        localStorage.saveMsgRef(result.data[0].msgRef);
      }
      // setState(() {
      //   Hive.box('ws_url').put('show_badge', false);
      // });
      return result.data;
    }
    return result.message;
  }

  getInboxStorageMessage(index) {
    MsgOutBox data = inboxStorage.getAt(index) as MsgOutBox;

    sortedInboxData.add(data);

    sortedInboxData.sort(
        (b, a) => int.tryParse(a.msgRef).compareTo(int.tryParse(b.msgRef)));

    // final sortedIndex = sortedInboxData[index];
    print(sortedInboxData[index].sendMsg);
    // print(inboxStorage.getAt[sortedIndex].sendMsg);

    return SelectableLinkify(
        onOpen: (link) {
          ExtendedNavigator.of(context)
              .push(Routes.webview, arguments: WebviewArguments(url: link.url));
        },
        text: data.sendMsg);
  }

  displayInboxMessage(msgData) {
    if (msgData != null) {
      // save inbox message
      msgOutBox = MsgOutBox(
        sendMsg: msgData.sendMsg,
        msgDoc: msgData.msgDoc,
        msgRef: msgData.msgRef,
      );

      // print(int.tryParse(msgData.msgRef));

      inboxStorage.add(msgOutBox);
      // end save inbox message
    }

    return SelectableLinkify(
      onOpen: (link) {
        ExtendedNavigator.of(context)
            .push(Routes.webview, arguments: WebviewArguments(url: link.url));
      },
      text: msgData.sendMsg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdc013),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('notifications')),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _getInboxList,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                      height: ScreenUtil().screenHeight,
                      child: Center(
                        child: SpinKitFoldingCube(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.data is String) {
                      if (inboxStorage.isEmpty &&
                          snapshot.data == 'No records found.') {
                        return Center(child: Text(snapshot.data));
                      }
                      return Container();
                    }
                    return Container(
                      color: Color(0xfff5f2e9),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(color: Colors.grey[400]),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Icon(Icons.mail, color: Color(0xff808080)),
                            title: displayInboxMessage(snapshot.data[index]),
                          );
                        },
                      ),
                    );
                  default:
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('inbox_list_fail'),
                      ),
                    );
                }
              },
            ),
            if (inboxStorage.isNotEmpty)
              Container(
                color: Color(0xfff5f2e9),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: inboxStorage.length,
                  // reverse: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: Colors.grey[400]),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.mail, color: Color(0xff808080)),
                      title: getInboxStorageMessage(index),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
