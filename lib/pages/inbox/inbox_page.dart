import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/common_library/services/model/inbox_model.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:epandu/common_library/utils/app_localizations.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../router.gr.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  Future? _getInboxList;
  final primaryColor = ColorConstant.primaryColor;
  final inboxRepo = InboxRepo();
  final inboxStorage = Hive.box('inboxStorage');
  final localStorage = LocalStorage();
  MsgOutBox? msgOutBox;
  List<MsgOutBox?> sortedInboxData = [];

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

  Widget parseInboxMessage(String text) {
    RegExp exp = RegExp(
      r'(?:(?:https?|ftp?|192):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
      multiLine: true,
      caseSensitive: true,
    );

    Iterable<RegExpMatch> matches = exp.allMatches(text);

    if (text.contains('-B2.pdf') &&
        text.contains('-B3.pdf') &&
        text.contains('-SIJIL.pdf')) {
      List items = text.split(exp);
      List links = [];

      // print(items);

      matches.forEach((match) {
        links.add(text.substring(match.start, match.end));
        // print(text.substring(match.start, match.end));
      });

      // print(links);

      // return Text(text);

      return RichText(
        text: TextSpan(
          style: TextStyle(color: Color(0xff5c5c5c)),
          children: [
            TextSpan(
              text: items[0],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '1. Borang Penilaian Bahagian II',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[0],
                    ),
                  );
                },
            ),
            TextSpan(
              text: items[1],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '2. Borang Penilaian Bahagian III',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[1],
                    ),
                  );
                },
            ),
            TextSpan(
              text: items[2],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '3. Sijil Kepututusan',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[2],
                    ),
                  );
                },
            ),
          ],
        ),
      );
    } else if (text.contains('-B2.pdf') && text.contains('-SIJIL.pdf')) {
      List items = text.split(exp);
      List links = [];

      matches.forEach((match) {
        links.add(text.substring(match.start, match.end));
      });

      return RichText(
        text: TextSpan(
          style: TextStyle(color: Color(0xff5c5c5c)),
          children: [
            TextSpan(
              text: items[0],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '1. Borang Penilaian Bahagian II',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[0],
                    ),
                  );
                },
            ),
            TextSpan(
              text: items[1],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '2. Sijil Kepututusan',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[1],
                    ),
                  );
                },
            ),
          ],
        ),
      );
    } else if (text.contains('-B3.pdf') && text.contains('-SIJIL.pdf')) {
      List items = text.split(exp);
      List links = [];

      matches.forEach((match) {
        links.add(text.substring(match.start, match.end));
      });

      return RichText(
        text: TextSpan(
          style: TextStyle(color: Color(0xff5c5c5c)),
          children: [
            TextSpan(
              text: items[0],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '1. Borang Penilaian Bahagian III',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[0],
                    ),
                  );
                },
            ),
            TextSpan(
              text: items[1],
            ),
            TextSpan(
              style: TextStyle(color: Colors.blue[600]),
              text: '2. Sijil Kepututusan',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(
                    ViewPdf(
                      title: 'PDF',
                      pdfLink: links[1],
                    ),
                  );
                },
            ),
          ],
        ),
      );
    }
    return SelectableLinkify(
      onOpen: (link) => context.router.push(
        ViewPdf(
          title: 'PDF',
          pdfLink: link.url,
        ),
      ),
      text: text,
    );
  }

  getInboxStorageMessage() {
    MsgOutBox? data;

    for (int index = 0; index < inboxStorage.length; index += 1) {
      data = inboxStorage.getAt(index) as MsgOutBox?;

      sortedInboxData.add(data);

      sortedInboxData.sort(
          (b, a) => int.tryParse(a!.msgRef!)!.compareTo(int.tryParse(b!.msgRef!)!));

      // final sortedIndex = sortedInboxData[index];
      // print(sortedInboxData[index].sendMsg);
      // print(sortedInboxData[index].msgRef);
    }

    return Container(
      color: Color(0xfff5f2e9),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: sortedInboxData.length,
        // reverse: true,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(color: Colors.grey[400]),
        itemBuilder: (BuildContext context, int index) {
          if (sortedInboxData[index]?.msgType == 'PDF')
            /* return ListTile(
              leading: Icon(Icons.mail, color: Color(0xff808080)),
              title: parseInboxMessage(sortedInboxData[index].sendMsg),
            ); */
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  parseInboxMessage(sortedInboxData[index]!.sendMsg!),
                  SizedBox(height: 5),
                  if (sortedInboxData[index]!.createDate != null)
                    Text(sortedInboxData[index]!.createDate!),
                  if (sortedInboxData[index]!.merchantName != null)
                    Text(sortedInboxData[index]!.merchantName!),
                ],
              ),
            );
          return ListTile(
            leading: Icon(Icons.mail, color: Color(0xff808080)),
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableLinkify(
                    /* onOpen: (link) {
                          ExtendedNavigator.of(context).push(Routes.webview,
                              arguments: WebviewArguments(url: link.url));
                        }, */
                    onOpen: (link) {
                      launch(
                        link.url,
                        enableJavaScript: true,
                      );
                    },
                    text: sortedInboxData[index]!.sendMsg!,
                  ),
                  SizedBox(height: 5),
                  if (sortedInboxData[index]!.createDate != null)
                    Text(sortedInboxData[index]!.createDate!),
                  if (sortedInboxData[index]!.merchantName != null)
                    Text(sortedInboxData[index]!.merchantName!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  displayInboxMessage(msgData) {
    if (msgData != null) {
      // save inbox message
      msgOutBox = MsgOutBox(
        sendMsg: msgData.sendMsg,
        msgDoc: msgData.msgDoc,
        msgRef: msgData.msgRef,
        msgType: msgData.msgType,
        merchantName: msgData.merchantName,
        createDate: msgData.createDate,
        merchantShortName: msgData.merchantShortName,
        merchantNo: msgData.merchantNo,
      );

      // print(int.tryParse(msgData.msgRef));

      inboxStorage.add(msgOutBox);
      // end save inbox message
    }

    if (msgData.msgType == 'PDF') {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            parseInboxMessage(msgData.sendMsg),
            SizedBox(height: 5),
            if (msgData.createDate != null) Text(msgData.createDate),
            if (msgData.merchantName != null) Text(msgData.merchantName),
          ],
        ),
      );
      // return parseInboxMessage(msgData.sendMsg);
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableLinkify(
            onOpen: (link) {
              context.router.push(
                Webview(url: link.url),
              );
            },
            text: msgData.sendMsg,
          ),
          SizedBox(height: 5),
          if (msgData.createDate != null) Text(msgData.createDate),
          if (msgData.merchantName != null) Text(msgData.merchantName),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdc013),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('notifications')),
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
                        return Container(
                            height: ScreenUtil().screenHeight,
                            child: Center(
                              child: Text(
                                snapshot.data,
                              ),
                            ));
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
                        AppLocalizations.of(context)!
                            .translate('inbox_list_fail'),
                      ),
                    );
                }
              },
            ),
            if (inboxStorage.isNotEmpty) getInboxStorageMessage(),
          ],
        ),
      ),
    );
  }
}
