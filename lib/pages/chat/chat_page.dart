import 'dart:convert';
import 'dart:io';
import 'package:epandu/pages/chat/chat_bloc.dart';
import 'package:epandu/services/database/chat_db.dart';
import 'package:epandu/pages/chat/socket_helper.dart';
import 'package:epandu/pages/chat/contact_list.dart';
import 'package:epandu/services/api/model/profile_model.dart';
import 'package:epandu/services/repository/auth_repository.dart';
import 'package:epandu/services/repository/profile_repository.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';
import 'package:epandu/services/api/model/chat_model.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  final profileRepo = ProfileRepo();
  final authRepo = AuthRepo();
  final LocalStorage localStorage = LocalStorage();
  Socket socket;
  User user = User();
  ScrollController _scrollController = ScrollController();
  int _startIndex = 0;
  UserProfile _searchResult;
  String _message = '';
  String userId = '';
  bool _isLoading = false;
  bool _searchFlag = false;
  List<UserProfile> contactList = [];

  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _getUserId();
    initSocketIO();

    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _startIndex += 10;
          });
          _getContactList();
        }
      });
  }

  @override
  void dispose() {
    /*
    socket.emit("cancelConnectionHomePage", userId);
    print("dispose " + userId);
    socket.disconnect();
    socket.destroy(); */
    _searchFocus.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  _getUserId() async {
    String userId = await localStorage.getUserId();

    setState(() {
      this.userId = userId;
    });

    _getContactList();
  }

  _getContactList() async {
    List<UserProfile> tempList = await ChatDatabase().getContactList(
        userId: userId, startIndex: _startIndex, noOfRecords: 10);
    setState(() {
      contactList.addAll(tempList);
    });
    // print("data retrieved ${contactList.length}");
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

  Future<dynamic> _getUserByUserPhone(String phoneNumber) async {
    var result = await authRepo.getUserByUserPhone(
        context: context, phone: phoneNumber, scenario: 'CHAT');

    if (result.isSuccess) {
      await _getUserProfile(result.data[0].userId);
      return result.data;
    }

    if (mounted)
      setState(() {
        _searchResult = null;

        _message = result.message;
        // _isLoading = false;
      });

    return null;
  }

  initSocketIO() async {
    String userId = await localStorage.getUserId();
    setState(() {
      SocketHelper().socket.then((value) {
        socket = value;
        socket.emit("initHomeScreen", userId);
      });
    });
    // print("connected");
  }

  _addNewUserIntoDB({
    UserProfile friendProfile,
    String friendId,
    bool getUserProfileFromServerflag,
  }) async {
    String userId = await localStorage.getUserId();
    var uuid = Uuid();
    String id1 = uuid.v4();
    _getSingleUserFromContact(friendId).then((value) async {
      if (value == null) {
        if (getUserProfileFromServerflag == true) {
          // print("getUserProfileFromServerflag true");
          await _getUserProfile(friendId);
          if (await ChatDatabase().saveRelationshipTable(
                      id1, userId, _searchResult.userId) ==
                  1 &&
              await ChatDatabase().saveUserTable(_searchResult) == 1) {
            print("contact saved");
            setState(() {
              _searchFlag = false;
              // _appearSearchResultFlag = false;
              _getContactList();
            });
          }
        } else {
          // print("getUserProfileFromServerflag false");
          ChatDatabase().saveUserTable(friendProfile).then((value) async {
            if (value == 1) {
              print(friendProfile.userId);
              if (await ChatDatabase().saveRelationshipTable(
                      id1, userId, friendProfile.userId) ==
                  1) {
                // print("contact saved");
                setState(() {
                  _searchFlag = false;
                  // _appearSearchResultFlag = false;
                  _getContactList();
                });
              }
            }
          });
        }
      }
    });
  }

  _getSingleUserFromContact(String friendId) async {
    String userId = await localStorage.getUserId();
    UserProfile user = await ChatDatabase()
        .getSingleContact(userId: userId, friendId: friendId);
    return user;
  }

  _getSingleUserFromLocalStorage(String friendId) async {
    UserProfile user = await ChatDatabase().getSingleUser(userId: friendId);
    return user;
  }

  _contactList() {
    if (contactList.length > 0) {
      return Column(
        children: <Widget>[
          for (int i = 0; i < contactList.length; i++)
            ContactList(contactList: contactList[i]),
        ],
      );
    }
    return Center(
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text("Add contacts now to start chatting."),
        ),
      ),
    );
  }

  _searchContact() {
    return TypeAheadField(
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: _searchFocus,
        keyboardType: TextInputType.phone,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Phone Number',
          // hintStyle: TextStyle(
          //   color: primaryColor,
          // ),
          suffixIcon: _clearButton(),
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.length >= 10) {
          var result = await _getUserByUserPhone(pattern);

          if (result != null) {
            return List.generate(result.length, (index) {
              return {
                'phone': result[index].phone,
                'nick_name': result[index].nickName,
              };
            });
          }
        }
        return null;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion['phone']),
          subtitle: Text(suggestion['nick_name']),
        );
      },
      onSuggestionSelected: (suggestion) async {
        if (contactList.length == 0) {
          _addNewUserIntoDB(
              friendProfile: _searchResult,
              friendId: "",
              getUserProfileFromServerflag: false);
        } else {
          for (int i = 0; i < contactList.length; i += 1) {
            if (contactList[i].phone.contains(suggestion['phone'])) {
              break;
            } else if (i + 1 == contactList.length &&
                contactList[i].phone.contains(suggestion['phone']) == false) {
              contactList.clear();
              _addNewUserIntoDB(
                  friendProfile: _searchResult,
                  friendId: "",
                  getUserProfileFromServerflag: false);
            }
          }
        }
        /* contactList.map((contact) {
          if (contact.phone.contains(suggestion['phone'])) {}
        }); */
      },
    );
  }

  _clearButton() {
    if (_searchController.text.isNotEmpty) {
      return IconButton(
        onPressed: () {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _searchController.clear());
        },
        icon: Icon(Icons.close),
      );
    }
  }

  /* _loadingShimmer({int length}) {
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
  } */

  searchAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Platform.isAndroid
            ? Icon(Icons.arrow_back)
            : Icon(Icons.arrow_back_ios),
        onPressed: () {
          setState(() {
            _searchFlag = false;
          });
        },
      ),
      backgroundColor: Colors.white,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black45),
      iconTheme: IconThemeData(color: Colors.black45),
      title: _searchContact(),
    );
  }

  appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black45),
      iconTheme: IconThemeData(color: Colors.black45),
      title: Text("Chat"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _searchFlag = true;
              _searchFocus.requestFocus();
            });
          },
        ),
      ],
    );
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
        appBar: _searchFlag ? searchAppBar() : appBar(),
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
                  // _searchResultBox(),
                  Expanded(
                    child: Consumer<ChatBloc>(
                      builder: (context, bloc, _) => StreamProvider.value(
                        initialData: null,
                        value: bloc.chatItemsStream,
                        child: Consumer<String>(
                          builder: (context, msg, _) {
                            if (msg != null) {
                              // print("message receive call");

                              Message message =
                                  Message.fromJson(jsonDecode(msg));

                              _getSingleUserFromLocalStorage(message.author)
                                  .then(
                                (value) {
                                  if (value == null) {
                                    print("the contact did not exist be4");
                                    socket.emit(
                                        "acknowledgementReceiveHomeScreen",
                                        msg);

                                    contactList.clear();
                                    _startIndex = 0;
                                    _addNewUserIntoDB(
                                        friendId: message.author,
                                        getUserProfileFromServerflag: true);
                                  }
                                },
                              );
                            }

                            return SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: <Widget>[
                                  _contactList(),
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
          ),
        ),
      ),
    );
  }
}
