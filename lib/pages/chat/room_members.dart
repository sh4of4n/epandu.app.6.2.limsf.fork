import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:provider/provider.dart';
import '../../common_library/services/model/checkonline_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/repository/auth_repository.dart';
import '../../common_library/utils/local_storage.dart';
import '../../services/database/DatabaseHelper.dart';
import '../../services/repository/chatroom_repository.dart';
import 'chat_home.dart';
import 'online_users.dart';

class RoomMembersList extends StatefulWidget {
  const RoomMembersList({
    Key? key,
    required this.Room_name,
    required this.Room_id,
    required this.userId,
    required this.picturePath,
    required this.roomName,
    required this.roomDesc,
    // required this.roomMembers
  }) : super(key: key);
  final String Room_name;
  final String Room_id;
  final String userId;
  final String picturePath;
  final String roomName;
  final String roomDesc;
  // final String roomMembers;
  @override
  _RoomMembersListState createState() => _RoomMembersListState();
}

class _RoomMembersListState extends State<RoomMembersList> {
  final chatRoomRepo = ChatRoomRepo();
  bool _isRoomMemberSearching = false;
  bool loading = true;
  String? profilePicUrl = '';
  final RegExp removeBracket =
      RegExp("\\[(.*?)\\]", multiLine: true, caseSensitive: true);
  TextEditingController editingController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  final authRepo = AuthRepo();
  final LocalStorage localStorage = LocalStorage();
  List<RoomMembers> roomMembers = [];
  List<CheckOnline> onlineUsersList = [];
  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback(statusCallback);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      profilePicUrl = await localStorage.getProfilePic();
    });

    _updateListview();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    onlineUsersList = context.watch<OnlineUsers>().getOnlineList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppbar(context),
        body: Container(
          child: Column(
            children: [
              // if (widget.roomDesc.toUpperCase().contains("GROUP"))
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: TextField(
              //       onChanged: (value) {
              //         _updateListview();
              //       },
              //       controller: editingController,
              //       decoration: InputDecoration(
              //           labelText: "Search",
              //           hintText: "Search",
              //           prefixIcon: Icon(Icons.search),
              //           suffixIcon: editingController.text.length > 0
              //               ? IconButton(
              //                   // Icon to
              //                   icon: Icon(Icons.clear), // clear text
              //                   onPressed: () {
              //                     editingController.text = '';
              //                     _updateListview();
              //                   },
              //                 )
              //               : null,
              //           border: OutlineInputBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(25.0)))),
              //     ),
              //   ),
              Expanded(child: _populateListView()),
            ],
          ),
        ));
  }

  _updateListview() async {
    await EasyLoading.show();
    roomMembers = await dbHelper.getRoomMembersList(widget.Room_id);
    if (!widget.roomDesc.toUpperCase().contains("GROUP")) {
      roomMembers.removeWhere((element) => element.user_id == widget.userId);
    }
    setState(() {
      roomMembers = roomMembers;
    });
    await EasyLoading.dismiss();
  }

  _owncircleImage() {
    if (profilePicUrl != null && profilePicUrl!.isNotEmpty)
      return Image.network(
          profilePicUrl!.replaceAll(removeBracket, '').split('\r\n')[0]);
    return Icon(Icons.account_circle);
  }

  _othersCircleImage(String picturePath) {
    if (picturePath.isNotEmpty)
      return Image.network(
          picturePath.replaceAll(removeBracket, '').split('\r\n')[0]);
    return Icon(Icons.account_circle);
  }

  getAppbar(BuildContext context) {
    if (!_isRoomMemberSearching) {
      return AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isRoomMemberSearching = true;
                });
              }),
        ],
        backgroundColor: Colors.blueAccent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: Colors.white,
            //       width: 3,
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.grey.withOpacity(.3),
            //           offset: Offset(0, 2),
            //           blurRadius: 5)
            //     ],
            //   ),
            //   child: Container(
            //     width: 40,
            //     height: 40,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(
            //         color: Colors.white,
            //         width: 3,
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //             color: Colors.grey.withOpacity(.3),
            //             offset: Offset(0, 2),
            //             blurRadius: 5)
            //       ],
            //     ),
            //     child: FullScreenWidget(
            //       child: Center(
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(8.0),
            //           child: widget.picturePath != ''
            //               ? Image.network(widget.picturePath
            //                   .replaceAll(removeBracket, '')
            //                   .split('\r\n')[0])
            //               : Icon(Icons.account_circle),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 200.0,
                  child: Text(
                    widget.Room_name + ' - ' + 'Members List',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
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
              _isRoomMemberSearching = false;
            });
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: TextField(
          controller: editingController,
          autofocus: true,
          onChanged: (value) {
            _updateListview();
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Search RoomMember",
              hintStyle: TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  ListView _populateListView() {
    return ListView.builder(
      itemCount: roomMembers.length,
      itemBuilder: (context, int index) {
        RoomMembers roomMembers = this.roomMembers[index];
        if (editingController.text.isEmpty) {
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
                      child: roomMembers.user_id == widget.userId
                          ? _owncircleImage()
                          : _othersCircleImage(roomMembers.picture_path ?? ''),
                    ),
                  ),
                ),
              ),
              title: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  onlineUsersList.any(
                          (element) => element.userId == roomMembers.user_id)
                      ? Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 15,
                        )
                      : Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 15,
                        ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatHome2(
                            Room_id: widget.Room_id,
                            picturePath: widget.picturePath,
                            roomName: widget.roomName,
                            roomDesc: widget.roomDesc,
                            // roomMembers: widget.roomMembers,
                          ),
                        ),
                      );
                    },
                    child: Text(roomMembers.nick_name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              subtitle: Text(roomMembers.login_id!),
            ),
          );
        } else if (roomMembers.nick_name
                ?.toLowerCase()
                .contains(editingController.text) ==
            true) {
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
                      child: roomMembers.user_id == widget.userId
                          ? _owncircleImage()
                          : _othersCircleImage(roomMembers.picture_path ?? ''),
                    ),
                  ),
                ),
              ),
              title: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  onlineUsersList.any(
                          (element) => element.userId == roomMembers.user_id)
                      ? Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 15,
                        )
                      : Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 15,
                        ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatHome2(
                            Room_id: widget.Room_id,
                            picturePath: widget.picturePath,
                            roomName: widget.roomName,
                            roomDesc: widget.roomDesc,
                            // roomMembers: widget.roomMembers,
                          ),
                        ),
                      );
                    },
                    child: Text(roomMembers.nick_name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              subtitle: Text(roomMembers.login_id!),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
