import 'package:auto_route/auto_route.dart';
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
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/database_helper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'chatnotification_count.dart';
import 'date_formater.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../router.gr.dart';

@RoutePage(name: 'RoomList')
class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  late io.Socket socket;
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
        body: Column(
          children: [
            Expanded(child: _populateListView(id!)),
          ],
        ));
  }

  getAppBar(BuildContext context) {
    if (!_isSelected && !_isRoomSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(
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
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isRoomSearching = true;
                });
              }),
          PopupMenuButton<String>(
            padding: const EdgeInsets.all(0),
            onSelected: (value) {
              if (value == "Chat With Friend") {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const inf.InviteFriend(
                //       roomId: '',
                //     ),
                //   ),
                // );
                context.router.push(
                  InviteFriend(
                    roomId: '',
                  ),
                );
              } else if (value == "Delete Message") {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DeleteMessage(),
                //   ),
                // );
              } else {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const cgp.CreateGroup(
                //       roomId: '',
                //     ),
                //   ),
                // );
                context.router.push(
                  CreateGroup(
                    roomId: '',
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "Chat With Friend",
                  child: Text("Chat With Friend"),
                ),
                const PopupMenuItem(
                  value: "Create Group",
                  child: Text("Create Group"),
                ),
                // PopupMenuItem(
                //   child: Text("Delete Message"),
                //   value: "Delete Message",
                // ),
              ];
            },
          ),
        ],
      );
    } else if (_isRoomSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(
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
          style: const TextStyle(color: Colors.white),
          autofocus: true,
          onChanged: (value) {
            _populateListView(id!);
          },
          // style: TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintText: "Search Room",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        // actions: <Widget>[
        //   if (editingController.text != '')
        //     IconButton(
        //       icon: Icon(Icons.cancel),
        //       onPressed: () {
        //         setState(() {
        //           editingController.clear();
        //         });
        //       },
        //     ),
        // ]
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(
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
        // backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
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
            content: const Text("Are you sure you want to  leave the group?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
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
                    for (var roomMember in roomMembers) {
                      if (userid != roomMember.userId) {
                        var leaveGroupJson = {
                          "notifiedRoomId": roomId,
                          "notifiedUserId": roomMember.userId,
                          "title": "$name just left the room",
                          "description": "$userid just left the room_$roomId"
                        };
                        //print(messageJson);
                        socket.emitWithAck('sendNotification', leaveGroupJson,
                            ack: (data) async {});
                      }
                    }

                    String clientMessageId = generateRandomString(15);

                    var messageJson = {
                      "roomId": roomId,
                      "msgBody": '$name left',
                      "msgBinaryType": 'userLeft',
                      "replyToId": -1,
                      "clientMessageId": clientMessageId,
                      "misc": "[FCM_Notification=title: $roomName - $name]"
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
                            // print('logout user from server $data');
                          } else {
                            //print("Null from logout user");
                          }
                        });
                        //print('sendMessage from server $data');
                      } else {
                        //print("Null from sendMessage");
                      }
                    });
                    if (!context.mounted) return;
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
                    final dir = Directory(
                        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                                : await getApplicationSupportDirectory() //FOR IOS
                            )!.path}/$roomId');
                    //bool dirExist = await dir.exists();

                    deleteDirectory(dir);
                    if (!context.mounted) return;
                    List<RoomHistoryModel> list =
                        await Provider.of<RoomHistory>(context, listen: false)
                            .getRoomHistory();
                    if (list.isEmpty) {
                      if (!context.mounted) return;
                      context
                          .read<SocketClientHelper>()
                          .loginUser('Tbs.Chat.Client-All-Users', userid, '');
                    }
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  void deleteDirectory(Directory directory) {
    if (directory.existsSync()) {
      directory.listSync().forEach((FileSystemEntity entity) {
        if (entity is File) {
          entity.deleteSync();
        } else if (entity is Directory) {
          deleteDirectory(entity);
        }
      });
      directory.deleteSync();
    }
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars = '1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  Widget _populateListView(String id) {
    Provider.of<RoomHistory>(context, listen: false).getRoomHistory();
    return Consumer<RoomHistory>(builder: (ctx, roomLIst, child) {
      // print('print count:1 - ${roomLIst.getRoomList.length}');
      return ListView.builder(
        itemCount: roomLIst.getRoomList.length,
        itemBuilder: (context, int index) {
          final isEvenIndex = index % 2 == 0;
          final itemColor = isEvenIndex ? Colors.grey[200] : Colors.white;
          rooms = roomLIst.getRoomList;
          if (rooms.isEmpty) return const SizedBox();
          RoomHistoryModel room = rooms[index];
          List<ChatNotification> chatNotificationCount = context
              .watch<ChatNotificationCount>()
              .getChatNotificationCountList;
          if (editingController.text.isEmpty) {
            return getCard(room, chatNotificationCount, index, itemColor);
          } else if (room.roomName
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

  // Widget getCard(
  //     RoomHistoryModel room,
  //     List<ChatNotification> chatNotificationCount,
  //     int index,
  //     Color? itemColor) {
  //   String splitRoomName = '';
  //   if (room.roomDesc!.toUpperCase() == 'GROUP CHAT') {
  //     splitRoomName = room.roomName!;
  //   } else {
  //     splitRoomName = room.roomName!;
  //   }
  //   int badgeCount = 0;
  //   int chatCountIndex = chatNotificationCount
  //       .indexWhere((element) => element.roomId == room.roomId);
  //   if (chatCountIndex != -1) {
  //     ChatNotification chatNotification = chatNotificationCount[chatCountIndex];
  //     badgeCount = chatNotification.notificationBadge!;
  //   }
  //   return Card(
  //     color: itemColor,
  //     child: ListTile(
  //       onLongPress: () {
  //         setState(() {
  //           _selectedIndex = index;
  //           _isSelected = true;
  //           _selectedRoomId = room.roomId!;
  //           _selectedRoomName = room.roomName!;
  //         });
  //       },
  //       tileColor: _selectedIndex == index ? Colors.blueAccent : null,
  //       leading: Container(
  //         width: 40,
  //         height: 40,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(
  //             color: Colors.white,
  //             width: 3,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.grey.withOpacity(.3),
  //                 offset: const Offset(0, 2),
  //                 blurRadius: 5)
  //           ],
  //         ),
  //         child: FullScreenWidget(
  //           child: Center(
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(8.0),
  //               child: room.picturePath != null && room.picturePath != ''
  //                   ? Image.network(room.picturePath!
  //                       .replaceAll(removeBracket, '')
  //                       .split('\r\n')[0])
  //                   : const Icon(Icons.account_circle),
  //             ),
  //           ),
  //         ),
  //       ),
  //       trailing: badgeCount > 0
  //           ? badges.Badge(
  //               showBadge: badgeCount > 0 ? true : false,
  //               badgeStyle: const badges.BadgeStyle(
  //                   badgeColor: Colors.green,
  //                   shape: badges.BadgeShape.circle,
  //                   padding: EdgeInsets.all(8)),
  //               badgeContent: Text(
  //                 badgeCount.toString(),
  //                 style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold),
  //               ))
  //           : null,
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: Text(splitRoomName.trim(),
  //                 maxLines: 1,
  //                 softWrap: false,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: const TextStyle(fontWeight: FontWeight.bold)),
  //           ),
  //           if (room.sendDateTime != null && room.sendDateTime != '')
  //             Text(DateFormatter().getDateTimeRepresentation(
  //                 DateTime.parse(room.sendDateTime!))),
  //         ],
  //       ),
  //       subtitle: showLatestMessage(room),
  //       onTap: () async {
  //         String members = '';
  //         if (room.roomId != null) {
  //           List<RoomMembers> roomMembers =
  //               await dbHelper.getRoomMembersList(room.roomId!);
  //           for (var roomMembers in roomMembers) {
  //             if (roomMembers.userId != id) {
  //               members += "${roomMembers.nickName!.toUpperCase()},";
  //             }
  //           }
  //           if (members != '') {
  //             members = members.substring(0, members.length - 1);
  //           }
  //         } else {
  //           members = '';
  //         }
  //         if (!context.mounted) return;
  //         context.router.push(
  //           ChatRoom(
  //             roomId: room.roomId ?? '',
  //             picturePath: room.picturePath ?? '',
  //             roomName: splitRoomName,
  //             roomDesc: room.roomDesc ?? '',
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget getCard(
    RoomHistoryModel room,
    List<ChatNotification> chatNotificationCount,
    int index,
    Color? itemColor,
  ) {
    String splitRoomName = '';
    if (room.roomDesc != null && room.roomDesc!.toUpperCase() == 'GROUP CHAT') {
      splitRoomName = room.roomName ?? '';
    } else {
      splitRoomName = room.roomName ?? '';
    }

    int badgeCount = 0;
    int chatCountIndex = chatNotificationCount
        .indexWhere((element) => element.roomId == room.roomId);
    if (chatCountIndex != -1) {
      ChatNotification chatNotification = chatNotificationCount[chatCountIndex];
      badgeCount = chatNotification.notificationBadge ?? 0;
    }

    return Card(
      color: itemColor,
      child: ListTile(
        onLongPress: () {
          setState(() {
            _selectedIndex = index;
            _isSelected = true;
            _selectedRoomId = room.roomId ?? '';
            _selectedRoomName = room.roomName ?? '';
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
                offset: const Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: FullScreenWidget(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: room.picturePath != null && room.picturePath != ''
                    ? Image.network(room.picturePath!
                        .replaceAll(removeBracket, '')
                        .split('\r\n')[0])
                    : const Icon(Icons.account_circle),
              ),
            ),
          ),
        ),
        trailing: badgeCount > 0
            ? badges.Badge(
                showBadge: badgeCount > 0 ? true : false,
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.green,
                  shape: badges.BadgeShape.circle,
                  padding: EdgeInsets.all(8),
                ),
                badgeContent: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                splitRoomName.trim(),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (room.sendDateTime != null && room.sendDateTime != '')
              Text(DateFormatter().getDateTimeRepresentation(
                DateTime.parse(room.sendDateTime!),
              )),
          ],
        ),
        subtitle: showLatestMessage(room),
        onTap: () async {
          String members = '';
          if (room.roomId != null) {
            List<RoomMembers> roomMembers =
                await dbHelper.getRoomMembersList(room.roomId!);
            for (var roomMember in roomMembers) {
              if (roomMember.userId != id) {
                members += "${roomMember.nickName?.toUpperCase() ?? ''},";
              }
            }
            if (members.isNotEmpty) {
              members = members.substring(0, members.length - 1);
            }
          }

          if (!context.mounted) return;
          context.router.push(
            ChatRoom(
              roomId: room.roomId ?? '',
              picturePath: room.picturePath ?? '',
              roomName: splitRoomName,
              roomDesc: room.roomDesc ?? '',
            ),
          );
        },
      ),
    );
  }

  Widget showLatestMessage(RoomHistoryModel room) {
    if (room.messageId != null && room.messageId! > 0) {
      if (room.filePath == null || room.filePath == '') {
        return Text(
          '${room.nickName ?? ""} : ${room.msgBody?.trim().replaceAll('\n', ' ') ?? ""}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        );
      } else if (room.msgBinaryType != null || room.msgBinaryType != '') {
        return Text(
          '${room.nickName ?? ""} : ${room.filePath?.split('/').last ?? ""}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
        );
      }
    }
    return Text(room.roomDesc ?? "");
  }
}
