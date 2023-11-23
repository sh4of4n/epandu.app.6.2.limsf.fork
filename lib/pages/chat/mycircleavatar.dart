import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  final UserProfile userChat;
  MyCircleAvatar({
    super.key,
    required this.userChat,
  });

  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.3),
              offset: const Offset(0, 2),
              blurRadius: 5)
        ],
      ),
      child: CircleAvatar(
        child: Image.network(
            userChat.picturePath != null && userChat.picturePath!.isNotEmpty
                ? userChat.picturePath!
                    .replaceAll(removeBracket, '')
                    .split('\r\n')[0]
                : ''),
      ),
    );
  }
}
