import 'package:epandu/pages/chat/chat_screen.dart';
import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class ContactList extends StatelessWidget {
  final UserProfile? contactList;

  ContactList({super.key, this.contactList});

  final LocalStorage localStorage = LocalStorage();
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  Widget build(BuildContext context) {
    String? picpath;
    if (contactList!.picturePath == null) {
      picpath = "";
    } else {
      picpath = contactList!.picturePath;
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
                  targetId: contactList!.userId,
                  picturePath: picpath,
                  name: contactList!.name,
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
                  offset: const Offset(0, 5),
                  blurRadius: 25)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CircleAvatar(
                  child: contactList!.picturePath != null &&
                          contactList!.picturePath!.isNotEmpty
                      ? Image.network(contactList!.picturePath!
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
          contactList!.name!,
          style: Theme.of(context).textTheme.headlineSmall,
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
