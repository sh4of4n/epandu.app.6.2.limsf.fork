import 'dart:convert';
import 'dart:io';
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
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

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
      'https://epandu1.tbsdns.com',
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
    print('loginUserRoom');
    List<Room> rooms = [];
    List<Room> newRooms = [];
    String? userid = await localStorage.getUserId();
    rooms = await dbHelper.getRoomList(userid!);
    if (rooms.length == 0) {
      var result = await chatRoomRepo.getRoomList();
      if (result.data != null && result.data.length > 0) {
        for (int i = 0; i < result.data.length; i += 1) {
          int val = await dbHelper.saveRoomTable(result.data[i]);
          ctx.read<RoomHistory>().addRoom(room: result.data[i]);
          print('Room Insert value ' + val.toString());
          var resultMembers =
              await chatRoomRepo.getRoomMembersList(result.data[i].room_id);
          print('roomMembers' + resultMembers.data.length.toString());
          if (resultMembers.data != null && resultMembers.data.length > 0) {
            for (int i = 0; i < resultMembers.data.length; i += 1) {
              await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
            }
          }
          loginUser(result.data[i].room_id, userid, result.data[i].create_date);
        }
      }
    } else {
      List<MessageDetails> list =
          await dbHelper.getLatestMsgDetail(rooms[0].room_id!);
      if (list.length > 0 && list[0].owner_id != userid) {
        await dbHelper.deleteDB();
        loginUserRoom();
      } else {
        rooms.forEach((Room room) async {
          loginUser(room.room_id!, room.user_id!, room.create_date!);
        });
        var result = await chatRoomRepo.getRoomList();
        if (result.data != null && result.data.length > 0) {
          for (int i = 0; i < result.data.length; i += 1) {
            int indexRoom = rooms.indexWhere(
                (element) => element.room_id == result.data[i].room_id);
            if (indexRoom == -1) {
              await dbHelper.saveRoomTable(result.data[i]);
              ctx.read<RoomHistory>().addRoom(room: result.data[i]);
              newRooms.add(result.data[i]);
            } else {
              if (rooms[indexRoom].picture_path !=
                      result.data[i].picture_path &&
                  result.data[i].picture_path != '') {
                dbHelper.updateRoomPic(
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
                    element.user_id == resultMembers.data[i].user_id);
                if (indexRoomMembers == -1) {
                  await dbHelper.saveRoomMembersTable(resultMembers.data[i]);
                } else {
                  if (roomMembersList[indexRoomMembers].picture_path !=
                          resultMembers.data[i].picture_path &&
                      resultMembers.data[i].picture_path != '') {
                    dbHelper.updateRoomMemberPic(resultMembers.data[i].user_id,
                        resultMembers.data[i].picture_path);
                  }
                }
              }
            }
          }
          if (newRooms.length > 0) {
            newRooms.forEach((Room newroom) {
              loginUser(
                  newroom.room_id!, newroom.user_id!, newroom.create_date!);
            });
          }
        }
      }
    }
  }

  logoutUserRoom() async {
    String? userid = await localStorage.getUserId();
    List<Room> rooms = [];
    rooms = await dbHelper.getRoomList(userid!);
    if (rooms.length > 0) {
      rooms.forEach((Room room) {
        var messageJson = {
          "roomId": room.room_id,
        };
        socket.emitWithAck('logout', messageJson, ack: (data) {
          //print('ack $data');
          if (data != null) {
            print('logout user from server $data');
          } else {
            print("Null from logout user");
          }
        });
      });
    }
    //  socket.disconnect();
    //  socket.dispose();
    //  notifyListeners();
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
      print('event :server connected');
      isSocketConnected = true;
      isReconnect = 'no';
      notifyListeners();
    });
    socket.onDisconnect((_) {
      print('event : server disconnected');
      isSocketConnected = false;
      isReconnect = 'no';
      loginUserRoom();
      notifyListeners();
    });
    socket.onAny((event, data) async {
      String? userid = await localStorage.getUserId();
      print('event :$event, data :$data');
      if (userid != '' && event == 'connect') {
        List<CheckOnline> onlineUsersList =
            Provider.of<OnlineUsers>(ctx, listen: false).getOnlineList;

        if (onlineUsersList.indexWhere((element) => element.userId == userid) ==
            -1) {
          List<Room> rooms = await dbHelper.getRoomList(userid!);
          rooms.forEach((Room room) {
            loginUser(room.room_id!, room.user_id!, room.create_date!);
          });
          sendFailedMessages();
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
        //print(receiveMessage.datetime);
        if (userid != receiveMessage.userId) {
          if (receiveMessage.binaryType != '') {
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
            nickName = item.nick_name;
          }
          MessageDetails messageDetails = MessageDetails(
              room_id: receiveMessage.roomId,
              user_id: receiveMessage.userId,
              app_id: "Carser.App",
              ca_uid: "",
              device_id: "",
              msg_body: receiveMessage.text,
              msg_binary: receiveMessage.binary ?? '',
              msg_binaryType: receiveMessage.binaryType ?? '',
              reply_to_id: receiveMessage.replyToId,
              message_id: receiveMessage.messageId,
              read_by: "",
              status: "",
              status_msg: "",
              deleted: 0,
              send_datetime: DateFormat("yyyy-MM-dd HH:mm:ss")
                  .format(
                      DateTime.parse(receiveMessage.datetime ?? '').toLocal())
                  .toString(),
              edit_datetime: "",
              delete_datetime: "",
              transtamp: "",
              nick_name: nickName,
              filePath: filePath,
              owner_id: userid,
              msgStatus: "UNREAD",
              client_message_id: receiveMessage.clientMessageId,
              roomName: '');
          // print(messageDetails.send_datetime);
          dbHelper.saveMsgDetailTable(messageDetails);
          ctx.read<ChatHistory>().addChatHistory(messageDetail: messageDetails);
          Provider.of<ChatNotificationCount>(ctx, listen: false)
              .updateNotificationBadge(
                  roomId: messageDetails.room_id, type: "");
          // Provider.of<ChatNotificationCount>(ctx, listen: false).addMessageId(
          //     messageDetails.room_id!,
          //     messageDetails.message_id.toString(),
          //     'OUT OF ROOM');
        } else {}
      } else {
        print("Null from message response");
      }
    });

    socket.on('notification', (data) async {
      if (data != null) {
        String description = '';
        String? userid = await localStorage.getUserId();
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result['description'] != null &&
            result['description'].toString() != '' &&
            result['description'].toString().split(' ')[0] != userid) {
          if (result['description']
              .toString()
              .contains("just entered the room")) {
            List<RoomMembers> list = await dbHelper.getRoomMemberName(
                result['description'].toString().split(' ')[0]);
            description = list[0].nick_name! + ' just entered the room';
          } else if (result['description']
              .toString()
              .contains("just left the room")) {
            List<RoomMembers> list = await dbHelper.getRoomMemberName(
                result['description'].toString().split(' ')[0]);
            description = list[0].nick_name! + ' just left the room';
          } else if (result['description']
              .toString()
              .contains("just disconnected")) {
            List<RoomMembers> list = await dbHelper.getRoomMemberName(
                result['description'].toString().split(' ')[0]);
            description = list[0].nick_name! + ' just disconnected.';
          } else {
            description = result['description'];
          }
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(channel);
          flutterLocalNotificationsPlugin.show(
              0,
              result['title'],
              description,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
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
        print('deleteMessage $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            ctx.read<ChatHistory>().deleteChatItem(result["messageId"]);
            dbHelper.deleteMsg(result["messageId"], result["deleteDateTime"]);
            List<MessageDetails> list =
                Provider.of<ChatHistory>(ctx, listen: false)
                    .getMessageDetailsList
                    .where((element) =>
                        element.message_id == result["messageId"] &&
                        element.msg_binaryType != '')
                    .toList();

            if (list.length > 0) {
              deleteFile(File(list[0].filePath!));
            }
          } else {
            dbHelper.deleteMsgDetailTable(result["messageId"]);
          }
          notifyListeners();
        }
      }
    });

    socket.on('updateMessageReadBy', (data) async {
      if (data != null) {
        print('updateMessageReadBy $data');
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            if (result["readBy"].contains('[[ALL]]')) {
              dbHelper.updateMsgStatus('READ', result["messageId"]);
              ctx
                  .read<ChatHistory>()
                  .updateChatItemStatus('', "READ", result["messageId"]);
            }
          } else {
            dbHelper.updateMsgStatus('READ', result["messageId"]);
          }
          notifyListeners();
        }
      }
    });
    socket.on('updateMessage', (data) async {
      if (data != null) {
        print('updateMessage $data');
        String? userid = await localStorage.getUserId();
        Map<String, dynamic> result = Map<String, dynamic>.from(data as Map);
        if (result["messageId"] != '') {
          if (_isEnterRoom) {
            int index = Provider.of<ChatHistory>(ctx, listen: false)
                .getMessageDetailsList
                .indexWhere((element) =>
                    element.user_id == userid &&
                    element.message_id == result["messageId"]);
            if (index == -1) {
              ctx.read<ChatHistory>().updateChatItemMessage(result["msgBody"],
                  result["messageId"], result['editDateTime']);
              dbHelper.updateMsgDetailTableText(result["msgBody"],
                  result["messageId"], result['editDateTime']);
            }
          } else {
            List<MessageDetails> messageDetails =
                await dbHelper.getAllMsgDetail();
            if (messageDetails.length > 0) {
              bool exists = messageDetails
                  .any((f) => f.user_id == userid && result["messageId"]);
              if (!exists) {
                dbHelper.updateMsgDetailTableText(result["msgBody"],
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
      if (messageDetails.client_message_id.toString() != '' && userid != '') {
        if (messageDetails.msg_binaryType == '') {
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
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  getMessageReadBy(int messageId) {
    var messageJson = {
      "messageId": messageId,
      "returnMsgBinaryAsBase64": "true"
    };
    //print(messageJson);
    socket.emitWithAck('getMessageById', messageJson, ack: (data) async {
      //print('getMessageById ack $data');
      if (data != null) {
        ReadByMessage readByMessage = ReadByMessage.fromJson(data);
        if (readByMessage.message!.readMessage![0].readBy != null &&
            readByMessage.message!.readMessage![0].readBy!
                .contains('[[ALL]]')) {
          print('[[ALL]]');
          dbHelper.updateMsgStatus(
              'READ', int.parse(readByMessage.message!.readMessage![0].id!));
          ctx.read<ChatHistory>().updateChatItemStatus('', "READ",
              int.parse(readByMessage.message!.readMessage![0].id!));
          // if (mounted) {
          //   setState(() {});
          // }
        }
      } else {
        print("Null from getMessageById");
      }
    });
  }

  void sendMessage(MessageDetails messageDetails, String localUserName) {
    var messageJson = {
      "roomId": messageDetails.room_id,
      "msgBody": messageDetails.msg_body,
      "replyToId": messageDetails.reply_to_id,
      "clientMessageId": messageDetails.client_message_id,
      "misc": "[FCM_Notification=title:" +
          messageDetails.roomName! +
          ' - ' +
          localUserName +
          "]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) async {
        print('sendMessage $messageJson');
        print('sendMessage ack $data');
        if (data != null) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.clientMessageId ==
              messageDetails.client_message_id) {
            int val = await dbHelper.updateMsgDetailTable(
                messageDetails.client_message_id!,
                "SENT",
                sendAcknowledge.messageId);
            if (isEnterRoom) {
              Provider.of<ChatHistory>(ctx, listen: false).updateChatItemStatus(
                  messageDetails.client_message_id!,
                  "SENT",
                  sendAcknowledge.messageId);
            }
            if (myFailedList.length > 0) {
              int index = myFailedList.indexWhere((element) =>
                  element.client_message_id ==
                  messageDetails.client_message_id!);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
          }
          print('sendMessage from server $data');
        } else {
          print("Null from sendMessage");
        }
      });
    }
  }

  Future<void> emitSendMessage(
    MessageDetails messageDetails,
    String localUserName,
  ) async {
    if (messageDetails.msg_body == '')
      messageDetails.msg_body = messageDetails.filePath!.split('/').last;
    var bytes = await File(messageDetails.filePath!).readAsBytes();
    var messageJson = {
      "roomId": messageDetails.room_id,
      "msgBody": messageDetails.msg_body,
      "msgBinaryBuffer": base64.encode(bytes),
      "replyToId": messageDetails.reply_to_id,
      "msgBinaryType": messageDetails.msg_binaryType,
      "clientMessageId": messageDetails.client_message_id,
      "misc": "[FCM_Notification=title:" +
          messageDetails.roomName! +
          ' - ' +
          localUserName +
          "]"
    };
    //print(messageJson);
    if (socket.connected) {
      socket.emitWithAck('sendMessage', messageJson, ack: (data) {
        //print('sendMessage ack $data');
        if (data != null) {
          SendAcknowledge sendAcknowledge = SendAcknowledge.fromJson(data);
          if (sendAcknowledge.clientMessageId ==
              messageDetails.client_message_id) {
            dbHelper.updateMsgDetailTable(messageDetails.client_message_id!,
                "SENT", sendAcknowledge.messageId);
            if (isEnterRoom) {
              ctx.read<ChatHistory>().updateChatItemStatus(
                  messageDetails.client_message_id!,
                  "SENT",
                  sendAcknowledge.messageId);
            }
            if (myFailedList.length > 0) {
              int index = myFailedList.indexWhere((element) =>
                  element.client_message_id ==
                  messageDetails.client_message_id);
              if (index > -1) {
                myFailedList.removeAt(index);
              }
            }
          }
          print('sendMessage from server $data');
        } else {
          print("Null from sendMessage");
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
      extension = "." + fileName.split('.').last;
    }
    try {
      Uint8List bytes = base64.decode(base64String);
      final dir = Directory((Platform.isAndroid
                  ? await getExternalStorageDirectory() //FOR ANDROID
                  : await getApplicationSupportDirectory() //FOR IOS
              )!
              .path +
          '/' +
          roomId +
          '/$folder');
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if ((await dir.exists())) {
        file = File(dir.path +
            "/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            extension);
        await file.writeAsBytes(bytes);
      } else {
        await dir.create(recursive: true);
        file = File(dir.path +
            "/" +
            DateTime.now().millisecondsSinceEpoch.toString() +
            extension);
        await file.writeAsBytes(bytes);
        //return dir.path;
      }
      return file.path;
    } on Exception catch (exception) {
      print(exception);
    } catch (error) {
      print(error);
    }
    return '';
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
    print('login: $messageJson');
    socket.emitWithAck('login', messageJson, ack: (data) {
      //print('ack $data');
      if (data != null) {
        notifyListeners();
        getMissingMessages(roomId, userId!, createDate);
        print('login user from server $data');
      } else {
        print("Null from login user");
      }
    });
  }

  getMissingMessages(String roomId, String userid, String createDate) async {
    String filePath = '';
    String? userId = await localStorage.getUserId();
    List<MessageDetails> messageDetailsList =
        await dbHelper.getLatestMsgDetail(roomId);
    Provider.of<ChatNotificationCount>(ctx, listen: false)
        .addNotificationBadge(notificationBadge: 0, roomId: roomId);
    var messageRoomJson;
    if (messageDetailsList.length > 0) {
      messageRoomJson = {
        "roomId": roomId,
        "returnMsgBinaryAsBase64": "true",
        "bgnMessageId": int.parse(messageDetailsList[0].message_id.toString())
      };
    } else {
      messageRoomJson = {
        "roomId": roomId,
        "returnMsgBinaryAsBase64": "true",
        "bgnSendDateTime":
            (DateFormat("yyyy-MM-dd").format(DateTime.now())).toString() +
                " 00:00:00"
      };
    }
    print(messageRoomJson);
    socket.emitWithAck('getMessageByRoom', messageRoomJson, ack: (data) async {
      print('getMessageByRoom $data');
      if (data != null) {
        MessageByRoomModel messageByRoomModel =
            MessageByRoomModel.fromJson(data);
        List<MessageList>? messageList =
            messageByRoomModel.message?.messageList;
        // print(messageByRoomModel);
        if (messageList != null) {
          if (messageDetailsList.length > 0) {
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: messageList.length - 1, roomId: roomId);
          } else {
            Provider.of<ChatNotificationCount>(ctx, listen: false)
                .addNotificationBadge(
                    notificationBadge: messageList.length, roomId: roomId);
          }
          //String sMessageId = '';

          messageList.forEach((f) async {
            if (userid != f.userId) {
              if (f.msgBinaryType != '' && f.msgBinary != null) {
                filePath = await createFile(f.msgBinaryType ?? '',
                    f.msgBinary ?? '', f.msgBody ?? '', f.roomId ?? '');
              }
            }
            String? nickName = '';
            List<RoomMembers> roomMembersList =
                await dbHelper.getRoomMemberName(f.userId);
            for (var item in roomMembersList) {
              nickName = item.nick_name;
            }
            MessageDetails messageDetails = MessageDetails(
                room_id: f.roomId,
                user_id: f.userId,
                app_id: f.appId,
                ca_uid: f.caUid,
                device_id: f.deviceId,
                msg_body: f.msgBody ?? '',
                msg_binary: f.msgBinary,
                msg_binaryType: f.msgBinaryType,
                reply_to_id: int.parse(f.replyToId!),
                message_id: int.parse(f.id!),
                read_by: f.readBy,
                status: f.status,
                status_msg: f.statusMsg,
                deleted: 0,
                send_datetime: DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(DateTime.parse(f.sendDatetime!).toLocal())
                    .toString(),
                edit_datetime: f.editDatetime,
                delete_datetime: f.deleteDatetime,
                transtamp: f.transtamp,
                nick_name: nickName,
                filePath: filePath,
                owner_id: userid,
                msgStatus: "",
                client_message_id: f.clientMessageId,
                roomName: '');
            //print(messageDetails.send_datetime);
            if (messageDetailsList.length > 0) {
              if (userid != messageDetails.user_id) {
                messageDetails.msgStatus = "UNREAD";
                dbHelper.saveMsgDetailTable(messageDetails);
              }
            } else {
              messageDetails.msgStatus = "UNREAD";
              dbHelper.saveMsgDetailTable(messageDetails);
            }
            ctx
                .read<ChatHistory>()
                .addChatHistory(messageDetail: messageDetails);
            //if (userId != messageDetails.user_id) sMessageId += f.id! + ',';
          });
          // Provider.of<ChatNotificationCount>(ctx, listen: false)
          //     .addMessageId(roomId, sMessageId, 'MISSING MESSAGES');
        } else {
          print("Null from getMessageByRoom");
        }
      } else {
        print("Null from getMessageByRoom");
      }
    });
  }
}
