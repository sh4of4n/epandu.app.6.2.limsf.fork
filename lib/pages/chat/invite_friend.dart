import 'package:auto_route/auto_route.dart';
import 'package:epandu/pages/chat/chatnotification_count.dart';
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
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
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../router.gr.dart';

@RoutePage(name: 'inviteFriend')
class InviteFriend extends StatefulWidget {
  const InviteFriend({
    super.key,
    required this.roomId,
  });
  final String roomId; //lowerCamelCase

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  late io.Socket socket;
  bool isMultiSelectionEnabled = true;
  final appConfig = AppConfig();
  //TextEditingController _textFieldController = TextEditingController();
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
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: editingController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            editingController.text = '';
                            getFriendData();
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
      // floatingActionButton: memberByPhoneResponseList.length == 1
      //     ? FloatingActionButton(
      //         onPressed: () async {
      //           await EasyLoading.show();

      //           var inviteResult = await chatRoomRepo
      //               .chatWithMember(memberByPhoneResponseList[0].phone!);

      //           if (inviteResult.data != null && inviteResult.data.length > 0) {
      //             InviteRoomResponse inviteRoomResponse = inviteResult.data[0];

      //             Room room = Room(
      //                 id: inviteRoomResponse.iD,
      //                 roomId: inviteRoomResponse.roomId,
      //                 merchantUserId: inviteRoomResponse.merchantUserId,
      //                 merchantLoginId: inviteRoomResponse.merchantLoginId,
      //                 merchantNickName: inviteRoomResponse.merchantNickName,
      //                 userId: inviteRoomResponse.userId,
      //                 loginId: inviteRoomResponse.loginId,
      //                 memberNickName: inviteRoomResponse.memberNickName,
      //                 roomDesc: inviteRoomResponse.roomDesc,
      //                 roomName: inviteRoomResponse.roomName,
      //                 createUser: inviteRoomResponse.createUser,
      //                 createDate: inviteRoomResponse.createDate,
      //                 editUser: inviteRoomResponse.editUser,
      //                 editDate: inviteRoomResponse.editDate,
      //                 rowKey: inviteRoomResponse.rowKey,
      //                 transtamp: inviteRoomResponse.transtamp,
      //                 deleted: inviteRoomResponse.deleted,
      //                 photoFilename: '',
      //                 profilePhoto: '',
      //                 merchantNo: inviteRoomResponse.merchantNo,
      //                 picturePath: inviteRoomResponse.picturePath);
      //             await dbHelper.saveRoomTable(room);
      //             RoomHistoryModel roomHistoryModel = RoomHistoryModel(
      //                 roomId: inviteRoomResponse.roomId ?? '',
      //                 roomName: inviteRoomResponse.roomName ?? '',
      //                 roomDesc: inviteRoomResponse.roomDesc ?? '',
      //                 picturePath: inviteRoomResponse.picturePath ?? '');
      //             if (!context.mounted) return;
      //             context.read<RoomHistory>().addRoom(room: roomHistoryModel);
      //             //print('Room Insert value ' + val.toString());
      //             var resultMembers = await chatRoomRepo
      //                 .getRoomMembersList(inviteRoomResponse.roomId!);
      //             //print('roomMembers' + resultMembers.data.length.toString());
      //             if (resultMembers.data != null &&
      //                 resultMembers.data.length > 0) {
      //               for (int i = 0; i < resultMembers.data.length; i += 1) {
      //                 await dbHelper
      //                     .saveRoomMembersTable(resultMembers.data[i]);
      //                 if (i == resultMembers.data.length - 1) {
      //                   String? userId = await localStorage.getUserId();
      //                   String? caUid = await localStorage.getCaUid();
      //                   String? caPwd = await localStorage.getCaPwd();
      //                   String? deviceId =
      //                       await localStorage.getLoginDeviceId();
      //                   var messageJson = {
      //                     "roomId": inviteRoomResponse.roomId!,
      //                     "userId": userId,
      //                     "appId": appConfig.appId,
      //                     "caUid": caUid,
      //                     "caPwd": caPwd,
      //                     "deviceId": deviceId
      //                   };
      //                   //print('login: $messageJson');
      //                   socket.emitWithAck('login', messageJson, ack: (data) {
      //                     if (data != null) {
      //                       //print('login user from server $data');
      //                     } else {
      //                       //print("Null from login user");
      //                     }
      //                   });

      //                   //await context.read<SocketClientHelper>().loginUserRoom();

      //                   List<RoomMembers> roomMembers = await dbHelper
      //                       .getRoomMembersList(inviteRoomResponse.roomId!);
      //                   for (var memberByPhoneResponse
      //                       in memberByPhoneResponseList) {
      //                     print(memberByPhoneResponse.userId);
      //                     for (var roomMember in roomMembers) {
      //                       if (userId != roomMember.userId) {
      //                         var inviteUserToRoomJson = {
      //                           "invitedRoomId": inviteRoomResponse.roomId!,
      //                           "invitedUserId": roomMember.userId
      //                         };
      //                         socket.emitWithAck(
      //                             'inviteUserToRoom', inviteUserToRoomJson,
      //                             ack: (data) {
      //                           if (data != null) {
      //                             //print('inviteUserToRoomJson from server $data');
      //                           } else {
      //                             //print("Null from inviteUserToRoomJson");
      //                           }
      //                         });
      //                       }
      //                     }
      //                   }
      //                   await EasyLoading.dismiss();
      //                   String? name = await localStorage.getName();
      //                   String splitRoomName = '';
      //                   if (inviteRoomResponse.roomName!.contains(',')) {
      //                     splitRoomName = name!.toUpperCase() !=
      //                             inviteRoomResponse.roomName!
      //                                 .split(',')[0]
      //                                 .toUpperCase()
      //                         ? inviteRoomResponse.roomName!.split(',')[0]
      //                         : inviteRoomResponse.roomName!.split(',')[1];
      //                   } else {
      //                     splitRoomName = room.roomName!;
      //                   }
      //                   if (!context.mounted) return;
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (_) => ChatHome2(
      //                                 roomId: inviteRoomResponse.roomId!,
      //                                 picturePath: '',
      //                                 roomName: splitRoomName,
      //                                 roomDesc: 'Private Chat',
      //                                 // roomMembers: '',
      //                               ))).then((_) {});
      //                 }
      //               }
      //             }
      //           } else {
      //             await EasyLoading.dismiss();
      //             final customDialog = CustomDialog();
      //             if (!context.mounted) return;
      //             customDialog.show(
      //               context: context,
      //               type: DialogType.error,
      //               content: Text(inviteResult.message!),
      //               onPressed: () => Navigator.pop(context),
      //             );
      //           }
      //         },
      //         backgroundColor: Colors.blue,
      //         child: const Icon(Icons.check_circle),
      //       )
      //     : null,
    );
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
      title: const Row(
        children: [
          Icon(
            Icons.person_add_outlined,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Chat With Friend'),
          ),
        ],
      )
      // title: TextField(
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) {
      //     if (value.length > 9) {
      //       getFriendData();
      //     } else {
      //       getFriendData();
      //     }
      //   },
      //   controller: editingController,
      //   decoration: InputDecoration(
      //     // labelText: "Search Friend By Mobile No.",
      //     hintText: "Search Friend By Mobile No.",
      //     hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
      //     prefixIcon: Icon(
      //       Icons.search,
      //       color: Colors.white,
      //     ),
      //     suffixIcon: editingController.text.length > 0
      //         ? IconButton(
      //             icon: Icon(
      //               Icons.clear,
      //               color: Colors.white,
      //             ),
      //             onPressed: () {
      //               editingController.text = '';
      //               getFriendData();
      //             },
      //           )
      //         : null,
      //     // border: OutlineInputBorder(
      //     //     borderRadius: BorderRadius.all(Radius.circular(25.0))
      //     //     )
      //   ),
      // ),
      ,
      backgroundColor: Colors.blueAccent,
    );
  }

  getFriendData() async {
    if (editingController.text.length > 9) {
      memberByPhoneResponseList = [];
      await EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
      );
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
      } else {
        await EasyLoading.dismiss();
        final customDialog = CustomDialog();
        if (!context.mounted) return;
        customDialog.show(
          context: context,
          type: DialogType.error,
          content: result.message!,
          onPressed: () => Navigator.pop(context),
        );
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
                  onTap: () async {
                    await EasyLoading.show(
                      maskType: EasyLoadingMaskType.black,
                    );

                    var inviteResult = await chatRoomRepo
                        .chatWithMember(memberByPhoneResponseList[0].phone!);

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
                          photoFilename: '',
                          profilePhoto: '',
                          merchantNo: inviteRoomResponse.merchantNo,
                          picturePath: inviteRoomResponse.picturePath);
                      await dbHelper.saveRoomTable(room);
                      RoomHistoryModel roomHistoryModel = RoomHistoryModel(
                          roomId: inviteRoomResponse.roomId ?? '',
                          roomName: inviteRoomResponse.roomName ?? '',
                          roomDesc: inviteRoomResponse.roomDesc ?? '',
                          picturePath: inviteRoomResponse.picturePath ?? '',
                          deleted: inviteRoomResponse.deleted ?? 'false');

                      if (!context.mounted) return;
                      List<RoomHistoryModel> roomHistoryList =
                          await Provider.of<RoomHistory>(context, listen: false)
                              .getRoomHistory();
                      if (roomHistoryList.isNotEmpty &&
                          roomHistoryList.indexWhere((element) =>
                                  element.roomId ==
                                  inviteRoomResponse.roomId!) >
                              -1) {
                        await dbHelper.updatedeleteStatusByRoomById(
                            inviteRoomResponse.roomId!, 'false');
                        if (!context.mounted) return;
                        context.read<RoomHistory>().updateRoomStatus(
                              roomId: inviteRoomResponse.roomId!,
                            );
                      }

                      if (!context.mounted) return;
                      context
                          .read<RoomHistory>()
                          .addRoom(room: roomHistoryModel);
                      context
                          .read<ChatNotificationCount>()
                          .addNotificationBadge(
                              notificationBadge: 0,
                              roomId: inviteRoomResponse.roomId!);
                      //print('Room Insert value ' + val.toString());
                      var resultMembers = await chatRoomRepo
                          .getRoomMembersList(inviteRoomResponse.roomId!);
                      //print('roomMembers' + resultMembers.data.length.toString());
                      if (resultMembers.data != null &&
                          resultMembers.data.length > 0) {
                        await dbHelper.batchInsertMembers(resultMembers.data);
                        for (int i = 0; i < resultMembers.data.length; i += 1) {
                          // await dbHelper
                          //     .saveRoomMembersTable(resultMembers.data[i]);
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
                            socket.emitWithAck('login', messageJson,
                                ack: (data) {
                              if (data != null && !data.containsKey("error")) {
                                //print('login user from server $data');
                              } else {
                                //print("Null from login user");
                              }
                            });

                            //await context.read<SocketClientHelper>().loginUserRoom();

                            List<RoomMembers> roomMembers = await dbHelper
                                .getRoomMembersList(inviteRoomResponse.roomId!);
                            for (var memberByPhoneResponse
                                in memberByPhoneResponseList) {
                              print(memberByPhoneResponse.userId);
                              for (var roomMember in roomMembers) {
                                if (userId != roomMember.userId) {
                                  var inviteUserToRoomJson = {
                                    "invitedRoomId": inviteRoomResponse.roomId!,
                                    "invitedUserId": roomMember.userId
                                  };
                                  socket.emitWithAck(
                                      'inviteUserToRoom', inviteUserToRoomJson,
                                      ack: (data) {
                                    if (data != null &&
                                        !data.containsKey("error")) {
                                      //print('inviteUserToRoomJson from server $data');
                                    } else {
                                      //print("Null from inviteUserToRoomJson");
                                    }
                                  });
                                }
                              }
                            }
                            await EasyLoading.dismiss();
                            String? name = await localStorage.getName();
                            String splitRoomName = '';
                            if (inviteRoomResponse.roomName!.contains(',')) {
                              splitRoomName = name!.toUpperCase() !=
                                      inviteRoomResponse.roomName!
                                          .split(',')[0]
                                          .toUpperCase()
                                  ? inviteRoomResponse.roomName!.split(',')[0]
                                  : inviteRoomResponse.roomName!.split(',')[1];
                            } else {
                              splitRoomName = room.roomName!;
                            }
                            if (!context.mounted) return;

                            context.router.replace(ChatRoom(
                                roomId: inviteRoomResponse.roomId!,
                                picturePath: '',
                                roomName: splitRoomName,
                                roomDesc: 'Private Chat',
                                isMessagesExist: false));

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => ChatRoom(
                            //               roomId: inviteRoomResponse.roomId!,
                            //               picturePath: '',
                            //               roomName: splitRoomName,
                            //               roomDesc: 'Private Chat',
                            //               // roomMembers: '',
                            //             ))).then((_) {});
                          }
                        }
                      }
                    } else {
                      await EasyLoading.dismiss();
                      final customDialog = CustomDialog();
                      if (!context.mounted) return;
                      customDialog.show(
                        context: context,
                        type: DialogType.error,
                        content: inviteResult.message!,
                        onPressed: () => Navigator.pop(context),
                      );
                    }
                  },
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
                          child: inviteFriendResponse.picturePath != null &&
                                  inviteFriendResponse.picturePath != ''
                              ? Image.network(inviteFriendResponse.picturePath!
                                  .replaceAll(removeBracket, '')
                                  .split('\r\n')[0])
                              : const Icon(Icons.account_circle),
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(inviteFriendResponse.nickName ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(inviteFriendResponse.phone!),
                ),
              );
            })
        : const Text('');
  }
}
