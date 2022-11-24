import 'package:badges/badges.dart';
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'chat_history.dart';
import 'chat_home.dart';
import 'chatnotification_count.dart';
import 'create_group.dart';
import 'date_formater.dart';
import 'invite_friend.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  bool loading = true;
  final chatRoomRepo = ChatRoomRepo();
  TextEditingController editingController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  final authRepo = AuthRepo();
  String userName = '';

  final LocalStorage localStorage = LocalStorage();
  List<Room> rooms = [];
  String roomTitle = "";
  List<MessageDetails> messageDetails = [];
  List<MessageDetails> providermessageDetails = [];
  String? id = '';
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback(statusCallback);
    getRoomName();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      id = await localStorage.getUserId();
      // Provider.of<RoomHistory>(context, listen: false).getRoomHistory(id!);
      Provider.of<ChatHistory>(context, listen: false).getChatHistory();
    });
    //dbHelper.deleteDB();
    //_updateListview();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _updateListview();
  // }
  getRoomName() async {
    String? name = await localStorage.getName();
    roomTitle = name!;
    setState(() {});
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    EasyLoading.removeCallback(statusCallback);
    super.deactivate();
  }

  void statusCallback(EasyLoadingStatus status) {
    print('Test EasyLoading Status $status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Home()),
              // );
            },
          ),
          title: Text(roomTitle),
          backgroundColor: Colors.blueAccent,
          actions: [
            /*IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
              IconButton(icon: Icon(Icons.call), onPressed: () {}),*/
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                if (value == "Chat With Friend") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InviteFriend(
                        roomId: '',
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateGroup(
                        roomId: '',
                      ),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Chat With Friend"),
                    value: "Chat With Friend",
                  ),
                  PopupMenuItem(
                    child: Text("Create Group"),
                    value: "Create Group",
                  ),
                ];
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                    _populateListView(id!);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: editingController.text.length > 0
                          ? IconButton(
                              // Icon to
                              icon: Icon(Icons.clear), // clear text
                              onPressed: () {
                                editingController.text = '';
                                setState(() {});
                                _populateListView(id!);
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(child: _populateListView(id!)),
            ],
          ),
        ));
  }

  // _updateListview() async {
  //   await EasyLoading.show();
  //   String? userid = await localStorage.getUserId();
  //   rooms = await dbHelper.getRoomList(userid ?? '');
  //   providermessageDetails =
  //       Provider.of<ChatHistory>(context, listen: false).getMessageDetailsList;
  //   if (providermessageDetails.length > 0) {
  //     messageDetails = providermessageDetails;
  //   } else {
  //     messageDetails = await dbHelper.getLatestMsgToEachRoom();
  //   }

  //   setState(() {
  //     rooms = rooms;
  //     messageDetails = messageDetails;
  //   });
  //   await EasyLoading.dismiss();
  // }

  // getMessageDetails() async {
  //   providermessageDetails =
  //       Provider.of<ChatHistory>(context, listen: false).getMessageDetailsList;
  //   if (providermessageDetails.length > 0) {
  //     messageDetails = providermessageDetails;
  //   } else {
  //     messageDetails = await dbHelper.getLatestMsgToEachRoom();
  //   }
  // }

  Widget _populateListView(String id) {
    Provider.of<RoomHistory>(context, listen: false).getRoomHistory(id);
    return Consumer<RoomHistory>(
        builder: (ctx, roomLIst, child) => ListView.builder(
            itemCount: roomLIst.getRoomList.length,
            itemBuilder: (context, int index) {
              rooms = roomLIst.getRoomList;
              Room room = this.rooms[index];
              List<ChatNotification> chatNotificationCount = context
                  .watch<ChatNotificationCount>()
                  .getChatNotificationCountList;
              // getMessageDetails();
              List<MessageDetails> messageDetails =
                  Provider.of<ChatHistory>(context, listen: false)
                      .getMessageDetailsList
                      .where((element) => element.room_id == room.room_id)
                      .toList();
              MessageDetails msg = MessageDetails(
                  room_id: '',
                  user_id: '',
                  app_id: '',
                  ca_uid: '',
                  device_id: '',
                  msg_body: '',
                  msg_binary: '',
                  msg_binaryType: '',
                  reply_to_id: 0,
                  message_id: 0,
                  read_by: '',
                  status: '',
                  status_msg: '',
                  deleted: 0,
                  send_datetime: '',
                  edit_datetime: '',
                  delete_datetime: '',
                  transtamp: '',
                  nick_name: '',
                  filePath: '',
                  owner_id: '',
                  msgStatus: '',
                  client_message_id: '',
                  roomName: '');
              if (messageDetails.length > 0) {
                msg = messageDetails
                    .where((element) => element.room_id == room.room_id)
                    .last;
              }

              if (editingController.text.isEmpty) {
                return getCard(room, chatNotificationCount, msg);
              } else if (room.room_name
                      ?.toLowerCase()
                      .contains(editingController.text) ==
                  true) {
                return getCard(room, chatNotificationCount, msg);
              } else {
                return Container();
              }
            }));
  }

  Widget getCard(Room room, List<ChatNotification> chatNotificationCount,
      MessageDetails msg) {
    int badgeCount = 0;
    int chatCountIndex = chatNotificationCount
        .indexWhere((element) => element.roomId == room.room_id);
    if (chatCountIndex != -1) {
      ChatNotification chatNotification = chatNotificationCount[chatCountIndex];
      badgeCount = chatNotification.notificationBadge!;
    }
    return Card(
      child: ListTile(
        leading: Container(
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
                  offset: Offset(0, 2),
                  blurRadius: 5)
            ],
          ),
          child: FullScreenWidget(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: room.picture_path != null && room.picture_path != ''
                    ? Image.network(room.picture_path!
                        .replaceAll(removeBracket, '')
                        .split('\r\n')[0])
                    : Icon(Icons.account_circle),
              ),
            ),
          ),
        ),
        trailing: badgeCount > 0
            ? Badge(
                shape: BadgeShape.circle,
                padding: EdgeInsets.all(8),
                showBadge: badgeCount > 0 ? true : false,
                badgeColor: Colors.green,
                badgeContent: Text(
                  badgeCount.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))
            : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(room.room_name ?? '',
                style: TextStyle(fontWeight: FontWeight.bold)),
            if (msg.send_datetime != null && msg.send_datetime != '')
              Text(DateFormatter().getDateTimeRepresentation(
                  DateTime.parse(msg.send_datetime!))),
          ],
        ),
        subtitle: showLatestMessage(msg, room.room_desc ?? ''),
        onTap: () async {
          String members = '';
          List<RoomMembers> roomMembers =
              await dbHelper.getRoomMembersList(room.room_id!);
          for (var roomMembers in roomMembers) {
            if (roomMembers.user_id != id)
              members += roomMembers.nick_name!.toUpperCase() + ",";
          }
          members = members.substring(0, members.length - 1);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatHome2(
                Room_id: room.room_id ?? '',
                picturePath: room.picture_path ?? '',
                roomName: room.room_name ?? '',
                roomDesc: room.room_desc ?? '',
                // roomMembers: members
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showLatestMessage(MessageDetails msg, String description) {
    if (msg.message_id! > 0 &&
        (msg.msg_binaryType == '' || msg.msg_binaryType == null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            msg.nick_name! + ' : ' + msg.msg_body!,
            overflow: TextOverflow.ellipsis,
          )),
        ],
      );
    } else if (msg.message_id! > 0 &&
        (msg.msg_binaryType != '' || msg.msg_binaryType != null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Text(
            msg.nick_name! + ' : ' + msg.filePath!.split('/').last,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      );
    }

    return Text(description);
  }
}
