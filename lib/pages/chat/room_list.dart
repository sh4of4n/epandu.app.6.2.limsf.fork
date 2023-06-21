import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart' as badges;
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
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
    //dbHelper.deleteDB();
    //Provider.of<ChatHistory>(context, listen: false).getChatHistory();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final getSocket = Provider.of<SocketClientHelper>(context, listen: false);
      socket = getSocket.socket;
    });
  }

  getRoomName() async {
    String? name = await localStorage.getName();
    roomTitle = name!;
    setState(() {
      roomTitle = roomTitle;
    });
  }

  // @override
  // void didChangeDependencies() {
  // super.didChangeDependencies();
  //socket = context.watch<SocketClientHelper>().socket;
  // }

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
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: Text(roomTitle),
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
              } else if (value == "Webview") {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TestWebview(
                //         url:
                //             "https://tbsweb.tbsdns.com/Tbs.Chat.Client.Web/DEVP/1_0/testwebview.html"),
                //   ),
                // );
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
                // PopupMenuItem(
                //   child: Text("Webview"),
                //   value: "Webview",
                // ),
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
        backgroundColor: Colors.blueAccent,
        title: TextField(
          controller: editingController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          autofocus: true,
          onChanged: (value) {
            //TODO can call widget class  in function?
            _populateListView(id!);
          },
          // style: TextStyle(color: Colors.white),
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
                        var messageJson = {
                          "roomId": roomId,
                        };
                        socket.emitWithAck('logout', messageJson, ack: (data) {
                          //print('ack $data');
                          if (data != null) {
                            print('logout user from server $data');
                          } else {
                            print("Null from logout user");
                          }
                        });
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
                    bool dirExist = await dir.exists();
                    if (dirExist) {
                      await dir.delete();
                    }

                    List<RoomHistoryModel> list =
                        await Provider.of<RoomHistory>(context, listen: false)
                            .getRoomHistory();
                    if (list.length == 0) {
                      context
                          .read<SocketClientHelper>()
                          .loginUser('Tbs.Chat.Client-All-Users', userid, '');
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars = '1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }

  Widget _populateListView(String id) {
    // return FutureBuilder<List<RoomHistoryModel>>(
    //   future: Provider.of<RoomHistory>(context, listen: false).getRoomHistory(),
    //   builder: (context, snapshot) {
    //     // Items are not available and you need to handle this situation, simple solution is to show a progress indicator
    //     if (!snapshot.hasData) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     return ListView.builder(
    //       itemCount: snapshot.data!.length,
    //       itemBuilder: (context, int index) {
    //         rooms = snapshot.data!;
    //         RoomHistoryModel room = this.rooms[index];
    //         List<ChatNotification> chatNotificationCount = context
    //             .watch<ChatNotificationCount>()
    //             .getChatNotificationCountList;
    //         if (editingController.text.isEmpty) {
    //           return getCard(room, chatNotificationCount, index);
    //         } else if (room.room_name
    //                 ?.toLowerCase()
    //                 .contains(editingController.text) ==
    //             true) {
    //           return getCard(room, chatNotificationCount, index);
    //         } else {
    //           return Container();
    //         }
    //       },
    //     );
    //   },
    // );

    Provider.of<RoomHistory>(context, listen: false).getRoomHistory();
    return Consumer<RoomHistory>(builder: (ctx, roomLIst, child) {
      // print('print count:1 - ${roomLIst.getRoomList.length}');
      return ListView.builder(
        itemCount: roomLIst.getRoomList.length,
        itemBuilder: (context, int index) {
          // final baseColor = Colors.blue.shade100; // Set the base color
          // final opacity =
          //     index % 2 == 0 ? 0.5 : 0.95; // Adjust opacity based on index

          // final itemColor = baseColor.withOpacity(opacity);

          final isEvenIndex = index % 2 == 0;
          final itemColor = isEvenIndex ? Colors.grey[200] : Colors.white;

          rooms = roomLIst.getRoomList;
          if (rooms.length == 0) return SizedBox();
          RoomHistoryModel room = this.rooms[index];
          List<ChatNotification> chatNotificationCount = context
              .watch<ChatNotificationCount>()
              .getChatNotificationCountList;
          if (editingController.text.isEmpty) {
            return getCard(room, chatNotificationCount, index, itemColor);
          } else if (room.room_name
                  ?.toLowerCase()
                  .contains(editingController.text) ==
              true) {
            return getCard(room, chatNotificationCount, index, itemColor);
          } else {
            return Container();
          }
        },
      );
    });
  }

  Widget getCard(
      RoomHistoryModel room,
      List<ChatNotification> chatNotificationCount,
      int index,
      Color? itemColor) {
    String splitRoomName = '';
    if (room.room_desc!.toUpperCase() == 'GROUP CHAT')
      splitRoomName = room.room_name!;
    else {
      // if (room.room_name!.contains(','))
      //   splitRoomName = roomTitle.toUpperCase() !=
      //           room.room_name!.split(',')[0].toUpperCase()
      //       ? room.room_name!.split(',')[0]
      //       : room.room_name!.split(',')[1];
      // else
      splitRoomName = room.room_name!;
    }
    //splitRoomName = room.room_name!;
    int badgeCount = 0;
    int chatCountIndex = chatNotificationCount
        .indexWhere((element) => element.roomId == room.room_id);
    if (chatCountIndex != -1) {
      ChatNotification chatNotification = chatNotificationCount[chatCountIndex];
      badgeCount = chatNotification.notificationBadge!;
    }
    return Card(
      color: itemColor,
      child: ListTile(
        onLongPress: () {
          setState(() {
            _selectedIndex = index;
            _isSelected = true;
            _selectedRoomId = room.room_id!;
            _selectedRoomName = room.room_name!;
          });
        },
        tileColor: _selectedIndex == index ? Colors.blueAccent : null,
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
          child: room.picture_path != null && room.picture_path != ''
              ? Image.network(room.picture_path!
                  .replaceAll(removeBracket, '')
                  .split('\r\n')[0])
              : Icon(Icons.account_circle),
        ),
        trailing: badgeCount > 0
            ? badges.Badge(
                //shape: BadgeShape.circle,
                //padding: EdgeInsets.all(8),
                showBadge: badgeCount > 0 ? true : false,
                //badgeColor: Colors.green,
                badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.green,
                    shape: badges.BadgeShape.circle,
                    padding: EdgeInsets.all(8)),
                badgeContent: Text(
                  badgeCount.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))
            : null,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(splitRoomName,
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
                roomId: room.room_id ?? '',
                picturePath: room.picture_path ?? '',
                roomName: splitRoomName,
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
            room.nick_name! +
                ' : ' +
                room.msg_body!.trim().replaceAll('\n', ' '),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
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
            maxLines: 1,
            softWrap: false,
          ))
        ],
      );
    }
    return Text(room.room_desc!);
  }
}
