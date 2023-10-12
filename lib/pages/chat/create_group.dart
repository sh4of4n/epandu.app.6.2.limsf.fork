import 'dart:math';

import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/invitefriend_model.dart';
import '../../common_library/services/model/inviteroom_response.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/custom_dialog.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/database_helper.dart';
import '../../services/repository/chatroom_repository.dart';
import '../../utils/app_config.dart';
import 'chat_history.dart';
import 'chat_home.dart';
import 'socketclient_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    Key? key,
    required this.roomId,
  }) : super(key: key);
  final String roomId;

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final appConfig = AppConfig();
  late io.Socket socket;
  bool isMultiSelectionEnabled = true;
  final TextEditingController _textFieldController = TextEditingController();
  String codeDialog = "";
  String valueText = "";
  final dbHelper = DatabaseHelper.instance;
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  bool loading = false;
  final chatRoomRepo = ChatRoomRepo();
  TextEditingController editingController = TextEditingController();
  final authRepo = AuthRepo();
  String userName = '';
  final LocalStorage localStorage = LocalStorage();
  List<Room> rooms = [];
  List<MemberByPhoneResponse> memberByPhoneResponseList = [];
  List<MemberByPhoneResponse> _selected = [];
  @override
  void initState() {
    super.initState();
    //EasyLoading.showSuccess('Use in initState');
    EasyLoading.addStatusCallback(statusCallback);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final getSocket = Provider.of<SocketClientHelper>(context, listen: false);
      socket = getSocket.socket;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   socket = context.watch<SocketClientHelper>().socket;
  // }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    EasyLoading.removeCallback(statusCallback);
    super.deactivate();
  }

  void statusCallback(EasyLoadingStatus status) {
    //print('Test EasyLoading Status $status');
  }

  AppBar getAppBar(BuildContext context) {
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
      title: widget.roomId == ''
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.group_add_rounded,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Create Group'),
                ),
              ],
            )
          : const Row(
              children: [
                Icon(
                  Icons.group_add_rounded,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Add Member To Group'),
                ),
              ],
            )
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: TextField(
      //     keyboardType: TextInputType.number,
      //     onChanged: (value) {
      //       if (value.length > 9) {
      //         getFriendData();
      //       } else {
      //         getFriendData();
      //       }
      //     },
      //     controller: editingController,
      //     decoration: InputDecoration(
      //       // labelText: "Search Friend By Mobile No.",
      //       hintText: "Search Friend By Mobile No.",
      //       prefixIcon: Icon(
      //         Icons.search,
      //         color: Colors.white,
      //       ),
      //       suffixIcon: editingController.text.length > 0
      //           ? IconButton(
      //               icon: Icon(
      //                 Icons.clear,
      //                 color: Colors.white,
      //               ),
      //               onPressed: () async {
      //                 editingController.text = '';
      //                 getFriendData();
      //                 await EasyLoading.dismiss();
      //               },
      //             )
      //           : null,
      //       // border: OutlineInputBorder(
      //       //     borderRadius: BorderRadius.all(Radius.circular(25.0)))
      //     ),
      //   ),
      // ),
      ,
      backgroundColor: Colors.blueAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.length > 9) {
                  getFriendData();
                } else {
                  getFriendData();
                }
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search Friend By Mobile No.",
                  hintText: "Search Friend By Mobile No.",
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: editingController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                          ),
                          onPressed: () async {
                            editingController.text = '';
                            getFriendData();
                            await EasyLoading.dismiss();
                          },
                        )
                      : null,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),
          Expanded(child: _populateListView()),
        ],
      ),
      floatingActionButton: _selected.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                if (widget.roomId == '') {
                  _displayTextInputDialog(context);
                } else {
                  await EasyLoading.show();
                  var inviteResult = await chatRoomRepo.addMemberToGroup(
                      editingController.text, widget.roomId);

                  if (inviteResult.data != null &&
                      inviteResult.data.length > 0) {
                    InviteRoomResponse inviteRoomResponse =
                        inviteResult.data[0];
                    if (!context.mounted) return;
                    await context.read<SocketClientHelper>().loginUserRoom();
                    String? userId = await localStorage.getUserId();
                    String? userName = await localStorage.getNickName();

                    // _selected.forEach((memberByPhoneResponse) async {
                    //   await dbHelper.updateRoomMemberStatus(
                    //       memberByPhoneResponse.userId, "false", widget.roomId);
                    // });
                    List<RoomMembers> roomMembers =
                        await dbHelper.getRoomMembersList(widget.roomId);
                    for (var memberByPhoneResponse in _selected) {
                      await dbHelper.updateRoomMemberStatus(
                          memberByPhoneResponse.userId, "false", widget.roomId);

                      for (var roomMember in roomMembers) {
                        if (userId != roomMember.userId) {
                          var groupJson = {
                            "notifiedRoomId": widget.roomId,
                            "notifiedUserId": roomMember.userId,
                            "title":
                                '${userName!} added ${memberByPhoneResponse.name!}',
                            "description":
                                "${memberByPhoneResponse.userId!} just joined the room_${widget.roomId}"
                          };
                          //print(messageJson);
                          socket.emitWithAck('sendNotification', groupJson,
                              ack: (data) async {
                            //print(data);
                          });
                        }
                      }

                      String clientMessageId = generateRandomString(15);
                      String caUid = await localStorage.getCaUid() ?? '';
                      String deviceId =
                          await localStorage.getLoginDeviceId() ?? '';
                      MessageDetails messageDetails = MessageDetails(
                          roomId: widget.roomId,
                          userId: userId,
                          appId: appConfig.appId,
                          caUid: caUid,
                          deviceId: deviceId,
                          msgBody:
                              '${userName!} added ${memberByPhoneResponse.name!}',
                          msgBinary: '',
                          msgBinaryType: 'userJoined',
                          replyToId: -1,
                          messageId: 0,
                          readBy: '',
                          status: '',
                          statusMsg: '',
                          deleted: 0,
                          sendDateTime: DateFormat("yyyy-MM-dd HH:mm:ss")
                              .format(DateTime.now().toLocal())
                              .toString(),
                          editDateTime: '',
                          deleteDateTime: '',
                          transtamp: '',
                          nickName: userName,
                          filePath: '',
                          ownerId: userId,
                          msgStatus: 'SENT',
                          clientMessageId: clientMessageId,
                          roomName: '');
                      await dbHelper.saveMsgDetailTable(messageDetails);
                      if (!context.mounted) return;
                      context
                          .read<ChatHistory>()
                          .addChatHistory(messageDetail: messageDetails);
                      context.read<RoomHistory>().updateRoomMessage(
                          roomId: messageDetails.roomId!,
                          message: messageDetails.msgBody!);

                      var messageJson = {
                        "roomId": widget.roomId,
                        "msgBody":
                            '$userName added ${memberByPhoneResponse.name!}',
                        "msgBinaryType": 'userJoined',
                        "replyToId": -1,
                        "clientMessageId": clientMessageId,
                        "misc":
                            "[FCM_Notification=title: ${inviteRoomResponse.roomName} - $userName]"
                      };

                      socket.emitWithAck('sendMessage', messageJson,
                          ack: (data) async {
                        if (data != null) {
                          //print('sendMessage from server $data');
                        } else {
                          //print("Null from sendMessage");
                        }
                      });
                    }

                    await EasyLoading.dismiss();
                    if (!context.mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatHome2(
                                  roomId: inviteRoomResponse.roomId!,
                                  picturePath: '',
                                  roomName: inviteRoomResponse.roomName!,
                                  roomDesc: 'Group Chat',
                                  // roomMembers: members,
                                ))).then((_) {});
                  } else {
                    await EasyLoading.dismiss();
                    final customDialog = CustomDialog();
                    if (!context.mounted) return;
                    return customDialog.show(
                      context: context,
                      type: DialogType.error,
                      content: inviteResult.message!,
                      onPressed: () => Navigator.pop(context),
                    );
                  }
                }
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.check_circle),
            )
          : null,
    );
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

  doMultiSelectionItem(MemberByPhoneResponse memberByPhoneResponse) {
    if (isMultiSelectionEnabled) {
      if (_selected.contains(memberByPhoneResponse)) {
        _selected.remove(memberByPhoneResponse);
      } else {
        _selected.add(memberByPhoneResponse);
      }
      setState(() {
        _selected = _selected;
      });
    }
  }

  getFriendData() async {
    if (editingController.text.length > 9) {
      await EasyLoading.show();
      var result =
          await chatRoomRepo.getMemberByPhoneNumber(editingController.text);
      if (result.data != null && result.data.length > 0) {
        MemberByPhoneResponse inviteFriendResponse = result.data[0];
        if (memberByPhoneResponseList
            .where((element) => element.userId == inviteFriendResponse.userId)
            .toList()
            .isEmpty) {
          memberByPhoneResponseList.add(result.data[0]);
        }
        setState(() {
          memberByPhoneResponseList = memberByPhoneResponseList;
        });
        await EasyLoading.dismiss();
      }
    } else {
      setState(() {});
    }
  }

  Widget _populateListView() {
    return memberByPhoneResponseList.isNotEmpty
        ? ListView.builder(
            itemCount: memberByPhoneResponseList.length,
            itemBuilder: (context, int index) {
              MemberByPhoneResponse inviteFriendResponse =
                  memberByPhoneResponseList[index];
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
                            offset: const Offset(0, 2),
                            blurRadius: 5)
                      ],
                    ),
                    child: FullScreenWidget(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: inviteFriendResponse.picturePath != null
                              ? Image.network(inviteFriendResponse.picturePath!
                                  .replaceAll(removeBracket, '')
                                  .split('\r\n')[0])
                              : const Icon(Icons.account_circle),
                        ),
                      ),
                    ),
                  ),
                  trailing: Visibility(
                      visible: isMultiSelectionEnabled,
                      child: Icon(
                        _selected.contains(memberByPhoneResponseList[index])
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 30,
                        color: Colors.blue,
                      )),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(inviteFriendResponse.nickName ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(inviteFriendResponse.phone!),
                  onLongPress: () {
                    isMultiSelectionEnabled = true;
                    doMultiSelectionItem(inviteFriendResponse);
                  },
                  onTap: () async {
                    isMultiSelectionEnabled = true;
                    doMultiSelectionItem(inviteFriendResponse);
                  },
                ),
              );
            })
        : const Text('');
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Group Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Group Name"),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                child: const Text('OK'),
                onPressed: () async {
                  await EasyLoading.show();
                  String usersList = "";
                  if (_selected.length > 1) {
                    usersList =
                        [for (var user in _selected) user.phone].join(",");
                  } else {
                    usersList = _selected[0].phone!;
                  }
                  var inviteResult =
                      await chatRoomRepo.createNewGroup(usersList, valueText);

                  if (inviteResult.data != null &&
                      inviteResult.data.length > 0) {
                    InviteRoomResponse inviteRoomResponse =
                        inviteResult.data[0];
                    Room room = Room(
                        id: inviteRoomResponse.iD,
                        roomId: inviteRoomResponse.roomId,
                        merchantUserId: inviteRoomResponse.merchantUserId,
                        merchantLoginId: inviteRoomResponse.merchantLoginId,
                        merchantNickName: inviteRoomResponse.merchantNickName,
                        userId: inviteRoomResponse.userId,
                        loginId: inviteRoomResponse.loginId,
                        memberNickName: inviteRoomResponse.memberNickName,
                        roomDesc: inviteRoomResponse.roomDesc,
                        roomName: inviteRoomResponse.roomName,
                        createUser: inviteRoomResponse.createUser,
                        createDate: inviteRoomResponse.createDate,
                        editUser: inviteRoomResponse.editUser,
                        editDate: inviteRoomResponse.editDate,
                        rowKey: inviteRoomResponse.rowKey,
                        transtamp: inviteRoomResponse.transtamp,
                        deleted: inviteRoomResponse.deleted,
                        photoFileName: '',
                        profilePhoto: '',
                        merchantNo: inviteRoomResponse.merchantNo,
                        picturePath: inviteRoomResponse.picturePath);
                    await dbHelper.saveRoomTable(room);
                    RoomHistoryModel roomHistoryModel = RoomHistoryModel(
                        roomId: inviteRoomResponse.roomId ?? '',
                        roomName: inviteRoomResponse.roomName ?? '',
                        roomDesc: inviteRoomResponse.roomDesc ?? '',
                        picturePath: inviteRoomResponse.picturePath ?? '');
                    if (!context.mounted) return;
                    context.read<RoomHistory>().addRoom(room: roomHistoryModel);
                    //print('Room Insert value ' + val.toString());
                    var resultMembers = await chatRoomRepo
                        .getRoomMembersList(inviteRoomResponse.roomId!);
                    //print('roomMembers' + resultMembers.data.length.toString());
                    if (resultMembers.data != null &&
                        resultMembers.data.length > 0) {
                      for (int i = 0; i < resultMembers.data.length; i += 1) {
                        await dbHelper
                            .saveRoomMembersTable(resultMembers.data[i]);

                        if (i == resultMembers.data.length - 1) {
                          String? userId = await localStorage.getUserId();
                          String? caUid = await localStorage.getCaUid();
                          String? caPwd = await localStorage.getCaPwd();
                          String? deviceId =
                              await localStorage.getLoginDeviceId();
                          var messageJson = {
                            "roomId": inviteRoomResponse.roomId!,
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
                            } else {
                              //print("Null from login user");
                            }
                          });

                          //await context.read<SocketClientHelper>().loginUserRoom();
                          List<RoomMembers> roomMembers = await dbHelper
                              .getRoomMembersList(inviteRoomResponse.roomId!);
                          for (var roomMember in roomMembers) {
                            if (userId != roomMember.userId) {
                              var inviteUserToRoomJson = {
                                "invitedRoomId": inviteRoomResponse.roomId!,
                                "invitedUserId": roomMember.userId
                              };
                              socket.emitWithAck(
                                  'inviteUserToRoom', inviteUserToRoomJson,
                                  ack: (data) async {
                                //print('inviteUserToRoom ack $data');
                                if (data != null) {
                                  //print('inviteUserToRoom from server $data');
                                } else {
                                  //print("Null from inviteUserToRoom");
                                }
                              });
                            }
                          }
                          await EasyLoading.dismiss();
                          setState(() {
                            Navigator.of(context).pop();
                          });
                          if (!context.mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChatHome2(
                                        roomId: inviteRoomResponse.roomId!,
                                        picturePath: '',
                                        roomName: inviteRoomResponse.roomName!,
                                        roomDesc: 'Group Chat',
                                      ))).then((_) {});
                        }
                      }
                    }
                  } else {
                    await EasyLoading.dismiss();
                    final customDialog = CustomDialog();
                    if (!context.mounted) return;
                    return customDialog.show(
                      context: context,
                      type: DialogType.error,
                      content: inviteResult.message!,
                      onPressed: () => Navigator.pop(context),
                    );
                  }
                },
              ),
            ],
          );
        });
  }
}
