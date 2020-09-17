import 'dart:convert';

import 'package:epandu/pages/chat/chat_bloc.dart';
import 'package:epandu/pages/chat/chat_sqlCRUD.dart';
// import 'package:epandu/pages/chat/message_item.dart';
import 'package:epandu/pages/chat/socket_helper.dart';
import 'package:epandu/pages/chat/user_chating_list_item.dart';
import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/services/repository/chat_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';

// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;
// import 'package:epandu/pages/chat/message_input.dart';
import 'package:epandu/services/api/model/chat_model.dart';

class ChatHomeScreen extends StatefulWidget {
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  Socket socket;
  User user = User();
  final LocalStorage localStorage = LocalStorage();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  final profileRepo = ProfileRepo();
  final chatRepo = ChatRepo();
  int _startIndex = 0;
  String _message = '';
  String selfId;
  TextEditingController _searchController;
  UserProfile _searchResult;
  String _searchText;
  bool _appearSearchButtonFlag = false;
  bool _appearSearchResultFlag = false;
  bool _searchFlag = false;

  @override
  void initState() {
    super.initState();
    _getUserChatList();
    _setSelfId();
    initSocketIO();

    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 10;
          });
          _getUserChatList();
        }
      });
  }

  final TextEditingController _textEditingController =
      new TextEditingController();

  List<UserProfile> userChat = [];

  _getUserChatList() async {
    String userId = await localStorage.getUserId();
    List<UserProfile> tempList = await DBHelper().getContactList(
        selfId: userId, startIndex: _startIndex, noOfRecords: 10);
    setState(() {
      userChat.addAll(tempList);
    });
    print("data retrieved ${userChat.length}");
  }

  _getUserProfile(String userId) async {
    var result =
        await profileRepo.getUserProfile(context: context, userId: userId);

    if (result.isSuccess) {
      if (result.data.length > 0) if (mounted)
        setState(() {
          _searchResult = result.data[0];
        });
      else if (mounted)
        setState(() {
          _isLoading = false;
        });
    } else {
      if (mounted)
        setState(() {
          _message = result.message;
          _isLoading = false;
        });
    }
  }

  _getUserProfileWithPhone(String phoneNumber) async {
    var result = await chatRepo.getUserProfileWithPhone(
        context: context, userPhone: phoneNumber);

    if (result.isSuccess) {
      print("result " + result.data[0].firstName);
      await _getUserProfile(result.data[0].userId);
    } else {
      if (mounted)
        setState(() {
          _searchResult = null;

          _message = result.message;
          _isLoading = false;
        });
    }
  }

  initSocketIO() async {
    String userId = await localStorage.getUserId();
    setState(() {
      SocketHelper().socket.then((value) {
        socket = value;
        socket.emit("initHomeScreen", userId);
      });
    });
    print("connected");
  }

  _setSelfId() async {
    String userId = await localStorage.getUserId();
    setState(() {
      this.selfId = userId;
    });
  }

  _addNewUserIntoDB(
      {UserProfile friendProfile,
      String friendId,
      bool getUserProfileFromServerflag}) async {
    String selfId = await localStorage.getUserId();
    var uuid = Uuid();
    String id1 = uuid.v4();
    _getSingleUserFromContact(friendId).then((value) async {
      if (value == null) {
        if (getUserProfileFromServerflag == true) {
          print("getUserProfileFromServerflag true");
          await _getUserProfile(friendId);
          if (await DBHelper().saveTable4(id1, selfId, _searchResult.userId) ==
                  1 &&
              await DBHelper().saveTable3(_searchResult) == 1) {
            print("contact saved");
            setState(() {
              _searchFlag = false;
              _appearSearchResultFlag = false;
              _getUserChatList();
            });
          }
        } else {
          print("getUserProfileFromServerflag false");
          DBHelper().saveTable3(friendProfile).then((value) async {
            if (value == 1) {
              print(friendProfile.userId);
              if (await DBHelper()
                      .saveTable4(id1, selfId, friendProfile.userId) ==
                  1) {
                print("contact saved");
                setState(() {
                  _searchFlag = false;
                  _appearSearchResultFlag = false;
                  _getUserChatList();
                });
              }
            }
          });
        }
      }
    });
  }

  _getSingleUserFromContact(String friendId) async {
    String selfId = await localStorage.getUserId();
    UserProfile user =
        await DBHelper().getSingleContact(selfId: selfId, friendId: friendId);
    return user;
  }

  _getSingleUserFromLocalStorage(String friendId) async {
    UserProfile user = await DBHelper().getSingleUser(userId: friendId);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            textTheme:
                Theme.of(context).textTheme.apply(bodyColor: Colors.black45),
            iconTheme: IconThemeData(color: Colors.black45),
            title: _addContact(),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    if (_searchFlag == true) {
                      _searchResult = null;
                      _appearSearchResultFlag = false;
                      _searchFlag = false;
                    } else {
                      _searchFlag = true;
                    }
                  });
                },
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.green,
            child: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 7.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.message, color: Colors.black45),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.view_list, color: Colors.black45),
                  onPressed: () {},
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.call, color: Colors.black45),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.person_outline, color: Colors.black45),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          body: Provider.value(
              value: socket,
              child: ProxyProvider<Socket, ChatBloc>(
                update: (context, socket, previousBloc) {
                  return ChatBloc(Provider.of<Socket>(context));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(80.w, 50.h, 80.w, 50.h),
                  child: Column(
                    children: <Widget>[
                      _searchResultBox(),
                      Expanded(
                        child: Consumer<ChatBloc>(
                          builder: (context, bloc, _) => StreamProvider.value(
                            initialData: null,
                            value: bloc.chatItemsStream,
                            child: Consumer<String>(
                              builder: (context, msg, _) {
                                //print("message receive call");

                                if (msg != null) {
                                  print("message receive call");

                                  Message message =
                                      Message.fromJson(jsonDecode(msg));

                                  _getSingleUserFromLocalStorage(message.author)
                                      .then((value) {
                                    if (value == null) {
                                      print("the contact did not exist be4");
                                      socket.emit(
                                          "acknowledgementReceiveHomeScreen",
                                          msg);

                                      userChat.clear();
                                      _startIndex = 0;
                                      _addNewUserIntoDB(
                                          friendId: message.author,
                                          getUserProfileFromServerflag: true);
                                    }
                                  });
                                }

                                print("data display flow 1");

                                return SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    children: <Widget>[
                                      _userChatList(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  _userChatList() {
    print("data display flow 2");

    if (userChat.length == 0 && userChat.isNotEmpty) {
      return Center(
        child: Text("empty messages"),
      );
    } else if (userChat.length > 0) {
      return Column(
        children: <Widget>[
          for (int i = 0; i < userChat.length; i++)
            UserChatListItem(userChat: userChat[i]),
        ],
      );
    }
    return Center(
        child: Container(
            child: Align(
      alignment: Alignment.center,
      child: Text("Empty Contact List"),
    )));
  }

  _loadingShimmer({int length}) {
    return Container(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: length ?? 4,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: Container(
                    width: ScreenUtil().setWidth(1400),
                    height: ScreenUtil().setHeight(600),
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _addContact() {
    if (_searchFlag == true) {
      return TextFormField(
        controller: _searchController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: new InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          hintText: "Phone Number",
          suffixIcon: _searchButton(),
        ),
        onChanged: (value) {
          if (value.length > 0) {
            setState(() {
              _searchText = value;
              _appearSearchButtonFlag = true;
            });
          } else {
            setState(() {
              _searchText = value;
              _appearSearchButtonFlag = false;
            });
          }
        },
      );
    } else {
      return Text("Chat");
    }
  }

  _searchButton() {
    if (_appearSearchButtonFlag == true) {
      return IconButton(
          onPressed: () {
            setState(() {
              _appearSearchResultFlag = true;
              _getUserProfileWithPhone(_searchText);
            });
          },
          icon: Icon(
            Icons.search,
          ));
    } else {
      return null;
    }
  }

  _searchResultBox() {
    if (_appearSearchResultFlag == true) {
      if (_searchResult == null) {
        return Container(
          width: 1350.w,
          padding: const EdgeInsets.all(15.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: Row(
            children: <Widget>[
              Text("No Result Found", style: TextStyle(fontSize: 60.sp)),
            ],
          ),
        );
      } else {
        return Container(
          width: 1350.w,
          padding: const EdgeInsets.all(5.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: Row(
            children: <Widget>[
              Text(_searchResult.name, style: TextStyle(fontSize: 60.sp)),
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  userChat.clear();
                  _startIndex = 0;

                  _addNewUserIntoDB(
                      friendProfile: _searchResult,
                      friendId: "",
                      getUserProfileFromServerflag: false);
                },
              ),
            ],
          ),
        );
      }
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    /*
    socket.emit("cancelConnectionHomePage", selfId);
    print("dispose " + selfId);
    socket.disconnect();
    socket.destroy(); */
    super.dispose();
  }
}
