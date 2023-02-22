import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/invitefriend_model.dart';
import '../../common_library/services/model/inviteroom_response.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/custom_dialog.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'chat_home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class InviteFriend extends StatefulWidget {
  const InviteFriend({
    Key? key,
    required this.roomId,
  }) : super(key: key);
  final String roomId; //lowerCamelCase

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  late IO.Socket socket;
  bool isMultiSelectionEnabled = true;
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
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: editingController.text.length > 0
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              editingController.text = '';
                              getFriendData();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            Expanded(child: _populateListView()),
          ],
        ),
      ),
      floatingActionButton: memberByPhoneResponseList.length == 1
          ? FloatingActionButton(
              onPressed: () async {
                await EasyLoading.show();

                var inviteResult = await chatRoomRepo
                    .chatWithMember(memberByPhoneResponseList[0].phone!);

                if (inviteResult.data != null && inviteResult.data.length > 0) {
                  InviteRoomResponse inviteRoomResponse = inviteResult.data[0];
                  await context.read<SocketClientHelper>().loginUserRoom();

                  String? userId = await localStorage.getUserId();
                  //String? userName = await localStorage.getNickName();
                  List<RoomMembers> roomMembers = await dbHelper
                      .getRoomMembersList(inviteRoomResponse.roomId!);
                  memberByPhoneResponseList.forEach((memberByPhoneResponse) {
                    roomMembers.forEach((roomMember) {
                      if (userId != roomMember.user_id) {
                        var inviteUserToRoomJson = {
                          "invitedRoomId": inviteRoomResponse.roomId!,
                          "invitedUserId": roomMember.user_id
                        };
                        socket.emitWithAck(
                            'inviteUserToRoom', inviteUserToRoomJson,
                            ack: (data) {
                          if (data != null) {
                            print('inviteUserToRoomJson from server $data');
                          } else {
                            print("Null from inviteUserToRoomJson");
                          }
                        });
                      }
                    });
                  });
                  await EasyLoading.dismiss();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatHome2(
                                Room_id: inviteRoomResponse.roomId!,
                                picturePath: '',
                                roomName: inviteRoomResponse.roomName!,
                                roomDesc: 'Private Chat',
                                // roomMembers: '',
                              ))).then((_) {});
                } else {
                  await EasyLoading.dismiss();
                  final customDialog = CustomDialog();
                  return customDialog.show(
                    context: context,
                    type: DialogType.ERROR,
                    content: inviteResult.message!,
                    onPressed: () => Navigator.pop(context),
                  );
                }
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.check_circle),
            )
          : null,
    );
  }

  AppBar getAppBar(BuildContext context) {
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
      title: Row(
        children: [
          Icon(
            Icons.person_add_outlined,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
      await EasyLoading.show();
      var result =
          await chatRoomRepo.getMemberByPhoneNumber(editingController.text);
      if (result.data != null && result.data.length > 0) {
        MemberByPhoneResponse inviteFriendResponse = result.data[0];
        if (memberByPhoneResponseList
                .where(
                    (element) => element.userId == inviteFriendResponse.userId)
                .toList()
                .length ==
            0) {
          memberByPhoneResponseList.add(result.data[0]);
        }
        setState(() {
          memberByPhoneResponseList = memberByPhoneResponseList;
        });
        await EasyLoading.dismiss();
      } else {
        await EasyLoading.dismiss();
        final customDialog = CustomDialog();
        return customDialog.show(
          context: context,
          type: DialogType.ERROR,
          content: result.message!,
          onPressed: () => Navigator.pop(context),
        );
      }
    } else {
      setState(() {});
    }
  }

  Widget _populateListView() {
    return memberByPhoneResponseList.length > 0
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
                            offset: Offset(0, 2),
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
                              : Icon(Icons.account_circle),
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(inviteFriendResponse.nickName ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Text(inviteFriendResponse.phone!),
                ),
              );
            })
        : Text('');
  }
}
