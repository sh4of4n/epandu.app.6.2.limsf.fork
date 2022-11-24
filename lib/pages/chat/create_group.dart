import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/invitefriend_model.dart';
import '../../common_library/services/model/inviteroom_response.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/custom_dialog.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'chat_home.dart';
import 'socketclient_helper.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    Key? key,
    required this.roomId,
  }) : super(key: key);
  final String roomId; //lowerCamelCase

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  bool isMultiSelectionEnabled = true;
  TextEditingController _textFieldController = TextEditingController();
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
          },
        ),
        title: Text('Invite Friend To Group'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(child: _populateListView()),
          ],
        ),
      ),
      floatingActionButton: _selected.length > 0
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
                    await context.read<SocketClientHelper>().loginUserRoom();
                    // String members = '';
                    // List<RoomMembers> roomMembers = await dbHelper
                    //     .getRoomMembersList(inviteRoomResponse.roomId!);
                    // for (var roomMembers in roomMembers) {
                    //   if (roomMembers.user_id != inviteRoomResponse.userId!)
                    //     members += roomMembers.nick_name!.toUpperCase() + ",";
                    // }
                    // members = members.substring(0, members.length - 1);
                    await EasyLoading.dismiss();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatHome2(
                                  Room_id: inviteRoomResponse.roomId!,
                                  picturePath: '',
                                  roomName: inviteRoomResponse.roomName!,
                                  roomDesc: 'Group Chat',
                                  // roomMembers: members,
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
                }
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.check_circle),
            )
          : null,
    );
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
                          style: TextStyle(fontWeight: FontWeight.bold)),
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
        : Container(child: Text('No friends found'));
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Group Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Group Name"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
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
                    await context.read<SocketClientHelper>().loginUserRoom();
                    // String members = '';
                    // List<RoomMembers> roomMembers = await dbHelper
                    //     .getRoomMembersList(inviteRoomResponse.roomId!);
                    // for (var roomMembers in roomMembers) {
                    //   if (roomMembers.user_id != inviteRoomResponse.userId!)
                    //     members += roomMembers.nick_name!.toUpperCase() + ",";
                    // }
                    // members = members.substring(0, members.length - 1);
                    await EasyLoading.dismiss();
                    setState(() {
                      Navigator.of(context).pop();
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatHome2(
                                  Room_id: inviteRoomResponse.roomId!,
                                  picturePath: '',
                                  roomName: inviteRoomResponse.roomName!,
                                  roomDesc: 'Group Chat',
                                  // roomMembers: members,
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
              ),
            ],
          );
        });
  }
}
