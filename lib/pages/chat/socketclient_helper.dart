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
import '../../common_library/services/model/chat_receive_message.dart';
import '../../common_library/services/model/chat_users.dart';
import '../../common_library/services/model/chatsendack_model.dart';
import '../../common_library/services/model/checkonline_model.dart';
import '../../common_library/services/model/createroom_response.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/messagebyroom_model.dart';
import '../../common_library/services/model/read_message_by_id_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/database_helper.dart';
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
  String preEvent = '';
  final chatRoomRepo = ChatRoomRepo();
  BuildContext ctx;
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
    //List<Room> newRooms = [];

    String? userid = await localStorage.getUserId();
    await loginUser('Tbs.Chat.Client-All-Users', userid!, '', '', '', '');
    if (!ctx.mounted) return;
    rooms = await dbHelper.getRooms();
    if (rooms.isEmpty) {
      var result = await chatRoomRepo.getRoomList('');
      if (result.data != null && result.data.length > 0) {
        for (int i = 0; i < result.data.length; i += 1) {
          await dbHelper.saveRoomTable(result.data[i]);
          RoomHistoryModel roomHistoryModel = RoomHistoryModel(
              roomId: result.data[i].roomId ?? '',
              roomName: result.data[i].roomName ?? '',
              roomDesc: result.data[i].roomDesc ?? '',
              picturePath: result.data[i].picturePath ?? '',
              deleted: result.data[i].deleted ?? 'false');
          if (!ctx.mounted) return;
          ctx.read<RoomHistory>().addRoom(room: roomHistoryModel);
          //print('Room Insert value ' + val.toString());
          var resultMembers =
              await chatRoomRepo.getRoomMembersList(result.data[i].roomId);
          //print('roomMembers' + resultMembers.data.length.toString());
          if (resultMembers.data != null && resultMembers.data.length > 0) {
            for (int i = 0; i < resultMembers.data.length; i += 1) {
              await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
            }
          }
          await loginUser(result.data[i].roomId, userid,
              result.data[i].createDate, '', result.data[i].deleted, '');
        }
        //logoutDefaultRoom();
      }
      // else {
      //   loginUser('Tbs.Chat.Client-All-Users', userid, '');
      // }
    } else {
      bool condition = false;
      if (rooms.where((room) => room.ownerId != userid).toList().isNotEmpty) {
        if (!ctx.mounted) return;
        Provider.of<ChatNotificationCount>(ctx, listen: false)
            .clearNotificationBadge();
        await dbHelper.deleteDB();
        final dir = Directory((Platform.isAndroid
                ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!
            .path);
        deleteDirectory(dir);
        condition = true;
      }
      if (condition) {
        await loginUserRoom();
        print('Condition is true. deleted directory and database.');
      } else {
        var result = await chatRoomRepo.getRoomList('');
        if (result.data != null && result.data.length > 0) {
          for (int i = 0; i < result.data.length; i += 1) {
            int indexRoom = rooms.indexWhere(
                (element) => element.roomId == result.data[i].roomId);
            if (indexRoom == -1) {
              await dbHelper.saveRoomTable(result.data[i]);
              RoomHistoryModel roomHistoryModel = RoomHistoryModel(
                  roomId: result.data[i].roomId ?? '',
                  roomName: result.data[i].roomName ?? '',
                  roomDesc: result.data[i].roomDesc ?? '',
                  picturePath: result.data[i].picturePath ?? '',
                  deleted: result.data[i].deleted ?? 'false');
              if (!ctx.mounted) return;
              ctx.read<RoomHistory>().addRoom(room: roomHistoryModel);
              await loginUser(
                  result.data[i].roomId,
                  userid,
                  result.data[i].createDate!,
                  '',
                  result.data[i].deleted ?? 'false',
                  '');
              //newRooms.add(result.data[i]);
            } else {
              if ((rooms[indexRoom].picturePath != result.data[i].picturePath &&
                      result.data[i].picturePath != '') ||
                  rooms[indexRoom].roomName != result.data[i].roomName) {
                await dbHelper.updateRoomDetails(result.data[i].roomId,
                    result.data[i].picturePath, result.data[i].roomName);
              }
            }
            var resultMembers =
                await chatRoomRepo.getRoomMembersList(result.data[i].roomId);
            if (resultMembers.data != null && resultMembers.data.length > 0) {
              List<RoomMembers> roomMembersList =
                  await dbHelper.getRoomMembersList(result.data[i].roomId);

              for (int i = 0; i < resultMembers.data.length; i += 1) {
                int indexRoomMembers = roomMembersList.indexWhere((element) =>
                    element.userId == resultMembers.data[i].userId);
                if (indexRoomMembers == -1) {
                  await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
                } else {
                  if ((roomMembersList[indexRoomMembers].picturePath !=
                          resultMembers.data[i].picturePath) ||
                      (roomMembersList[indexRoomMembers].nickName !=
                          resultMembers.data[i].nickName) ||
                      (roomMembersList[indexRoomMembers].deleted !=
                          resultMembers.data[i].deleted)) {
                    await dbHelper.updateRoomMemberPic(
                        resultMembers.data[i].userId ?? '',
                        resultMembers.data[i].picturePath ?? '',
                        resultMembers.data[i].nickName ?? '',
                        resultMembers.data[i].deleted ?? '',
                        resultMembers.data[i].roomId ?? '');
                  }
                }
              }
            }
          }
          // if (newRooms.isNotEmpty) {
          //   for (var newroom in newRooms) {
          //     await loginUser(newroom.roomId!, userid, newroom.createDate!, '',
          //         newroom.deleted!, '');
          //   }
          // }
          List<MessageDetails> messageDetailsList =
              await dbHelper.getAllRoomLatestMsgDetail();
          int completedRooms = 0;
          for (var room in rooms) {
            await Future.delayed(const Duration(seconds: 1));
            String messageId = '';
            List<MessageDetails> msgList = messageDetailsList
                .where((element) => element.roomId == room.roomId)
                .toList();
            if (msgList.isNotEmpty) {
              messageId = msgList[0].messageId.toString();
            }
            completedRooms++;
            print(
                'SocketOnAny:IsRoomDeleted ${room.deleted!} - ${room.deleteDatetime!}');
            await loginUser(room.roomId!, userid, room.createDate!, messageId,
                room.deleted!, room.deleteDatetime!);

            if (completedRooms == rooms.length) {
              sendFailedMessages();
            }
          }
        }
      }
    }

    //Check support room exist or not
    rooms = await dbHelper.getRooms();
    String? merchantNo = await localStorage.getMerchantDbCode();
    if (!doesRoomDescExist(rooms, 'Chat Support', merchantNo!)) {
      var createChatSupportResult =
          await chatRoomRepo.createChatSupportByMember();
      if (createChatSupportResult.data != null &&
          createChatSupportResult.data.length > 0) {
        if (!ctx.mounted) return;
        await loginUserRoom();
        String userid = await localStorage.getUserId() ?? '';
        CreateRoomResponse getCreateRoomResponse =
            createChatSupportResult.data[0];

        List<RoomMembers> roomMembers =
            await dbHelper.getRoomMembersList(getCreateRoomResponse.roomId!);
        for (var roomMember in roomMembers) {
          if (userid != roomMember.userId) {
            var inviteUserToRoomJson = {
              "invitedRoomId": getCreateRoomResponse.roomId!,
              "invitedUserId": roomMember.userId
            };
            socket.emitWithAck('inviteUserToRoom', inviteUserToRoomJson,
                ack: (data) {
              //print('ack $data');
              if (data != null && !data.containsKey("error")) {
                print('inviteUserToRoomJson from server $data');
              } else {
                print("Null from inviteUserToRoomJson");
              }
            });
          }
        }
      }
    }
  }

  bool doesRoomDescExist(
      List<Room>? roomlist, String targetRoomDesc, String merchantNo) {
    if (roomlist != null) {
      for (var room in roomlist) {
        if (room.roomDesc == targetRoomDesc && room.merchantNo == merchantNo) {
          return true; // 'Chat Support' exists
        }
      }
    }
    return false; // 'Chat Support' does not exist
  }

  // String generateRandomString(int length) {
  //   final random = Random();
  //   const availableChars = '123456789';
  //   final randomString = List.generate(length,
  //           (index) => availableChars[random.nextInt(availableChars.length)])
  //       .join();
  //   return randomString;
  // }
  String generateRandomString() {
    DateTime currentDateTime = DateTime.now();
    String randomString =
        DateFormat('yyyyMMddHHmmssSSS').format(currentDateTime);

    return randomString;
  }

  Future<void> logoutUserRoom() async {
    //String? userid = await localStorage.getUserId();
    List<Room> rooms = [];
    rooms = await dbHelper.getRooms();
    if (rooms.isNotEmpty) {
      for (var room in rooms) {
        var logoutJson = {
          "roomId": room.roomId,
        };
        socket.emitWithAck('logout', logoutJson, ack: (data) {
          //print('ack $data');
          if (data != null && !data.containsKey("error")) {
            //print('logout user from server $data');
          } else {
            //print("Null from logout user");
          }
        });
      }
    }
  }

  void disconnectSocket() {
    //socket.emit("disconnect");

    socket.emitWithAck('disconnect', '', ack: (data) {
      //print('ack $data');
      if (data != null && !data.containsKey("error")) {
        //print('logout user from server $data');
      } else {
        //print("Null from logout user");
      }
    });
  }

  logoutDefaultRoom() {
    var logoutJson = {
      "roomId": 'Tbs.Chat.Client-All-Users',
    };
    socket.emitWithAck('logout', logoutJson, ack: (data) {
      if (data != null && !data.containsKey("error")) {
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
    socket.onReconnect((_) async {
      String? userid = await localStorage.getUserId();
      List<Room> rooms = await dbHelper.getRooms();
      List<MessageDetails> messageDetailsList =
          await dbHelper.getAllRoomLatestMsgDetail();
      int completedRooms = 0;
      for (var room in rooms) {
        await Future.delayed(const Duration(seconds: 1));
        String messageId = '';
        List<MessageDetails> msgList = messageDetailsList
            .where((element) => element.roomId == room.roomId)
            .toList();
        if (msgList.isNotEmpty) {
          messageId = msgList[0].messageId.toString();
        }
        completedRooms++;
        print(
            'SocketOnAny:IsRoomDeleted ${room.deleted!} - ${room.deleteDatetime!}');
        await loginUser(room.roomId!, userid!, room.createDate!, messageId,
            room.deleted!, room.deleteDatetime!);

        if (completedRooms == rooms.length) {
          sendFailedMessages();
        }
      }
      notifyListeners();
    });
    socket.onDisconnect((_) {
      print('event : server disconnected');
      isSocketConnected = false;
      isReconnect = 'no';
      //loginUserRoom();
      notifyListeners();
    });
    // socket.onAny((event, data) async {
    //   //print('event :$event, data :$data');
    //   // if (event == 'disconnect') {
    //   //   preEvent = 'disconnect';
    //   // } else {
    //   //   preEvent = '';
    //   // }
    //   String? userid = await localStorage.getUserId();
    //   // if (userid != '' && event == 'connect' && preEvent == 'disconnect') {
    //   if (userid != '' && event == 'connect') {
    //     if (!ctx.mounted) return;
    //     // List<CheckOnline> onlineUsersList =
    //     //     Provider.of<OnlineUsers>(ctx, listen: false).getOnlineList;

    //     // if (onlineUsersList.indexWhere((element) => element.userId == userid) ==
    //     //     -1) {
    //     List<Room> rooms = await dbHelper.getRooms();
    //     List<MessageDetails> messageDetailsList =
    //         await dbHelper.getAllRoomLatestMsgDetail();
    //     int completedRooms = 0;
    //     for (var room in rooms) {
    //       await Future.delayed(const Duration(seconds: 1));
    //       String messageId = '';
    //       List<MessageDetails> msgList = messageDetailsList
    //           .where((element) => element.roomId == room.roomId)
    //           .toList();
    //       if (msgList.isNotEmpty) {
    //         messageId = msgList[0].messageId.toString();
    //       }
    //       completedRooms++;
    //       print(
    //           'SocketOnAny:IsRoomDeleted ${room.deleted!} - ${room.deleteDatetime!}');
    //       await loginUser(room.roomId!, userid!, room.createDate!, messageId,
    //           room.deleted!, room.deleteDatetime!);

    //       if (completedRooms == rooms.length) {
    //         sendFailedMessages();
    //       }
    //     }
    //     // } else {
    //     //   sendFailedMessages();
    //     // }
    //   }
    //   notifyListeners();
    // });

    socket.on('message', (data) async {
      String? userid = await localStorage.getUserId();
      //print(data);
      String filePath = "";
      if (data != null && !data.containsKey("error")) {
        ReceiveMessage receiveMessage = ReceiveMessage.fromJson(data);
        if (!ctx.mounted) return;
        List<RoomHistoryModel> roomHistoryList =
            await Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
        if (roomHistoryList.isNotEmpty) {
          if (roomHistoryList.indexWhere(
                  (element) => element.roomId == receiveMessage.roomId) >
              -1) {
            if (!ctx.mounted) return;
            ctx.read<RoomHistory>().updateRoomStatus(
                  roomId: receiveMessage.roomId!,
                );
            await dbHelper.updatedeleteStatusByRoomById(
                receiveMessage.roomId!, 'false');
          }
        }
        List<MessageDetails> isExist =
            await dbHelper.isMessageExist(receiveMessage.clientMessageId!);
        //print(receiveMessage.datetime);
        // if (userid != receiveMessage.userId && isExist.isEmpty) {
        if (isExist.isEmpty) {
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
              appId: appConfig.appId,
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
          if (!ctx.mounted) return;
          ctx.read<ChatHistory>().addChatHistory(messageDetail: messageDetails);
          ctx.read<RoomHistory>().updateRoomMessage(
              roomId: messageDetails.roomId!, message: receiveMessage.text!);
          ctx.read<RoomHistory>().getRoomHistory();
          if (userid != receiveMessage.userId) {
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
            roomId: result.data[0].roomId ?? '',
            roomName: result.data[0].roomName ?? '',
            roomDesc: result.data[0].roomDesc ?? '',
            picturePath: result.data[0].picturePath ?? '',
            deleted: result.data[0].deleted ?? 'false');
        if (!ctx.mounted) return;
        ctx.read<RoomHistory>().addRoom(room: roomHistoryModel);
        //print('Room Insert value ' + val.toString());
        var resultMembers =
            await chatRoomRepo.getRoomMembersList(result.data[0].roomId);
        //print('roomMembers' + resultMembers.data.length.toString());
        if (resultMembers.data != null && resultMembers.data.length > 0) {
          await dbHelper.batchInsertMembers(resultMembers.data);
          // for (int i = 0; i < resultMembers.data.length; i += 1) {
          //   await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
          // }
        }
        String? userId = await localStorage.getUserId();
        String? caUid = await localStorage.getCaUid();
        String? caPwd = await localStorage.getCaPwd();
        String? deviceId = await localStorage.getLoginDeviceId();
        var messageJson = {
          "roomId": result.data[0].roomId,
          "userId": userId,
          "appId": appConfig.appId,
          "caUid": caUid,
          "caPwd": caPwd,
          "deviceId": deviceId
        };
        //print('login: $messageJson');
        socket.emitWithAck('login', messageJson, ack: (data) {
          if (data != null && !data.containsKey("error")) {
            //print('login user from server $data');
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: 0, roomId: result.data[0].roomId);
            //logoutDefaultRoom();
          } else {
            //print("Null from login user");
          }
        });
      }
    });

    socket.on('notification', (data) async {
      if (data != null && !data.containsKey("error")) {
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result['description'] != null &&
            result['description'].toString() != '') {
          if (result['description']
              .toString()
              .contains("just changed the name")) {
            await dbHelper.updateRoomMemberName(
              result['title'].split(' ')[0],
              result['description'].split('_')[0],
            );
            // await dbHelper.updateRoomName(
            //   result['description'].split('_')[0],
            //   result['description'].split('_')[1],
            // );
            if (!ctx.mounted) return;
            Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
            //Need to update Chathistory provider
          } else if (result['description']
              .toString()
              .contains("just joined the room")) {
            await loginUserRoom();
            await dbHelper.updateRoomMemberStatus(
                result['description'].split(' ')[0],
                "false",
                result['description'].split('_')[1]);
          } else if (result['description']
              .toString()
              .contains("just left the room_")) {
            await loginUserRoom();
          } else if (result['description']
              .toString()
              .contains("just changed the group name")) {
            await dbHelper.updateRoomName(
              result['description'].split('_')[0],
              result['title'].split(' ')[0].toString().split('|')[1],
            );
            if (!ctx.mounted) return;
            Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
          }
        }
      }
    });

    socket.on('users', (data) async {
      if (data != null && data is List && !data.contains("error")) {
        List b = data;
        if (b.isNotEmpty) {
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
      }
    });

    socket.on('deleteMessage', (data) async {
      if (data != null && !data.containsKey("error")) {
        //print('deleteMessage $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            await ctx
                .read<ChatHistory>()
                .deleteChatItem(result["messageId"], result["roomId"]);
            //dbHelper.deleteMsg(result["messageId"], result["deleteDateTime"]);
            if (!ctx.mounted) return;
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
            //await dbHelper.deleteMsgDetailTable(result["messageId"]);
            await dbHelper.updateMessageStatus(result["messageId"]);
            if (!ctx.mounted) return;
            Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
          } else {
            await ctx
                .read<ChatHistory>()
                .deleteChatItem(result["messageId"], result["roomId"]);
            if (!ctx.mounted) return;
            Provider.of<RoomHistory>(ctx, listen: false).getRoomHistory();
            //await dbHelper.deleteMsgDetailTable(result["messageId"]);
            await dbHelper.updateMessageStatus(result["messageId"]);
          }
          notifyListeners();
        }
      }
    });

    socket.on('updateMessageReadBy', (data) async {
      if (data != null && !data.containsKey("error")) {
        print('updateMessageReadBy $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            if (result["readBy"].contains('[[ALL]]')) {
              await dbHelper.updateMsgStatus('READ', result["messageId"]);
              if (!ctx.mounted) return;
              ctx.read<ChatHistory>().updateChatItemStatus(
                  '', "READ", result["messageId"], result["roomId"], '');
            }
          } else {
            await dbHelper.updateMsgStatus('READ', result["messageId"]);
          }
          notifyListeners();
        }
      }
    });
    socket.on('updateMessage', (data) async {
      if (data != null && !data.containsKey("error")) {
        //print('updateMessage $data');
        String? userid = await localStorage.getUserId();
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            if (!ctx.mounted) return;
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
    myFailedList.sort((a, b) {
      if (a.sendDateTime == null || b.sendDateTime == null) {
        return 0;
      }
      return a.sendDateTime!.compareTo(b.sendDateTime!);
    });
    int i = 0;
    for (var messageDetails in myFailedList) {
      await Future.delayed(const Duration(seconds: 1));

      if (messageDetails.clientMessageId.toString() != '' && userid != '') {
        if (messageDetails.msgBinaryType == '') {
          await sendMessage(messageDetails, localUserName!);
        } else {
          await emitSendMessage(messageDetails, localUserName!);
        }
        i++;

        if (i == myFailedList.length) {
          myFailedList = [];
        }
      }
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print(e.toString());
    }
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
      if (data != null && !data.containsKey("error")) {
        ReadByMessage readByMessage = ReadByMessage.fromJson(data);
        if (readByMessage.message!.readMessage![0].readBy != null &&
            readByMessage.message!.readMessage![0].readBy!
                .contains('[[ALL]]')) {
          //print('[[ALL]]');
          await dbHelper.updateMsgStatus(
              'READ', int.parse(readByMessage.message!.readMessage![0].id!));
          if (!ctx.mounted) return;
          ctx.read<ChatHistory>().updateChatItemStatus(
              '',
              "READ",
              int.parse(readByMessage.message!.readMessage![0].id!),
              readByMessage.message!.readMessage![0].roomId!,
              '');
        }
      } else {
        //print("Null from getMessageById");
      }
    });
  }

  Future<void> sendMessage(
      MessageDetails messageDetails, String localUserName) async {
    var messageJson = {
      "roomId": messageDetails.roomId,
      "msgBody": messageDetails.msgBody,
      "replyToId": messageDetails.replyToId,
      "clientMessageId": messageDetails.clientMessageId,
      "misc":
          "[FCM_Notification=title: ${messageDetails.roomName!} - $localUserName]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
        // print('sendMessage $messageJson');
        // print('sendMessage ack $data');
        if (data != null && !data.containsKey("error")) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.clientMessageId ==
              messageDetails.clientMessageId) {
            await dbHelper.updateMsgDetailTable(
                messageDetails.clientMessageId!,
                "SENT",
                sendAcknowledge.messageId,
                DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                        .toLocal())
                    .toString());
            if (isEnterRoom) {
              if (!ctx.mounted) return;
              Provider.of<ChatHistory>(ctx, listen: false).updateChatItemStatus(
                  messageDetails.clientMessageId!,
                  "SENT",
                  sendAcknowledge.messageId,
                  messageDetails.roomId!,
                  DateFormat("yyyy-MM-dd HH:mm:ss")
                      .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                          .toLocal())
                      .toString());
            }
            // if (myFailedList.isNotEmpty) {
            //   int index = myFailedList.indexWhere((element) =>
            //       element.clientMessageId == messageDetails.clientMessageId!);
            //   if (index > -1) {
            //     myFailedList.removeAt(index);
            //   }
            // }
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
    File file = File(messageDetails.filePath!);
    if (file.existsSync()) {
      var bytes = await File(messageDetails.filePath!).readAsBytes();
      var messageJson = {
        "roomId": messageDetails.roomId,
        "msgBody": messageDetails.msgBody,
        "msgBinaryBuffer": base64.encode(bytes),
        "replyToId": messageDetails.replyToId,
        "msgBinaryType": messageDetails.msgBinaryType,
        "clientMessageId": messageDetails.clientMessageId,
        "misc":
            "[FCM_Notification=title: ${messageDetails.roomName!} - $localUserName]"
      };
      if (socket.connected) {
        socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
          //print('sendMessage ack $data');
          if (data != null && !data.containsKey("error")) {
            SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
            if (sendAcknowledge.clientMessageId ==
                messageDetails.clientMessageId) {
              await dbHelper.updateMsgDetailTable(
                  messageDetails.clientMessageId!,
                  "SENT",
                  sendAcknowledge.messageId,
                  DateFormat("yyyy-MM-dd HH:mm:ss")
                      .format(DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                          .toLocal())
                      .toString());
              if (isEnterRoom) {
                if (!ctx.mounted) return;
                ctx.read<ChatHistory>().updateChatItemStatus(
                    messageDetails.clientMessageId!,
                    "SENT",
                    sendAcknowledge.messageId,
                    messageDetails.roomId!,
                    DateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(
                            DateTime.parse(sendAcknowledge.sendDateTime ?? '')
                                .toLocal())
                        .toString());
              }
              // if (myFailedList.isNotEmpty) {
              //   int index = myFailedList.indexWhere((element) =>
              //       element.clientMessageId == messageDetails.clientMessageId);
              //   if (index > -1) {
              //     myFailedList.removeAt(index);
              //   }
              // }
            }
            // print('sendMessage from server $data');
          } else {
            //print("Null from sendMessage");
          }
        });
      }
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

  Future<void> loginUser(String roomId, String userId, String createDate,
      String messageId, String isRoomDeleted, String deleteDatetime) async {
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
    print('loginUser: $messageJson');

    socket.emitWithAck('login', messageJson, ack: (data) {
      print('loginUser ack $data');
      if (data != null && !data.containsKey("error")) {
        notifyListeners();
        Provider.of<ChatNotificationCount>(ctx, listen: false)
            .addNotificationBadge(notificationBadge: 0, roomId: roomId);
        if (roomId != 'Tbs.Chat.Client-All-Users' &&
            ((messageId != '' && messageId != '0') ||
                (isRoomDeleted.toLowerCase() == 'true' &&
                    deleteDatetime != ''))) {
          getMissingMessages(roomId, userId!, createDate, messageId,
              isRoomDeleted, deleteDatetime);
        }
        //print('login user from server $data');
      } else {
        //print("Null from login user");
      }
    });
  }

  void getMissingMessages(String roomId, String userid, String createDate,
      String messageId, String isRoomDeleted, String deleteDatetime) async {
    String filePath = '';
    Map<String, Object> messageRoomJson = {};

    if (messageId != '' && deleteDatetime == '') {
      messageRoomJson = {
        "roomId": roomId,
        "returnMsgBinaryAsBase64": "true",
        "bgnMessageId": int.parse(messageId) + 1,
      };
    } else if (deleteDatetime != '' &&
        messageId == '' &&
        isRoomDeleted.toLowerCase() == 'true') {
      messageRoomJson = {
        "roomId": roomId,
        "returnMsgBinaryAsBase64": "true",
        "bgnSendDateTime": deleteDatetime,
      };
    }
    print('getMessageByRoom: $messageRoomJson');
    socket.emitWithAck('getMessageByRoom', messageRoomJson, ack: (data) async {
      //print('getMessageByRoom $data');
      if (data != null && !data.containsKey("error")) {
        MessageByRoomModel messageByRoomModel =
            MessageByRoomModel.fromJson(data);
        List<MessageList>? messageList =
            messageByRoomModel.message?.messageList;
        if (messageList != null) {
          if (messageId == '' && deleteDatetime != '') {
            DateTime inputTime = DateTime.parse(deleteDatetime);
            messageList = messageList
                .where((message) => DateTime.parse(DateFormat(
                            "yyyy-MM-dd HH:mm:ss")
                        .format(DateTime.parse(message.sendDatetime!).toLocal())
                        .toString())
                    .isAfter(inputTime))
                .toList();
            if (messageList.isNotEmpty) {
              if (!ctx.mounted) return;
              ctx.read<RoomHistory>().updateRoomStatus(
                    roomId: roomId,
                  );
              await dbHelper.updatedeleteStatusByRoomById(roomId, 'false');
            }
          }
          if (messageList.isNotEmpty) {
            List<MessageList>? othersMessageList = messageList
                .where((message) =>
                    message.userId != userid &&
                    (message.readBy == null ||
                        !message.readBy!.contains('[[ALL]]')))
                .toList();
            if (!ctx.mounted) return;
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: othersMessageList.length,
                    roomId: roomId);
          }

          for (var f in messageList) {
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
              // if (userid == messageDetails.userId) {
              //   messageDetails.msgStatus = "READ";
              // } else {
              //   messageDetails.msgStatus = "UNREAD";
              // }
              if (userid != messageDetails.userId &&
                  (messageDetails.readBy == null ||
                      !messageDetails.readBy!.contains('[[ALL]]'))) {
                messageDetails.msgStatus = "UNREAD";
              } else if (userid != messageDetails.userId &&
                  (messageDetails.readBy != null &&
                      messageDetails.readBy!.contains('[[ALL]]'))) {
                messageDetails.msgStatus = "READ";
              } else if (userid == messageDetails.userId &&
                  (messageDetails.readBy != null &&
                      messageDetails.readBy!.contains('[[ALL]]'))) {
                messageDetails.msgStatus = "READ";
              } else {
                messageDetails.msgStatus = "UNREAD";
              }
              if (f.msgBinaryType != '' &&
                  f.msgBinary != null &&
                  f.msgBinary != '') {
                messageDetails.filePath = await createFile(
                    f.msgBinaryType ?? '',
                    f.msgBinary ?? '',
                    f.msgBody ?? '',
                    f.roomId ?? '');
              }
              await dbHelper.saveMsgDetailTable(messageDetails);
              if (!ctx.mounted) return;
              ctx
                  .read<ChatHistory>()
                  .addChatHistory(messageDetail: messageDetails);
            }
          }
        } else {
          //print("Null from getMessageByRoom");
        }
      } else {
        // print("Null from getMessageByRoom");
      }
    });
  }
}
