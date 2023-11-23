import 'dart:async';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sentry_sqflite/sentry_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/chat_model.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/profile_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/utils/local_storage.dart';

class DatabaseHelper {
  static const _databaseName = "ePanduChat.db";
  static const _databaseVersion = 1;
  static const String messageAndAuthorTable = 'MessageAndAuthorTable';
  static const String messageTargetTable = 'MessageTargetTable';
  static const String userTable = 'UserTable';
  static const String relationshipTable = 'RelationshipTable';
  static const String roomTable = 'RoomTable';
  static const String roomMembersTable = 'RoomMembersTable';
  static const String msgDetailTable = 'MsgDetailTable';
  static const String testTable = 'TestTable';
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  final LocalStorage localStorage = LocalStorage();
  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabaseWithSentry(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> deleteDB() async {
    try {
      String path = join(await getDatabasesPath(), _databaseName);
      print('deleting db');
      _database = null;
      await deleteDatabase(path);
      print('db is deleted');
    } catch (e) {
      print(e.toString());
    }
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        " CREATE TABLE $messageAndAuthorTable (id TEXT PRIMARY KEY, author TEXT,data TEXT,sent_date_time INTEGER,type TEXT,is_seen TEXT);");
    await db.execute(
        " CREATE TABLE $messageTargetTable (id TEXT PRIMARY KEY, message_id TEXT, target_id TEXT);");
    await db.execute(
        " CREATE TABLE $userTable (id TEXT PRIMARY KEY, name TEXT,phone_number TEXT, picture_path TEXT);");
    await db.execute(
        " CREATE TABLE $relationshipTable (id TEXT PRIMARY KEY, host_id TEXT, friend_id TEXT, FOREIGN KEY (friend_id) REFERENCES $userTable (id) );");
    await db.execute(
        " CREATE TABLE $roomTable (ID TEXT NOT NULL,room_id TEXT NOT NULL,app_code TEXT,merchant_user_id TEXT,merchant_login_id TEXT,merchant_nick_name TEXT,user_id TEXT,login_id TEXT,member_nick_name TEXT,room_name TEXT,room_desc TEXT,create_user TEXT,create_date TEXT,edit_user TEXT,edit_date TEXT,row_key TEXT,transtamp TEXT,deleted TEXT,delete_datetime TEXT,photo_filename TEXT,profile_photo TEXT,merchant_no TEXT,picture_path  TEXT,owner_id TEXT);");
    await db.execute(
        " CREATE TABLE $roomMembersTable (ID TEXT NOT NULL,room_id TEXT NOT NULL,app_code TEXT,user_id TEXT,login_id TEXT,user_type TEXT,create_user TEXT,create_date TEXT,edit_user TEXT,edit_date TEXT,row_key TEXT,transtamp TEXT,deleted TEXT,merchant_no TEXT,nick_name TEXT,picture_path TEXT,FOREIGN KEY (room_id) REFERENCES $roomTable (room_id) );");
    await db.execute(
        " CREATE TABLE $msgDetailTable (id INTEGER PRIMARY KEY AUTOINCREMENT,room_id TEXT NOT NULL,user_id TEXT NOT NULL,app_id TEXT,ca_uid TEXT,device_id TEXT,msg_body TEXT,msg_binary TEXT,msg_binaryType TEXT,reply_to_id INT,message_id INT,read_by TEXT ,status TEXT,status_msg TEXT,deleted INT,send_datetime TEXT,edit_datetime TEXT,delete_datetime TEXT,transtamp TEXT,filePath TEXT,owner_id TEXT,msgStatus TEXT,clientMessageId TEXT,nickName TEXT);");
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 1) {
      print('Test Upgrade');
      await db.execute(
          " CREATE TABLE $testTable (id INTEGER PRIMARY KEY AUTOINCREMENT,room_id TEXT NOT NULL);");
    }
  }
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
/*
  Future<int> insert(Contact contact) async {
    Database db = await instance.database;
    return await db.insert(table, {'userId': contact.userId, 'phone': contact.phone,'name': contact.name});
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Contact contact) async {
    Database db = await instance.database;
    int id = contact.toMap()['id'];
    return await db.update(table, contact.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
*/

  Future<int> saveMessageAndAuthorTable(
      MessageAndAuthorTable messageAndAuthor) async {
    Database db = await instance.database;
    return await db.insert(messageAndAuthorTable, {
      'id': messageAndAuthor.id,
      'author': messageAndAuthor.author,
      'data': messageAndAuthor.data,
      'sent_date_time': messageAndAuthor.sentDateTime,
      'type': messageAndAuthor.type,
      'isSeen': messageAndAuthor.isSeen
    });
  }

  Future<int> saveMessageTargetTable(MessageTargetTable messageTarget) async {
    Database db = await instance.database;
    return await db.insert(messageTargetTable, {
      'id': messageTarget.id,
      'message_id': messageTarget.messageId,
      'target_id': messageTarget.targetId
    });
  }

  Future<int> saveUserTable(UserProfile userProfile) async {
    Database db = await instance.database;
    return await db.insert(userTable, {
      'id': userProfile.iD,
      'name': userProfile.name,
      'phone_number': userProfile.phone,
      'picture_path': userProfile.picturePath
    });
  }

  Future<int> saveRelationshipTable(
      String id, String hostID, String friendID) async {
    Database db = await instance.database;
    return await db.insert(relationshipTable,
        {'id': id, 'host_id': hostID, 'friend_id': friendID});
  }

  //Read Query
  Future<List<Message>> getMessageAndAuthorTable(
      {String? userId,
      String? targetId,
      int? startIndex,
      int? noOfRecords}) async {
    Database db = await instance.database;

    List<Map> maps = await db.rawQuery(
        "SELECT $messageAndAuthorTable.id AS id, $messageAndAuthorTable.author AS author, $messageAndAuthorTable.data AS data, $messageAndAuthorTable.sent_date_time AS sent_date_time, $messageAndAuthorTable.type AS type,$messageAndAuthorTable.is_seen AS is_seen FROM $messageAndAuthorTable INNER JOIN $messageTargetTable ON $messageTargetTable.message_id = $messageAndAuthorTable.id where $messageAndAuthorTable.author = '$userId' AND $messageTargetTable.target_id = '$targetId' OR $messageAndAuthorTable.author = '$targetId' AND $messageTargetTable.target_id = '$userId' ORDER BY $messageAndAuthorTable.send_datetime DESC LIMIT $startIndex,$noOfRecords ;");

    List<Message> messages = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        messages.add(Message.fromJson(
            maps[maps.length - 1 - i] as Map<String, dynamic>));
      }
    }
    return messages;
  }

  Future<List<UserProfile>> getContactList(
      {String? userId, int? startIndex, int? noOfRecords}) async {
    Database db = await instance.database;
    List<Map> maps = await db.rawQuery(
        "Select $userTable.id As user_id, $userTable.name As name, $userTable.phone_number As phone, $userTable.picture_path As picture_path from $userTable Inner Join $relationshipTable On $userTable.id = $relationshipTable.friend_id where $relationshipTable.host_id = '$userId'  ORDER BY $userTable.name LIMIT $startIndex,$noOfRecords;");
    List<UserProfile> users = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        users.add(UserProfile.fromJson(maps[i] as Map<String, dynamic>));
      }
    }
    return users;
  }

  Future<UserProfile?> getSingleContact(
      {String? userId, String? friendId}) async {
    Database db = await instance.database;

    List<Map> maps = await db.rawQuery(
        "Select id As ID from $relationshipTable where host_id = '$userId' And friend_id = '$friendId' ");

    UserProfile? user;
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i] as Map<String, dynamic>);
      }
    }
    return user;
  }

  Future<UserProfile?> getSingleUser({String? userId}) async {
    Database db = await instance.database;
    List<Map> maps = await db
        .rawQuery("Select id As ID from $userTable where id = '$userId'");

    UserProfile? user;
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i] as Map<String, dynamic>);
      }
    }
    return user;
  }

  //Update query
  Future<int> updateMessageTargetTable(MessageTargetTable messageTarget) async {
    Database db = await instance.database;
    return await db.update(messageTargetTable, messageTarget.toMap(),
        where: "id = ?", whereArgs: [messageTarget.id]);
  }

  //Delete query
  Future<int> deleteMessageTargetTable(int id) async {
    Database db = await instance.database;
    return await db
        .delete(messageTargetTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> saveRoomTable(Room room) async {
    Database db = await instance.database;
    String? userId = await localStorage.getUserId();
    String roomId = room.roomId!;
    var res = await db
        .rawQuery("Select room_id from $roomTable where room_id = '$roomId'");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    if (list.isEmpty) {
      print('RoomId_${room.roomId!}');
      return await db.insert(roomTable, {
        'ID': room.id,
        'room_id': room.roomId,
        'app_code': room.appCode,
        'merchant_user_id': room.merchantUserId,
        'merchant_login_id': room.merchantLoginId,
        'merchant_nick_name': room.merchantNickName,
        'user_id': room.userId,
        'login_id': room.loginId,
        'member_nick_name': room.memberNickName,
        'room_name': room.roomName,
        'room_desc': room.roomDesc,
        'create_user': room.createUser,
        'create_date': room.createDate,
        'edit_user': room.editUser,
        'edit_date': room.editDate,
        'row_key': room.rowKey,
        'transtamp': room.transtamp,
        'deleted': room.deleted,
        'photo_filename': room.photoFilename,
        'profile_photo': room.profilePhoto,
        'merchant_no': room.merchantNo,
        'picture_path': room.picturePath,
        'owner_id': userId,
        'delete_datetime': room.deleteDatetime
      });
    } else {
      return 0;
    }
  }

  Future<List<Room>> getRooms() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $roomTable.create_date, $roomTable.room_id,$roomTable.picture_path,$roomTable.room_name,$roomTable.room_desc,$roomTable.deleted,$roomTable.delete_datetime,$roomTable.merchant_no,$roomTable.owner_id from $roomTable;");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<Room>> getRoomList(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $roomMembersTable.merchant_no,$roomMembersTable.user_id,$roomTable.create_date, $roomTable.room_id, $roomTable.deleted,$roomTable.delete_datetime,$roomTable.picture_path,$roomTable.room_name,$roomTable.room_desc,$roomTable.owner_id from $roomTable LEFT JOIN $roomMembersTable ON $roomMembersTable.room_id=$roomTable.room_id  where $roomMembersTable.user_id = '$userId';");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<RoomHistoryModel>> getRoomListWithMessage(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT   $roomTable.room_id,$roomTable.picture_path,$roomTable.room_name,$roomTable.room_desc,$roomTable.merchant_no,$roomTable.deleted,$roomTable.delete_datetime,$msgDetailTable.message_id,$msgDetailTable.msg_body,$msgDetailTable.msg_binaryType,$msgDetailTable.filePath, $msgDetailTable.nickName AS nick_name,$msgDetailTable.send_datetime FROM $roomTable  LEFT JOIN $msgDetailTable on $msgDetailTable.room_id=$roomTable.room_id AND  $msgDetailTable.deleted == 0 where $roomTable.owner_id = '$userId'   group by $roomTable.room_id order by max($msgDetailTable.message_id) desc;");

//  var res = await db.rawQuery(
    //  "SELECT   $roomTable.room_id,$roomTable.picture_path,$roomTable.room_name,$roomTable.room_desc,$roomTable.merchant_no,$msgDetailTable.message_id,$msgDetailTable.msg_body,$msgDetailTable.msg_binaryType,$msgDetailTable.filePath, $msgDetailTable.nickName AS nick_name,$msgDetailTable.send_datetime FROM $roomTable  LEFT JOIN $msgDetailTable on $msgDetailTable.room_id=$roomTable.room_id AND  $msgDetailTable.deleted == 0 where $roomTable.owner_id = '$userId'   group by $roomTable.room_id order by max($msgDetailTable.send_datetime) desc;");

    List<RoomHistoryModel> list = res.isNotEmpty
        ? res.map((m) => RoomHistoryModel.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<Room>> getRoomListDesc(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT user_id,create_date,room_id,picture_path,room_name,room_desc,message FROM (Select ROW_NUMBER() OVER (ORDER BY $msgDetailTable.send_datetime desc) as RowNum,$roomMembersTable.user_id,$roomTable.create_date, $roomTable.room_id,$roomTable.picture_path,$roomTable.room_name,$roomTable.room_desc,(select $msgDetailTable.msg_body from $msgDetailTable  where $msgDetailTable.room_id=$roomTable.room_id) AS 'message',(select $msgDetailTable.send_datetime from $msgDetailTable  where $msgDetailTable.room_id=$roomTable.room_id) AS 'send_datetime' from $roomTable left JOIN $msgDetailTable ON $roomTable.room_id=$msgDetailTable.room_id  left JOIN $roomMembersTable ON $roomMembersTable.room_id=$roomTable.room_idWHERE $roomMembersTable.user_id='$userId' ORDER BY $msgDetailTable.send_datetime desc) AS T;");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    return list;
  }

  Future<int> saveRoomMembersTable(RoomMembers roomMembers) async {
    Database db = await instance.database;
    String roomId = roomMembers.roomId!;
    String roomMemberId = roomMembers.userId!;
    var res = await db.rawQuery(
        "Select room_id from $roomMembersTable where room_id = '$roomId' AND user_id = '$roomMemberId' ");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    if (list.isEmpty) {
      return await db.insert(roomMembersTable, {
        'ID': roomMembers.id,
        'room_id': roomMembers.roomId,
        'app_code': roomMembers.appCode,
        'user_id': roomMembers.userId,
        'login_id': roomMembers.loginId,
        'user_type': roomMembers.userType,
        'create_user': roomMembers.createUser,
        'create_date': roomMembers.createDate,
        'edit_user': roomMembers.editUser,
        'edit_date': roomMembers.editDate,
        'row_key': roomMembers.rowKey,
        'transtamp': roomMembers.transtamp,
        'deleted': roomMembers.deleted,
        'merchant_no': roomMembers.merchantNo,
        'nick_name': roomMembers.nickName,
        'picture_path': roomMembers.picturePath
      });
    } else {
      return 0;
    }
  }

  Future<List<RoomMembers>> getRoomMembersList(String roomId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $roomMembersTable.user_id as user_id, $roomMembersTable.nick_name as nick_name,$roomMembersTable.picture_path as picture_path,$roomMembersTable.login_id as login_id,$roomTable.room_name as room_name from $roomMembersTable LEFT JOIN $roomTable ON $roomTable.room_id=$roomMembersTable.room_id  where $roomMembersTable.room_id = '$roomId' and $roomMembersTable.deleted = 'false'   ORDER BY $roomMembersTable.nick_name ASC;");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<RoomMembers>> getDistinctRoomMembersList(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $roomMembersTable.user_id as user_id,$roomMembersTable.room_id as room_id from $roomMembersTable where $roomMembersTable.user_id!='$userId'; ");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<RoomMembers>> getRoomMemberName(String? userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select nick_name from $roomMembersTable where $roomMembersTable.user_id = '$userId';");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<int> updateRoomMemberPic(String? userId, String picturePath,
      String nickName, String deleted, String roomId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $roomMembersTable SET picture_path = ?,nick_name = ?,deleted = ? where user_id = ? and room_id = ?",
        [picturePath, nickName, deleted, userId, roomId]);
  }

  Future<int> updateRoomMemberStatus(
      String? userId, String deleted, String roomId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $roomMembersTable SET deleted = ? where user_id = ? AND room_id = ?",
        [deleted, userId, roomId]);
  }

  Future<int> updateRoomMemberName(String? userId, String nickName) async {
    Database db = await instance.database;
    await db.rawUpdate(
        "UPDATE $msgDetailTable SET nickName = ? where user_id = ?",
        [nickName, userId]);
    int j = await db.rawUpdate(
        "UPDATE $roomMembersTable SET nick_name = ? where user_id = ?", [
      nickName,
      userId,
    ]);

    List<RoomMembers> list = await getRoomsListByUserId(userId!);
    for (var room in list) {
      await db.rawUpdate(
          "UPDATE $roomTable SET room_name = ? where room_desc IN ('Private Chat', 'Chat Support') and room_id = ?",
          [nickName, room.roomId!]);
    }
    return j;
  }

  Future<List<RoomMembers>> getRoomsListByUserId(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $roomMembersTable.user_id as user_id, $roomMembersTable.room_id as room_id from $roomMembersTable LEFT JOIN $roomTable ON $roomTable.room_id=$roomMembersTable.room_id  where $roomMembersTable.user_id = '$userId';");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<int> updateRoomPic(String? roomId, String picturePath) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $roomTable SET picture_path = ? where room_id = ?",
        [picturePath, roomId]);
  }

  Future<int> updateRoomDetails(
      String? roomId, String picturePath, String roomName) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $roomTable SET picture_path = ?,room_name = ? where room_id = ?",
        [picturePath, roomName, roomId]);
  }

  Future<int> deleteRoom() async {
    Database db = await instance.database;
    return await db.delete(roomTable);
  }

  Future<int> deleteRoomById(String roomId) async {
    Database db = await instance.database;
    return await db
        .delete(roomTable, where: 'room_id = ?', whereArgs: [roomId]);
  }

  Future<int> deleteRoomMembers() async {
    Database db = await instance.database;
    int res = await db.delete(roomMembersTable);
    return res;
  }

  Future<int> deleteRoomMembersByRoomId(String roomId) async {
    Database db = await instance.database;
    return await db
        .delete(roomMembersTable, where: 'room_id = ?', whereArgs: [roomId]);
  }

  Future<int> deleteMessagesByRoomId(String roomId) async {
    Database db = await instance.database;
    return await db
        .delete(msgDetailTable, where: 'room_id = ?', whereArgs: [roomId]);
  }

  Future<List<MessageDetails>> isMessageExist(String clientMessageId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select user_id from $msgDetailTable where clientMessageId = '$clientMessageId'");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<int> saveMsgDetailTable(MessageDetails messageDetails) async {
    Database db = await instance.database;
    // String clientMessageId = messageDetails.client_message_id!;
    // var res = await db.rawQuery(
    //     "Select user_id from $M_MSG_DETAIL_TABLE where clientMessageId = '$clientMessageId'");
    // List<MessageDetails> list = res.isNotEmpty
    //     ? res.map((m) => MessageDetails.fromJson(m)).toList()
    //     : [];
    // if (list.length == 0)
    return await db.insert(msgDetailTable, {
      'room_id': messageDetails.roomId,
      'user_id': messageDetails.userId,
      'app_id': messageDetails.appId,
      'ca_uid': messageDetails.caUid,
      'device_id': messageDetails.deviceId,
      'msg_body': messageDetails.msgBody,
      'msg_binary': messageDetails.msgBinary,
      'msg_binaryType': messageDetails.msgBinaryType,
      'reply_to_id': messageDetails.replyToId,
      'message_id': messageDetails.messageId,
      'read_by': messageDetails.readBy,
      'status': messageDetails.status,
      'status_msg': messageDetails.statusMsg,
      'deleted': messageDetails.deleted,
      'send_datetime': messageDetails.sendDateTime,
      'edit_datetime': messageDetails.editDateTime,
      'delete_datetime': messageDetails.deleteDateTime,
      'transtamp': messageDetails.transtamp,
      'filePath': messageDetails.filePath,
      'owner_id': messageDetails.ownerId,
      'msgStatus': messageDetails.msgStatus,
      'clientMessageId': messageDetails.clientMessageId,
      'nickName': messageDetails.nickName,
    });
    // else
    //   return 0;
  }

  Future<int> updateMsgDetailTable(String clientMessageId, String msgStatus,
      int messageId, String sendDatetime) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $msgDetailTable SET msgStatus = ?,message_id = ?,send_datetime = ?  where clientMessageId = ?",
        [msgStatus, messageId, sendDatetime, clientMessageId]);
  }
  // Future<int> updateMsgDetailTable(String clientMessageId, String msgStatus,
  //     int messageId, String filePath) async {
  //   Database db = await instance.database;
  //   return await db.rawUpdate(
  //       "UPDATE $M_MSG_DETAIL_TABLE SET msgStatus = ?,message_id = ?,filePath = ?  where clientMessageId = ?",
  //       [msgStatus, messageId, filePath, clientMessageId]);
  // }

  Future<int> updateMsgStatus(String msgStatus, int messageId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $msgDetailTable SET msgStatus = ? where message_id = ?",
        [msgStatus, messageId]);
  }

  Future<int> updateMsgDetailTableText(
      String msgBody, int messageId, String editDateTime) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $msgDetailTable SET msg_body = ?,edit_datetime = ? where message_id = ?",
        [
          msgBody,
          DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(DateTime.parse(editDateTime).toLocal())
              .toString(),
          messageId
        ]);
  }

  Future<int> updateRoomName(String roomName, String roomId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $roomTable SET room_name = ? where room_id = ?",
        [roomName, roomId]);
  }

  Future<int> deleteMsg(int messageId, String deletedTime) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $msgDetailTable SET deleted = ?,delete_datetime = ?  where message_id = ?",
        [
          1,
          DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(DateTime.parse(deletedTime).toLocal())
              .toString(),
          messageId
        ]);
  }

  Future<int> deleteMsgDetailTable(int messageId) async {
    Database db = await instance.database;
    return await db.delete(msgDetailTable,
        where: 'message_id = ?', whereArgs: [messageId]);
  }

  Future<int> updateMessageStatus(int messageId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $msgDetailTable SET deleted = ? where message_id = ?",
        [1, messageId]);
  }

  Future<int> deleteMsgDetailTableByClientMessageId(
      String clientMessageId) async {
    Database db = await instance.database;
    return await db.delete(msgDetailTable,
        where: 'clientMessageId = ?', whereArgs: [clientMessageId]);
  }

  Future<List<MessageDetails>> getLatestMsgDetail(String roomId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select user_id,owner_id,room_id,reply_to_id,message_id,clientMessageId from $msgDetailTable where room_id = '$roomId' AND message_id>0   ORDER BY message_id DESC LIMIT 1;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getAllRoomLatestMsgDetail() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select room_id, MAX(message_id) AS message_id,owner_id, clientMessageId from $msgDetailTable where  message_id>0   GROUP BY room_id;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getMsgDetailList() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $msgDetailTable.room_id as room_id,$msgDetailTable.user_id as user_id,$msgDetailTable.msg_body as msg_body,$msgDetailTable.msg_binaryType as msg_binaryType,$msgDetailTable.send_datetime as send_datetime,$msgDetailTable.reply_to_id as reply_to_id,$msgDetailTable.filePath as filePath,$msgDetailTable.msgStatus as msgStatus,$msgDetailTable.message_id as message_id,$msgDetailTable.clientMessageId as client_message_id,$msgDetailTable.nickName as nick_name from $msgDetailTable  where  $msgDetailTable.deleted == 0  ORDER BY $msgDetailTable.send_datetime ASC;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getLazyLoadMsgDetailList(
      String roomId, int batchSize, int offset) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $msgDetailTable.room_id as room_id,$msgDetailTable.user_id as user_id,$msgDetailTable.msg_body as msg_body,$msgDetailTable.msg_binaryType as msg_binaryType,$msgDetailTable.send_datetime as send_datetime,$msgDetailTable.reply_to_id as reply_to_id,$msgDetailTable.filePath as filePath,$msgDetailTable.msgStatus as msgStatus,$msgDetailTable.message_id as message_id,$msgDetailTable.clientMessageId as client_message_id,$msgDetailTable.nickName as nick_name from $msgDetailTable  where  $msgDetailTable.deleted == 0 and $msgDetailTable.room_id = '$roomId'  ORDER BY $msgDetailTable.message_id DESC LIMIT $batchSize OFFSET $offset;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getFailedMsgList(String roomId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $msgDetailTable.room_id as room_id,$msgDetailTable.user_id as user_id,$msgDetailTable.msg_body as msg_body,$msgDetailTable.msg_binaryType as msg_binaryType,$msgDetailTable.send_datetime as send_datetime,$msgDetailTable.reply_to_id as reply_to_id,$msgDetailTable.filePath as filePath,$msgDetailTable.msgStatus as msgStatus,$msgDetailTable.message_id as message_id,$msgDetailTable.clientMessageId as client_message_id,$msgDetailTable.nickName as nick_name from $msgDetailTable  where  $msgDetailTable.deleted == 0 and $msgDetailTable.room_id = '$roomId' and $msgDetailTable.message_id = 0;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getAllMsgDetail() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $msgDetailTable.message_id as message_id,$msgDetailTable.user_id as user_id from $msgDetailTable  ORDER BY $msgDetailTable.send_datetime ASC;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getFailedMsgDetailList() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $msgDetailTable.room_id as 'room_id',$msgDetailTable.msg_body as 'msg_body',$msgDetailTable.filePath as 'filePath',$msgDetailTable.reply_to_id as 'reply_to_id',$msgDetailTable.msg_binaryType as 'msg_binaryType',$msgDetailTable.clientMessageId as 'client_message_id',$roomTable.room_name as 'roomName'  from $msgDetailTable LEFT JOIN $roomTable ON $roomTable.room_id=$msgDetailTable.room_id   where msgStatus = 'SENDING' ORDER BY $msgDetailTable.send_datetime ASC;");

    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<int> deleteMsgDetail() async {
    Database db = await instance.database;
    return await db.delete(msgDetailTable);
  }

  Future<List<MessageDetails>> getLatestMsgToEachRoom() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT MAX($msgDetailTable.message_id) as 'message_id',$msgDetailTable.msg_binarytype,$msgDetailTable.msg_body,$msgDetailTable.room_id,$msgDetailTable.send_datetime,$roomMembersTable.nick_name,$msgDetailTable.filePath FROM $msgDetailTable left join $roomMembersTable on $roomMembersTable.room_id=$msgDetailTable.room_id and $roomMembersTable.user_id=$msgDetailTable.user_id where $msgDetailTable.msgStatus NOT IN ('SENDING','FAILED') AND $msgDetailTable.message_id>0 AND $msgDetailTable.deleted==0  group by $msgDetailTable.room_id"
        "");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<int> deleteLogicallyRoomById(
      String roomId, String deleted, String deleteDatetime) async {
    Database db = await instance.database;

    int count = await db.rawUpdate(
        "UPDATE $roomTable SET deleted = ?,delete_datetime=? where room_id = ?",
        [deleted, deleteDatetime, roomId]);
    // print('deleteLogicallyRoomById');
    return count;
  }

  Future<int> updatedeleteStatusByRoomById(
      String roomId, String deleted) async {
    Database db = await instance.database;

    int count = await db.rawUpdate(
        "UPDATE $roomTable SET deleted = ? where room_id = ?",
        [deleted, roomId]);
    // print('deleteLogicallyRoomById');
    return count;
  }
}
