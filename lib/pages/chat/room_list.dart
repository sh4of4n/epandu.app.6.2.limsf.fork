import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart' as badges;
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/GetLeaveRoomResponse.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
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
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  late IO.Socket socket;
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  bool loading = true;
  final chatRoomRepo = ChatRoomRepo();
  TextEditingController editingController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  final authRepo = AuthRepo();
  String userName = '';
  int _selectedIndex = -1;
  bool _isSelected = false;
  bool _isRoomSearching = false;
  String _selectedRoomId = '';
  String _selectedRoomName = '';
  final LocalStorage localStorage = LocalStorage();
  List<RoomHistoryModel> rooms = [];
  String roomTitle = "";
  List<MessageDetails> messageDetails = [];
  List<MessageDetails> providermessageDetails = [];
  String? id = '';
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback(statusCallback);
    getRoomName();
    //Provider.of<RoomHistory>(context, listen: false).getRoomHistory();
    Provider.of<ChatHistory>(context, listen: false).getChatHistory();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   id = await localStorage.getUserId();

    // });
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    socket = context.watch<SocketClientHelper>().socket;
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
        appBar: getAppBar(context),
        body: Container(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     onChanged: (value) {
              //       setState(() {});
              //       _populateListView(id!);
              //     },
              //     controller: editingController,
              //     decoration: InputDecoration(
              //         labelText: "Search",
              //         hintText: "Search",
              //         prefixIcon: Icon(Icons.search),
              //         suffixIcon: editingController.text.length > 0
              //             ? IconButton(
              //                 // Icon to
              //                 icon: Icon(Icons.clear), // clear text
              //                 onPressed: () {
              //                   editingController.text = '';
              //                   setState(() {});
              //                   _populateListView(id!);
              //                 },
              //               )
              //             : null,
              //         border: OutlineInputBorder(
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(25.0)))),
              //   ),
              // ),
              Expanded(child: _populateListView(id!)),
            ],
          ),
        ));
  }

  getAppBar(BuildContext context) {
    if (!_isSelected && !_isRoomSearching) {
      return AppBar(
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
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isRoomSearching = true;
                });
              }),
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
      );
    } else if (_isRoomSearching) {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () {
            setState(() {
              _isRoomSearching = false;
            });
          },
        ),
        title: TextField(
          controller: editingController,
          onChanged: (value) {
            if (value != '') {
              _populateListView(id!);
            }
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Search Room",
              hintStyle: TextStyle(color: Colors.white)),
        ),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = -1;
              _isSelected = false;
              _selectedRoomId = '';
              _selectedRoomName = '';
            });
          },
        ),
        title: Text(roomTitle),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              leaveGroup(_selectedRoomId, _selectedRoomName);
              setState(() {
                _selectedIndex = -1;
                _isSelected = false;
                _selectedRoomId = '';
                _selectedRoomName = '';
              });
            },
          ),
        ],
      );
    }
  }

  void leaveGroup(String roomId, String roomName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Are you sure you want to  leave the group?"),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "Leave",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  var leaveRoomResponseResult =
                      await chatRoomRepo.leaveRoom(roomId);
                  if (leaveRoomResponseResult.data != null &&
                      leaveRoomResponseResult.data.length > 0) {
                    // LeaveRoomResponse leaveRoomResponse =
                    //     leaveRoomResponseResult.data[0];
                    String userid = await localStorage.getUserId() ?? '';
                    String name = await localStorage.getNickName() ?? '';
                    List<RoomMembers> roomMembers =
                        await dbHelper.getRoomMembersList(roomId);
                    roomMembers.forEach((roomMember) {
                      if (userid != roomMember.user_id) {
                        var leaveGroupJson = {
                          "notifiedRoomId": roomId,
                          "notifiedUserId": roomMember.user_id,
                          "title": name + " just left the room",
                          "description":
                              userid + " just left the room_" + roomId
                        };
                        //print(messageJson);
                        socket.emitWithAck('sendNotification', leaveGroupJson,
                            ack: (data) async {});
                      }
                    });

                    String clientMessageId = generateRandomString(15);

                    var messageJson = {
                      "roomId": roomId,
                      "msgBody": name + ' left',
                      "msgBinaryType": 'userLeft',
                      "replyToId": -1,
                      "clientMessageId": clientMessageId,
                      "misc": "[FCM_Notification=title:" +
                          roomName +
                          ' - ' +
                          name +
                          "]"
                    };

                    socket.emitWithAck('sendMessage', messageJson,
                        ack: (data) async {
                      if (data != null) {
                        print('sendMessage from server $data');
                      } else {
                        print("Null from sendMessage");
                      }
                    });
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .updateNotificationBadge(
                            roomId: roomId, type: "DELETE");
                    Provider.of<ChatNotificationCount>(context, listen: false)
                        .removeNotificationRoom(roomId: roomId);

                    Provider.of<RoomHistory>(context, listen: false)
                        .deleteRoom(roomId: roomId);

                    await dbHelper.deleteRoomById(roomId);
                    await dbHelper.deleteRoomMembersByRoomId(roomId);
                    await dbHelper.deleteMessagesByRoomId(roomId);
                    final dir = Directory((Platform.isAndroid
                                ? await getExternalStorageDirectory() //FOR ANDROID
                                : await getApplicationSupportDirectory() //FOR IOS
                            )!
                            .path +
                        '/' +
                        roomId);
                    if ((await dir.exists())) {
                      await dir.delete();
                    }
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars = '1234567890';
    // 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }

  Widget _populateListView(String id) {
    Provider.of<RoomHistory>(context, listen: false).getRoomHistory();
    return Consumer<RoomHistory>(
        builder: (ctx, roomLIst, child) => ListView.builder(
            itemCount: roomLIst.getRoomList.length,
            itemBuilder: (context, int index) {
              rooms = roomLIst.getRoomList;
              RoomHistoryModel room = this.rooms[index];
              List<ChatNotification> chatNotificationCount = context
                  .watch<ChatNotificationCount>()
                  .getChatNotificationCountList;
              if (editingController.text.isEmpty) {
                return getCard(room, chatNotificationCount, index);
              } else if (room.room_name
                      ?.toLowerCase()
                      .contains(editingController.text) ==
                  true) {
                return getCard(room, chatNotificationCount, index);
              } else {
                return Container();
              }
            }));
  }

  Widget getCard(RoomHistoryModel room,
      List<ChatNotification> chatNotificationCount, int index) {
    int badgeCount = 0;
    int chatCountIndex = chatNotificationCount
        .indexWhere((element) => element.roomId == room.room_id);
    if (chatCountIndex != -1) {
      ChatNotification chatNotification = chatNotificationCount[chatCountIndex];
      badgeCount = chatNotification.notificationBadge!;
    }
    return Card(
      child: ListTile(
        onLongPress: () {
          setState(() {
            _selectedIndex = index;
            _isSelected = true;
            _selectedRoomId = room.room_id!;
            _selectedRoomName = room.room_name!;
          });
        },
        tileColor: _selectedIndex == index ? Colors.blue : null,
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
            ? badges.Badge(
                shape: badges.BadgeShape.circle,
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
            Expanded(
              child: Text(room.room_name ?? '',
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            if (room.send_datetime != null && room.send_datetime != '')
              Text(DateFormatter().getDateTimeRepresentation(
                  DateTime.parse(room.send_datetime!))),
          ],
        ),
        subtitle: showLatestMessage(room),
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

  Widget showLatestMessage(RoomHistoryModel room) {
    if (room.message_id != null &&
        room.message_id! > 0 &&
        (room.filePath == '' || room.filePath == null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            room.nick_name! + ' : ' + room.msg_body!,
            overflow: TextOverflow.ellipsis,
          )),
        ],
      );
    } else if (room.message_id != null &&
        room.message_id! > 0 &&
        (room.msg_binaryType != '' || room.msg_binaryType != null)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Text(
            room.nick_name! + ' : ' + room.filePath!.split('/').last,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      );
    }
    return Text(room.room_desc!);
  }
}
