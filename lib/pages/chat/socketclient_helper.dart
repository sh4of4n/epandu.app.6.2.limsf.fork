import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/chat_receiveMessage.dart';
import '../../common_library/services/model/chat_users.dart';
import '../../common_library/services/model/chatsendack_model.dart';
import '../../common_library/services/model/checkonline_model.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/messagebyroom_model.dart';
import '../../common_library/services/model/readmessagebyId_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
import '../../utils/app_config.dart';
import 'chat_history.dart';
import 'chatnotification_count.dart';
import 'online_users.dart';

class SocketClientHelper extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  final chatRoomRepo = ChatRoomRepo();
  final BuildContext ctx;
  List<MessageDetails> myFailedList = [];
  final appConfig = AppConfig();
  SocketClientHelper(this.ctx);
  final LocalStorage localStorage = LocalStorage();
  bool isSocketConnected = false;
  String _roomId = '';
  String isReconnect = '';
  bool _isEnterRoom = false;
  final Socket _socket = io(
      'https://tbsjcloud1.tbsdns.com:9090',
      OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .setPath('/Tbs.Chat.Server/1_0/socket.io')
          //.enableForceNewConnection()
          .build());
  final dbHelper = DatabaseHelper.instance;
  String get roomId => _roomId;
  bool get isEnterRoom => _isEnterRoom;
  Socket get socket => _socket;

  Future loginUserRoom() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    //print('loginUserRoom');
    List<Room> rooms = [];
    List<Room> newRooms = [];

    String? userid = await localStorage.getUserId();
    loginUser('Tbs.Chat.Client-All-Users', userid!, '');
    rooms = await dbHelper.getRoomList(userid);
    if (rooms.isEmpty) {
      var result = await chatRoomRepo.getRoomList('');
      if (result.data != null && result.data.length > 0) {
        for (int i = 0; i < result.data.length; i += 1) {
          int insertVal = await dbHelper.saveRoomTable(result.data[i]);
          print('insertVal: ${insertVal.toString()}');
          RoomHistoryModel roomHistoryModel = RoomHistoryModel(
              roomId: result.data[i].room_id ?? '',
              roomName: result.data[i].room_name ?? '',
              roomDesc: result.data[i].room_desc ?? '',
              picturePath: result.data[i].picture_path ?? '');
          if (ctx.mounted) {
            ctx.read<RoomHistory>().addRoom(room: roomHistoryModel);
          }
          print('Room Insert Id: ${result.data[i].room_id}');
          var resultMembers =
              await chatRoomRepo.getRoomMembersList(result.data[i].room_id);
          print('Room Members Insert: ${resultMembers.data.length}');
          if (resultMembers.data != null && resultMembers.data.length > 0) {
            for (int i = 0; i < resultMembers.data.length; i += 1) {
              await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
            }
          }
          loginUser(result.data[i].room_id, userid, result.data[i].create_date);
        }
        //logoutDefaultRoom();
      }
      // else {
      //   loginUser('Tbs.Chat.Client-All-Users', userid, '');
      // }
    } else {
      bool condition = false;
      for (int i = 0; i < rooms.length; i++) {
        List<MessageDetails> list =
            await dbHelper.getLatestMsgDetail(rooms[i].roomId!);
        if (list.isNotEmpty && list[0].ownerId != userid) {
          await dbHelper.deleteDB();
          final dir = Directory((Platform.isAndroid
                  ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory() //FOR IOS
              )!
              .path);
          deleteDirectory(dir);
          await loginUserRoom();
          condition = true;
        }
        if (condition) {
          print('Condition is true. deleted directory and database.');
          break;
        }
      }
      if (!condition) {
        rooms.forEach((Room room) async {
          loginUser(room.roomId!, room.userId!, room.createDate!);
        });

        var result = await chatRoomRepo.getRoomList('');
        if (result.data != null && result.data.length > 0) {
          for (int i = 0; i < result.data.length; i += 1) {
            int indexRoom = rooms.indexWhere(
                (element) => element.roomId == result.data[i].room_id);
            if (indexRoom == -1) {
              await dbHelper.saveRoomTable(result.data[i]);
              RoomHistoryModel roomHistoryModel = RoomHistoryModel(
                  roomId: result.data[i].room_id ?? '',
                  roomName: result.data[i].room_name ?? '',
                  roomDesc: result.data[i].room_desc ?? '',
                  picturePath: result.data[i].picture_path ?? '');
              if (ctx.mounted) {
                ctx.read<RoomHistory>().addRoom(room: roomHistoryModel);
              }
              newRooms.add(result.data[i]);
            } else {
              if (rooms[indexRoom].picturePath != result.data[i].picture_path &&
                  result.data[i].picture_path != '') {
                await dbHelper.updateRoomPic(
                    result.data[i].room_id, result.data[i].picture_path);
              }
            }
            var resultMembers =
                await chatRoomRepo.getRoomMembersList(result.data[i].room_id);
            if (resultMembers.data != null && resultMembers.data.length > 0) {
              List<RoomMembers> roomMembersList =
                  await dbHelper.getRoomMembersList(result.data[i].room_id);

              for (int i = 0; i < resultMembers.data.length; i += 1) {
                int indexRoomMembers = roomMembersList.indexWhere((element) =>
                    element.userId == resultMembers.data[i].user_id);
                if (indexRoomMembers == -1) {
                  await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
                } else {
                  if ((roomMembersList[indexRoomMembers].picturePath !=
                          resultMembers.data[i].picture_path) ||
                      (roomMembersList[indexRoomMembers].nickName !=
                          resultMembers.data[i].nick_name) ||
                      (roomMembersList[indexRoomMembers].deleted !=
                          resultMembers.data[i].deleted)) {
                    await dbHelper.updateRoomMemberPic(
                        resultMembers.data[i].user_id ?? '',
                        resultMembers.data[i].picture_path ?? '',
                        resultMembers.data[i].nick_name ?? '',
                        resultMembers.data[i].deleted ?? '');
                  }
                }
              }
            }
          }
          if (newRooms.isNotEmpty) {
            for (var newroom in newRooms) {
              loginUser(newroom.roomId!, newroom.userId!, newroom.createDate!);
            }
            //logoutDefaultRoom();
          }
        }
      }
    }
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars = '1234567890';
    // 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();
    return randomString;
  }

  logoutUserRoom() async {
    String? userid = await localStorage.getUserId();
    List<Room> rooms = [];
    rooms = await dbHelper.getRoomList(userid!);
    if (rooms.isNotEmpty) {
      for (var room in rooms) {
        var logoutJson = {
          "roomId": room.roomId,
        };
        socket.emitWithAck('logout', logoutJson, ack: (data) {
          //print('ack $data');
          if (data != null) {
            //print('logout user from server $data');
          } else {
            //print("Null from logout user");
          }
        });
      }
    }
  }

  logoutDefaultRoom() {
    var logoutJson = {
      "roomId": 'Tbs.Chat.Client-All-Users',
    };
    socket.emitWithAck('logout', logoutJson, ack: (data) {
      if (data != null) {
        //print('logout Tbs.Chat.Client-All-Users from server $data');
      } else {
        //print("Null from logout user");
      }
    });
  }

  setRoomDetails(String id, String roomName, String userName) {
    _roomId = id;
    notifyListeners();
  }

  setIsEnterRoom(bool isEntered) {
    _isEnterRoom = isEntered;
    notifyListeners();
  }

  initSocket() {
    socket.onConnect((_) async {
      //print('event :server connected');
      isSocketConnected = true;
      isReconnect = 'no';
      notifyListeners();
    });
    // socket.onReconnect((_) async {
    //   print('event :server reconnected');
    //   isSocketConnected = true;
    //   isReconnect = 'yes';
    //   String? userid = await localStorage.getUserId();
    //   if (userid != '') {
    //     List<CheckOnline> onlineUsersList =
    //         Provider.of<OnlineUsers>(ctx, listen: false).getOnlineList;

    //     if (onlineUsersList.indexWhere((element) => element.userId == userid) ==
    //         -1) {
    //       List<Room> rooms = await dbHelper.getRoomList(userid!);
    //       rooms.forEach((Room room) {
    //         loginUser(room.room_id!, room.user_id!, room.create_date!);
    //       });
    //       sendFailedMessages();
    //     } else {
    //       sendFailedMessages();
    //     }
    //   }
    //   notifyListeners();
    // });
    socket.onDisconnect((_) {
      //print('event : server disconnected');
      isSocketConnected = false;
      isReconnect = 'no';
      loginUserRoom();
      notifyListeners();
    });
    socket.onAny((event, data) async {
      //print('event :$event, data :$data');
      String? userid = await localStorage.getUserId();
      if (userid != '' && event == 'connect') {
        if (ctx.mounted) {
          List<CheckOnline> onlineUsersList =
              Provider.of<OnlineUsers>(ctx, listen: false).getOnlineList;

          if (onlineUsersList
                  .indexWhere((element) => element.userId == userid) ==
              -1) {
            List<Room> rooms = await dbHelper.getRoomList(userid!);
            for (var room in rooms) {
              loginUser(room.roomId!, room.userId!, room.createDate!);
            }
            sendFailedMessages();
          }
        } else {
          sendFailedMessages();
        }
      }
      notifyListeners();
    });

    socket.on('message', (data) async {
      String? userid = await localStorage.getUserId();
      //print(data);
      String filePath = "";
      if (data != null) {
        ReceiveMessage receiveMessage = ReceiveMessage.fromJson(data);

        List<MessageDetails> isExist =
            await dbHelper.isMessageExist(receiveMessage.clientMessageId!);
        //print(receiveMessage.datetime);
        if (userid != receiveMessage.userId && isExist.isEmpty) {
          if (receiveMessage.binary != null && receiveMessage.binary != '') {
            filePath = await createFile(
                receiveMessage.binaryType ?? '',
                receiveMessage.binary ?? '',
                receiveMessage.text ?? '',
                receiveMessage.roomId ?? '');
          }
          String? nickName = '';
          List<RoomMembers> roomMembersList =
              await dbHelper.getRoomMemberName(receiveMessage.userId);
          for (var item in roomMembersList) {
            nickName = item.nickName;
          }
          MessageDetails messageDetails = MessageDetails(
              roomId: receiveMessage.roomId,
              userId: receiveMessage.userId,
              appId: "Carser.App",
              caUid: "",
              deviceId: "",
              msgBody: receiveMessage.text,
              msgBinary: receiveMessage.binary ?? '',
              msgBinaryType: receiveMessage.binaryType ?? '',
              replyToId: receiveMessage.replyToId,
              messageId: receiveMessage.messageId,
              readBy: "",
              status: "",
              statusMsg: "",
              deleted: 0,
              sendDateTime: DateFormat("yyyy-MM-dd HH:mm:ss")
                  .format(
                      DateTime.parse(receiveMessage.datetime ?? '').toLocal())
                  .toString(),
              editDateTime: "",
              deleteDateTime: "",
              transtamp: "",
              nickName: nickName,
              filePath: filePath,
              ownerId: userid,
              msgStatus: "UNREAD",
              clientMessageId: receiveMessage.clientMessageId,
              roomName: '');
          await dbHelper.saveMsgDetailTable(messageDetails);
          if (ctx.mounted) {
            ctx
                .read<ChatHistory>()
                .addChatHistory(messageDetail: messageDetails);
            ctx.read<RoomHistory>().updateRoomMessage(
                roomId: messageDetails.roomId!, message: receiveMessage.text!);
            ctx.read<RoomHistory>().getRoomHistory();
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .updateNotificationBadge(
                    roomId: messageDetails.roomId, type: "");
          }
          // Provider.of<ChatNotificationCount>(ctx, listen: false).addMessageId(
          //     messageDetails.room_id!,
          //     messageDetails.message_id.toString(),
          //     'OUT OF ROOM');
        } else {}
      } else {
        //print("Null from message response");
      }
    });
    socket.on('inviteUserToRoom', (data) async {
      Map<String, dynamic> mapResult = Map<String, dynamic>.from(data as Map);
      var result = await chatRoomRepo.getRoomList(mapResult['invitedRoomId']!);
      if (result.data != null && result.data.length > 0) {
        await dbHelper.saveRoomTable(result.data[0]);
        RoomHistoryModel roomHistoryModel = RoomHistoryModel(
            roomId: result.data[0].room_id ?? '',
            roomName: result.data[0].room_name ?? '',
            roomDesc: result.data[0].room_desc ?? '',
            picturePath: result.data[0].picture_path ?? '');
        if (ctx.mounted) {
          ctx.read<RoomHistory>().addRoom(room: roomHistoryModel);
        }
        //print('Room Insert value ' + val.toString());
        var resultMembers =
            await chatRoomRepo.getRoomMembersList(result.data[0].room_id);
        //print('roomMembers' + resultMembers.data.length.toString());
        if (resultMembers.data != null && resultMembers.data.length > 0) {
          for (int i = 0; i < resultMembers.data.length; i += 1) {
            await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
          }
        }
        String? userId = await localStorage.getUserId();
        String? caUid = await localStorage.getCaUid();
        String? caPwd = await localStorage.getCaPwd();
        String? deviceId = await localStorage.getLoginDeviceId();
        var messageJson = {
          "roomId": result.data[0].room_id,
          "userId": userId,
          "appId": appConfig.appId,
          "caUid": caUid,
          "caPwd": caPwd,
          "deviceId": deviceId
        };
        //print('login: $messageJson');
        socket.emitWithAck('login', messageJson, ack: (data) {
          if (data != null) {
            //print('login user from server $data');
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: 0, roomId: result.data[0].room_id);
            //logoutDefaultRoom();
          } else {
            //print("Null from login user");
          }
        });
      }
    });

    socket.on('notification', (data) async {
      if (data != null) {
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result['description'] != null &&
            result['description'].toString() != '') {
          if (result['description']
              .toString()
              .contains("just changed the name")) {
            await dbHelper.updateRoomMemberName(
              result['description'].split(' ')[0],
              result['title'].split('_')[0],
            );
            //Need to update Chathistory provider
          } else if (result['description']
              .toString()
              .contains("just joined the room")) {
            loginUserRoom();
            await dbHelper.updateRoomMemberStatus(
                result['description'].split(' ')[0],
                "false",
                result['description'].split('_')[1]);
          } else if (result['description']
              .toString()
              .contains("just left the room_")) {
            loginUserRoom();
          }
        }
      }
    });

    socket.on('users', (data) async {
      if (data != null) {
        List b = data as List;
        List<ChatUsers> chatUserList =
            b.map((e) => ChatUsers.fromJson(e)).toList();
        ctx.read<OnlineUsers>().removeOnlineUsers();
        for (var item in chatUserList) {
          ChatUsers chatUsers = ChatUsers(
            roomId: item.roomId,
            userId: item.userId,
            appId: item.appId,
            caUid: item.caUid,
            deviceId: item.deviceId,
            joined: item.joined,
            firstJoinedDatetime: item.firstJoinedDatetime,
            lastJoinedDatetime: item.lastJoinedDatetime,
            lastLeftDatetime: item.lastLeftDatetime,
          );
          CheckOnline checkOnline =
              CheckOnline(isOnline: true, userId: chatUsers.userId);
          ctx.read<OnlineUsers>().showOnlineUsers(checkOnline: checkOnline);
        }
      }
    });

    socket.on('deleteMessage', (data) async {
      if (data != null) {
        //print('deleteMessage $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            ctx
                .read<ChatHistory>()
                .deleteChatItem(result["messageId"], result["roomId"]);
            //dbHelper.deleteMsg(result["messageId"], result["deleteDateTime"]);
            List<MessageDetails> list =
                Provider.of<ChatHistory>(ctx, listen: false)
                    .getMessageDetailsList
                    .where((element) =>
                        element.messageId == result["messageId"] &&
                        element.roomId == result["roomId"] &&
                        element.msgBinaryType != '')
                    .toList();

            if (list.isNotEmpty) {
              await deleteFile(File(list[0].filePath!));
            }
            await dbHelper.deleteMsgDetailTable(result["messageId"]);
            if (ctx.mounted) {
              Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
            }
          } else {
            ctx
                .read<ChatHistory>()
                .deleteChatItem(result["messageId"], result["roomId"]);
            Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
            await dbHelper.deleteMsgDetailTable(result["messageId"]);
          }
          notifyListeners();
        }
      }
    });

    socket.on('updateMessageReadBy', (data) async {
      if (data != null) {
        //print('updateMessageReadBy $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            if (result["readBy"].contains('[[ALL]]')) {
              await dbHelper.updateMsgStatus('READ', result["messageId"]);
              if (ctx.mounted) {
                ctx.read<ChatHistory>().updateChatItemStatus(
                    '', "READ", result["messageId"], result["roomId"]);
              }
            }
          } else {
            await dbHelper.updateMsgStatus('READ', result["messageId"]);
          }
          notifyListeners();
        }
      }
    });
    socket.on('updateMessage', (data) async {
      if (data != null) {
        //print('updateMessage $data');
        String? userid = await localStorage.getUserId();
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            if (ctx.mounted) {
              int index = Provider.of<ChatHistory>(ctx, listen: false)
                  .getMessageDetailsList
                  .indexWhere((element) =>
                      element.userId == userid &&
                      element.messageId == result["messageId"] &&
                      element.roomId == result["roomId"]);
              if (index == -1) {
                ctx.read<ChatHistory>().updateChatItemMessage(
                    result["msgBody"],
                    result["messageId"],
                    result['editDateTime'],
                    result['roomId']);
                await dbHelper.updateMsgDetailTableText(result["msgBody"],
                    result["messageId"], result['editDateTime']);
              }
            }
          } else {
            List<MessageDetails> messageDetails =
                await dbHelper.getAllMsgDetail();
            if (messageDetails.isNotEmpty) {
              bool exists = messageDetails
                  .any((f) => f.userId == userid && result["messageId"]);
              if (!exists) {
                await dbHelper.updateMsgDetailTableText(result["msgBody"],
                    result["messageId"], result['editDateTime']);
              }
            }
          }
          notifyListeners();
        }
      }
    });
  }

  sendFailedMessages() async {
    String? userid = await localStorage.getUserId();
    String? localUserName = await localStorage.getName();
    myFailedList = await dbHelper.getFailedMsgDetailList();
    myFailedList.forEach((messageDetails) async {
      if (messageDetails.clientMessageId.toString() != '' && userid != '') {
        if (messageDetails.msgBinaryType == '') {
          sendMessage(messageDetails, localUserName!);
        } else {
          emitSendMessage(messageDetails, localUserName!);
        }
      }
    });
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {}
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

  getMessageReadBy(int messageId) {
    var messageJson = {
      "messageId": messageId,
      "returnMsgBinaryAsBase64": "true"
    };
    //print(messageJson);
    socket.emitWithAck('getMessageById', messageJson, ack: (data) async {
      if (data != null) {
        ReadByMessage readByMessage = ReadByMessage.fromJson(data);
        if (readByMessage.message!.readMessage![0].readBy != null &&
            readByMessage.message!.readMessage![0].readBy!
                .contains('[[ALL]]')) {
          //print('[[ALL]]');
          await dbHelper.updateMsgStatus(
              'READ', int.parse(readByMessage.message!.readMessage![0].id!));
          if (ctx.mounted) {
            ctx.read<ChatHistory>().updateChatItemStatus(
                '',
                "READ",
                int.parse(readByMessage.message!.readMessage![0].id!),
                readByMessage.message!.readMessage![0].roomId!);
          }
        }
      } else {
        //print("Null from getMessageById");
      }
    });
  }

  void sendMessage(MessageDetails messageDetails, String localUserName) {
    var messageJson = {
      "roomId": messageDetails.roomId,
      "msgBody": messageDetails.msgBody,
      "replyToId": messageDetails.replyToId,
      "clientMessageId": messageDetails.clientMessageId,
      "misc": "[FCM_Notification=title:" +
          messageDetails.roomName! +
          ' - ' +
          localUserName +
          "]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
        // print('sendMessage $messageJson');
        // print('sendMessage ack $data');
        if (data != null) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.clientMessageId ==
              messageDetails.clientMessageId) {
            await dbHelper.updateMsgDetailTable(messageDetails.clientMessageId!,
                "SENT", sendAcknowledge.messageId);
            if (isEnterRoom) {
              if (ctx.mounted) {
                Provider.of<ChatHistory>(ctx, listen: false)
                    .updateChatItemStatus(
                        messageDetails.clientMessageId!,
                        "SENT",
                        sendAcknowledge.messageId,
                        messageDetails.roomId!);
              }
            }
            if (myFailedList.isNotEmpty) {
              int index = myFailedList.indexWhere((element) =>
                  element.clientMessageId == messageDetails.clientMessageId!);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
          }
          //print('sendMessage from server $data');
        } else {
          //print("Null from sendMessage");
        }
      });
    }
  }

  Future<void> emitSendMessage(
    MessageDetails messageDetails,
    String localUserName,
  ) async {
    if (messageDetails.msgBody == '') {
      messageDetails.msgBody = messageDetails.filePath!.split('/').last;
    }
    var bytes = await File(messageDetails.filePath!).readAsBytes();
    var messageJson = {
      "roomId": messageDetails.roomId,
      "msgBody": messageDetails.msgBody,
      "msgBinaryBuffer": base64.encode(bytes),
      "replyToId": messageDetails.replyToId,
      "msgBinaryType": messageDetails.msgBinaryType,
      "clientMessageId": messageDetails.clientMessageId,
      "misc": "[FCM_Notification=title:" +
          messageDetails.roomName! +
          ' - ' +
          localUserName +
          "]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
        //print('sendMessage ack $data');
        if (data != null) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.clientMessageId ==
              messageDetails.clientMessageId) {
            await dbHelper.updateMsgDetailTable(messageDetails.clientMessageId!,
                "SENT", sendAcknowledge.messageId);
            if (isEnterRoom) {
              if (ctx.mounted) {
                ctx.read<ChatHistory>().updateChatItemStatus(
                    messageDetails.clientMessageId!,
                    "SENT",
                    sendAcknowledge.messageId,
                    messageDetails.roomId!);
              }
            }
            if (myFailedList.isNotEmpty) {
              int index = myFailedList.indexWhere((element) =>
                  element.clientMessageId == messageDetails.clientMessageId);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
          }
          // print('sendMessage from server $data');
        } else {
          //print("Null from sendMessage");
        }
      });
    }
  }

  Future<String> createFile(String fileType, String base64String,
      String fileName, String roomId) async {
    File file;
    String folder = "";
    String extension = "";
    if (fileType == "audio") {
      folder = "Audios";
      extension = ".mp3";
    } else if (fileType == "image") {
      folder = "Images";
      extension = ".png";
    } else if (fileType == "video") {
      folder = "Videos";
      extension = ".mp4";
    } else if (fileType == "file") {
      folder = "Files";
      extension = ".${fileName.split('.').last}";
    }
    try {
      Uint8List bytes = base64.decode(base64String);
      final dir = Directory(
          '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory() //FOR IOS
              )!.path}/$roomId/$folder');
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   await Permission.storage.request();
      // }
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final random = Random().nextInt(10000).toString();
      if ((await dir.exists())) {
        file = File("${dir.path}/$timestamp$random$extension");
        await file.writeAsBytes(bytes);
      } else {
        await dir.create(recursive: true);
        file = File("${dir.path}/$timestamp$random$extension");
        await file.writeAsBytes(bytes);
        //return dir.path;
      }
      return file.path;
    } on Exception {
      return '';
      //print(exception);
    } catch (error) {
      return '';
      //print(error);
    }
  }

  void loginUser(String roomId, String userId, String createDate) async {
    String? userId = await localStorage.getUserId();
    String? caUid = await localStorage.getCaUid();
    String? caPwd = await localStorage.getCaPwd();
    String? deviceId = await localStorage.getLoginDeviceId();
    var messageJson = {
      "roomId": roomId,
      "userId": userId,
      "appId": appConfig.appId,
      "caUid": caUid,
      "caPwd": caPwd,
      "deviceId": deviceId
    };
    //print('login: $messageJson');

    socket.emitWithAck('login', messageJson, ack: (data) {
      //print('ack $data');
      if (data != null) {
        notifyListeners();
        Provider.of<ChatNotificationCount>(ctx, listen: false)
            .addNotificationBadge(notificationBadge: 0, roomId: roomId);
        if (createDate != '') getMissingMessages(roomId, userId!, createDate);
        //print('login user from server $data');
      } else {
        //print("Null from login user");
      }
    });
  }

  getMissingMessages(String roomId, String userid, String createDate) async {
    String filePath = '';
    List<MessageDetails> messageDetailsList =
        await dbHelper.getLatestMsgDetail(roomId);
    var messageRoomJson;

    if (messageDetailsList.isNotEmpty) {
      messageRoomJson = {
        "roomId": roomId,
        "returnMsgBinaryAsBase64": "true",
        "bgnMessageId": int.parse(messageDetailsList[0].messageId.toString())
      };
    } else {
      messageRoomJson = {
        "roomId": roomId,
        "returnMsgBinaryAsBase64": "true",
        "bgnSendDateTime":
            "${DateFormat("yyyy-MM-dd").format(DateTime.now())} 00:00:00"
      };
    }
    print(messageRoomJson);
    socket.emitWithAck('getMessageByRoom', messageRoomJson, ack: (data) async {
      //print('getMessageByRoom $data');
      if (data != null) {
        MessageByRoomModel messageByRoomModel =
            MessageByRoomModel.fromJson(data);
        List<MessageList>? messageList =
            messageByRoomModel.message?.messageList;
        if (messageList != null) {
          if (messageDetailsList.isNotEmpty) {
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: messageList.length - 1, roomId: roomId);
          } else {
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: messageList.length, roomId: roomId);
          }

          messageList.forEach((f) async {
            List<MessageDetails> isExist =
                await dbHelper.isMessageExist(f.clientMessageId!);
            if (isExist.isEmpty) {
              String? nickName = '';
              List<RoomMembers> roomMembersList =
                  await dbHelper.getRoomMemberName(f.userId);
              if (roomMembersList.isNotEmpty) {
                nickName = roomMembersList[0].nickName;
              }

              MessageDetails messageDetails = MessageDetails(
                  roomId: f.roomId,
                  userId: f.userId,
                  appId: f.appId,
                  caUid: f.caUid,
                  deviceId: f.deviceId,
                  msgBody: f.msgBody ?? '',
                  msgBinary: f.msgBinary,
                  msgBinaryType: f.msgBinaryType,
                  replyToId: int.parse(f.replyToId!),
                  messageId: int.parse(f.id!),
                  readBy: f.readBy,
                  status: f.status,
                  statusMsg: f.statusMsg,
                  deleted: 0,
                  sendDateTime: DateFormat("yyyy-MM-dd HH:mm:ss")
                      .format(DateTime.parse(f.sendDatetime!).toLocal())
                      .toString(),
                  editDateTime: f.editDatetime,
                  deleteDateTime: f.deleteDatetime,
                  transtamp: f.transtamp,
                  nickName: nickName,
                  filePath: filePath,
                  ownerId: userid,
                  msgStatus: "",
                  clientMessageId: f.clientMessageId,
                  roomName: '');

              messageDetails.msgStatus = "UNREAD";
              if (f.msgBinaryType != '' && f.msgBinary != null) {
                messageDetails.filePath = await createFile(
                    f.msgBinaryType ?? '',
                    f.msgBinary ?? '',
                    f.msgBody ?? '',
                    f.roomId ?? '');
              }
              await dbHelper.saveMsgDetailTable(messageDetails);
              if (ctx.mounted) {
                ctx
                    .read<ChatHistory>()
                    .addChatHistory(messageDetail: messageDetails);
              }
            }
          });
        } else {
          //print("Null from getMessageByRoom");
        }
      } else {
        // print("Null from getMessageByRoom");
      }
    });
  }
}
