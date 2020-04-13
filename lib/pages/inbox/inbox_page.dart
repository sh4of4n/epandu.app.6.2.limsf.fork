import 'package:epandu/services/api/model/notification_model.dart';
import 'package:epandu/services/repository/inbox_repository.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  Future _getInboxList;
  final primaryColor = ColorConstant.primaryColor;
  final inboxRepo = InboxRepo();

  @override
  void initState() {
    super.initState();

    // Hive.box('ws_url').put('show_badge', false);
    _getInboxList = _getNotificationListByUserId();
  }

  _getNotificationListByUserId() async {
    var result = await inboxRepo.getNotificationListByUserId(context: context);

    if (result.isSuccess) {
      Provider.of<NotificationModel>(context, listen: false)
          .setNotification(false);
      return result.data;
    }
    return result.message;
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
      body: FutureBuilder(
        future: _getInboxList,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: SpinKitFoldingCube(
                  color: Colors.blue,
                ),
              );
            case ConnectionState.done:
              if (snapshot.data is String) {
                return Center(child: Text(snapshot.data));
              }
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.mail, color: Color(0xff808080)),
                    title: Text(snapshot.data[index].sendMsg),
                  );
                },
              );
            default:
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate('inbox_list_fail'),
                ),
              );
          }
        },
      ),
    );
  }
}
