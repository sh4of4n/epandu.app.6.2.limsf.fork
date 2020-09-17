import 'package:epandu/pages/chat/chat_screen.dart';
import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:epandu/services/api/model/chat_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class UserChatListItem extends StatelessWidget {
  final UserProfile userChat;

  UserChatListItem({this.userChat});

  final LocalStorage localStorage = LocalStorage();
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  Widget build(BuildContext context) {
    String picpath;
    if (userChat.picturePath == null) {
      picpath = "";
    } else {
      picpath = userChat.picturePath;
    }
    return SizedBox(
      height: 300.h,
      width: 1400.w,
      child: ListTile(
        onLongPress: () {},
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(
                  targetId: userChat.userId,
                  picturePath: picpath,
                  name: userChat.name,
                );
              },
            ),
          );
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: Offset(0, 5),
                  blurRadius: 25)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CircleAvatar(
                  child: userChat.picturePath != null &&
                          userChat.picturePath.isNotEmpty
                      ? Image.network(userChat.picturePath
                          .replaceAll(removeBracket, '')
                          .split('\r\n')[0])
                      : Image.memory(kTransparentImage),
                ),
              ), /*
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ) */
            ],
          ),
        ),
        title: Text(
          userChat.name,
          style: Theme.of(context).textTheme.headline5,
        ), /*
        subtitle: Text("My last message}",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .apply(color: Colors.black87)), 
        trailing: Container(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    size: 15,
                  ),
                  Text("last message")
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.center,
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "5",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),*/
      ),
    );
  }
}
