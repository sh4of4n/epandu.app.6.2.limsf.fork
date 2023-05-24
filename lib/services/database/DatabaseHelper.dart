import 'dart:async';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../common_library/services/model/chat_mesagelist.dart';
import '../../common_library/services/model/chat_model.dart';
import '../../common_library/services/model/m_room_model.dart';
import '../../common_library/services/model/m_roommember_model.dart';
import '../../common_library/services/model/profile_model.dart';
import '../../common_library/services/model/roomhistory_model.dart';
import '../../common_library/utils/local_storage.dart';

// class DatabaseHelper {
//   static final _databaseName = "ePanduChat.db";
//   static final _databaseVersion = 1;
//   static const String MESSAGE_AND_AUTHOR_TABLE = 'MessageAndAuthorTable';
//   static const String MESSAGE_TARGET_TABLE = 'MessageTargetTable';
//   static const String USER_TABLE = 'UserTable';
//   static const String RELATIONSHIP_TABLE = 'RelationshipTable';
//   static const String M_ROOM_TABLE = 'RoomTable';
//   static const String M_ROOM_MEMBERS_TABLE = 'RoomMembersTable';
//   static const String M_MSG_DETAIL_TABLE = 'MsgDetailTable';
//   // make this a singleton class
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

//   // only have a single app-wide reference to the database
//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();

//   // this opens the database (and creates it if it doesn't exist)
//   _initDatabase() async {
//     String path = join(await getDatabasesPath(), _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }

//   Future<void> deleteDB() async {
//     try {
//       String path = join(await getDatabasesPath(), _databaseName);
//       print('deleting db');
//       _database = null;
//       deleteDatabase(path);
//     } catch (e) {
//       print(e.toString());
//     }
//     print('db is deleted');
//   }

//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     await db.execute(
//         " CREATE TABLE $MESSAGE_AND_AUTHOR_TABLE (id TEXT PRIMARY KEY, author TEXT,data TEXT,sent_date_time INTEGER,type TEXT,is_seen TEXT);");
//     await db.execute(
//         " CREATE TABLE $MESSAGE_TARGET_TABLE (id TEXT PRIMARY KEY, message_id TEXT, target_id TEXT);");
//     await db.execute(
//         " CREATE TABLE $USER_TABLE (id TEXT PRIMARY KEY, name TEXT,phone_number TEXT, picture_path TEXT);");
//     await db.execute(
//         " CREATE TABLE $RELATIONSHIP_TABLE (id TEXT PRIMARY KEY, host_id TEXT, friend_id TEXT, FOREIGN KEY (friend_id) REFERENCES $USER_TABLE (id) );");
//     await db.execute(
//         " CREATE TABLE $M_ROOM_TABLE (ID TEXT NOT NULL,room_id TEXT NOT NULL,app_code TEXT,merchant_user_id TEXT,merchant_login_id TEXT,merchant_nick_name TEXT,user_id TEXT,login_id TEXT,member_nick_name TEXT,room_name TEXT,room_desc TEXT,create_user TEXT,create_date TEXT,edit_user TEXT,edit_date TEXT,row_key TEXT,transtamp TEXT,deleted TEXT,photo_filename TEXT,profile_photo TEXT,merchant_no TEXT,picture_path  TEXT);");
//     await db.execute(
//         " CREATE TABLE $M_ROOM_MEMBERS_TABLE (ID TEXT NOT NULL,room_id TEXT NOT NULL,app_code TEXT,user_id TEXT,login_id TEXT,user_type TEXT,create_user TEXT,create_date TEXT,edit_user TEXT,edit_date TEXT,row_key TEXT,transtamp TEXT,deleted TEXT,merchant_no TEXT,nick_name TEXT,picture_path TEXT,FOREIGN KEY (room_id) REFERENCES $M_ROOM_TABLE (room_id) );");
//     await db.execute(
//         " CREATE TABLE $M_MSG_DETAIL_TABLE (id INTEGER PRIMARY KEY AUTOINCREMENT,room_id TEXT NOT NULL,user_id TEXT NOT NULL,app_id TEXT NOT NULL,ca_uid TEXT NOT NULL,device_id TEXT NOT NULL,msg_body TEXT NOT NULL,msg_binary TEXT,msg_binaryType TEXT,reply_to_id INT,message_id INT,read_by TEXT ,status TEXT,status_msg TEXT,deleted INT,send_datetime TEXT NOT NULL,edit_datetime TEXT,delete_datetime TEXT,transtamp TEXT,filePath TEXT,owner_id TEXT,msgStatus TEXT,clientMessageId TEXT);");
//   }

//   // Helper methods

//   // Inserts a row in the database where each key in the Map is a column name
//   // and the value is the column value. The return value is the id of the
//   // inserted row.
// /*
//   Future<int> insert(Contact contact) async {
//     Database db = await instance.database;
//     return await db.insert(table, {'userId': contact.userId, 'phone': contact.phone,'name': contact.name});
//   }

//   // All of the rows are returned as a list of maps, where each map is
//   // a key-value list of columns.
//   Future<List<Map<String, dynamic>>> queryAllRows() async {
//     Database db = await instance.database;
//     return await db.query(table);
//   }

//   // Queries rows based on the argument received
//   Future<List<Map<String, dynamic>>> queryRows(name) async {
//     Database db = await instance.database;
//     return await db.query(table, where: "$columnName LIKE '%$name%'");
//   }

//   // All of the methods (insert, query, update, delete) can also be done using
//   // raw SQL commands. This method uses a raw query to give the row count.
//   Future<int?> queryRowCount() async {
//     Database db = await instance.database;
//     return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
//   }

//   // We are assuming here that the id column in the map is set. The other
//   // column values will be used to update the row.
//   Future<int> update(Contact contact) async {
//     Database db = await instance.database;
//     int id = contact.toMap()['id'];
//     return await db.update(table, contact.toMap(), where: '$columnId = ?', whereArgs: [id]);
//   }

//   // Deletes the row specified by the id. The number of affected rows is
//   // returned. This should be 1 as long as the row exists.
//   Future<int> delete(int id) async {
//     Database db = await instance.database;
//     return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//   }
// */

//   Future<int> saveMessageAndAuthorTable(
//       MessageAndAuthorTable messageAndAuthorTable) async {
//     Database db = await instance.database;
//     return await db.insert(MESSAGE_AND_AUTHOR_TABLE, {
//       'id': messageAndAuthorTable.id,
//       'author': messageAndAuthorTable.author,
//       'data': messageAndAuthorTable.data,
//       'sent_date_time': messageAndAuthorTable.sentDateTime,
//       'type': messageAndAuthorTable.type,
//       'isSeen': messageAndAuthorTable.isSeen
//     });
//   }

//   Future<int> saveMessageTargetTable(
//       MessageTargetTable messageTargetTable) async {
//     Database db = await instance.database;
//     return await db.insert(MESSAGE_TARGET_TABLE, {
//       'id': messageTargetTable.id,
//       'message_id': messageTargetTable.messageId,
//       'target_id': messageTargetTable.targetId
//     });
//   }

//   Future<int> saveUserTable(UserProfile userProfile) async {
//     Database db = await instance.database;
//     return await db.insert(USER_TABLE, {
//       'id': userProfile.iD,
//       'name': userProfile.name,
//       'phone_number': userProfile.phone,
//       'picture_path': userProfile.picturePath
//     });
//   }

//   Future<int> saveRelationshipTable(
//       String id, String hostID, String friendID) async {
//     Database db = await instance.database;
//     return await db.insert(RELATIONSHIP_TABLE,
//         {'id': id, 'host_id': hostID, 'friend_id': friendID});
//   }

//   //Read Query
//   Future<List<Message>> getMessageAndAuthorTable(
//       {String? userId,
//       String? targetId,
//       int? startIndex,
//       int? noOfRecords}) async {
//     Database db = await instance.database;

//     List<Map> maps = await db.rawQuery(
//         "SELECT $MESSAGE_AND_AUTHOR_TABLE.id AS id, $MESSAGE_AND_AUTHOR_TABLE.author AS author, $MESSAGE_AND_AUTHOR_TABLE.data AS data, $MESSAGE_AND_AUTHOR_TABLE.sent_date_time AS sent_date_time, $MESSAGE_AND_AUTHOR_TABLE.type AS type,$MESSAGE_AND_AUTHOR_TABLE.is_seen AS is_seen FROM $MESSAGE_AND_AUTHOR_TABLE INNER JOIN $MESSAGE_TARGET_TABLE ON $MESSAGE_TARGET_TABLE.message_id = $MESSAGE_AND_AUTHOR_TABLE.id where $MESSAGE_AND_AUTHOR_TABLE.author = '$userId' AND $MESSAGE_TARGET_TABLE.target_id = '$targetId' OR $MESSAGE_AND_AUTHOR_TABLE.author = '$targetId' AND $MESSAGE_TARGET_TABLE.target_id = '$userId' ORDER BY $MESSAGE_AND_AUTHOR_TABLE.send_datetime DESC LIMIT $startIndex,$noOfRecords ;");

//     List<Message> messages = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         messages.add(Message.fromJson(
//             maps[maps.length - 1 - i] as Map<String, dynamic>));
//       }
//     }
//     return messages;
//   }

//   Future<List<UserProfile>> getContactList(
//       {String? userId, int? startIndex, int? noOfRecords}) async {
//     Database db = await instance.database;
//     List<Map> maps = await db.rawQuery(
//         "Select $USER_TABLE.id As user_id, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone, $USER_TABLE.picture_path As picture_path from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");
//     List<UserProfile> users = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         users.add(UserProfile.fromJson(maps[i] as Map<String, dynamic>));
//         //print("phone: ${users[i].iD}");
//       }
//     }
//     //print(users.length);
//     return users;
//   }

//   Future<UserProfile?> getSingleContact(
//       {String? userId, String? friendId}) async {
//     Database db = await instance.database;

//     List<Map> maps = await db.rawQuery(
//         "Select id As ID from $RELATIONSHIP_TABLE where host_id = '$userId' And friend_id = '$friendId' ");

//     UserProfile? user;
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         user = UserProfile.fromJson(maps[i] as Map<String, dynamic>);
//       }
//     }
//     return user;
//   }

//   Future<UserProfile?> getSingleUser({String? userId}) async {
//     Database db = await instance.database;
//     List<Map> maps = await db
//         .rawQuery("Select id As ID from $USER_TABLE where id = '$userId'");

//     UserProfile? user;
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         user = UserProfile.fromJson(maps[i] as Map<String, dynamic>);
//       }
//     }
//     return user;
//   }

//   //Update query
//   Future<int> updateMessageTargetTable(
//       MessageTargetTable messageTargetTable) async {
//     Database db = await instance.database;
//     return await db.update(MESSAGE_TARGET_TABLE, messageTargetTable.toMap(),
//         where: "id = ?", whereArgs: [messageTargetTable.id]);
//   }

//   //Delete query
//   Future<int> deleteMessageTargetTable(int id) async {
//     Database db = await instance.database;
//     return await db
//         .delete(MESSAGE_TARGET_TABLE, where: 'id = ?', whereArgs: [id]);
//   }

//   Future<int> saveRoomTable(Room room) async {
//     Database db = await instance.database;
//     String roomId = room.room_id!;
//     var res = await db.rawQuery(
//         "Select room_id from $M_ROOM_TABLE where room_id = '$roomId'");
//     List<Room> list =
//         res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
//     if (list.length == 0) {
//       print('RoomId_' + room.room_id!);
//       return await db.insert(M_ROOM_TABLE, {
//         'ID': room.ID,
//         'room_id': room.room_id,
//         'app_code': room.app_code,
//         'merchant_user_id': room.merchant_user_id,
//         'merchant_login_id': room.merchant_login_id,
//         'merchant_nick_name': room.merchant_nick_name,
//         'user_id': room.user_id,
//         'login_id': room.login_id,
//         'member_nick_name': room.member_nick_name,
//         'room_name': room.room_name,
//         'room_desc': room.room_desc,
//         'create_user': room.create_user,
//         'create_date': room.create_date,
//         'edit_user': room.edit_user,
//         'edit_date': room.edit_date,
//         'row_key': room.row_key,
//         'transtamp': room.transtamp,
//         'deleted': room.deleted,
//         'photo_filename': room.photo_filename,
//         'profile_photo': room.profile_photo,
//         'merchant_no': room.merchant_no,
//         'picture_path': room.picture_path
//       });
//     } else
//       return 0;
//   }

//   // Future<List<Room>> getRoomList(String userId) async {
//   //   Database db = await instance.database;
//   //   var res = await db.query(M_ROOM_TABLE);

//   //   List<Room> list =
//   //       res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
//   //   return list;
//   // }

//   Future<List<Room>> getRoomList(String userId) async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select $M_ROOM_MEMBERS_TABLE.user_id,$M_ROOM_TABLE.create_date, $M_ROOM_TABLE.room_id,$M_ROOM_TABLE.picture_path,$M_ROOM_TABLE.room_name,$M_ROOM_TABLE.room_desc from $M_ROOM_TABLE LEFT JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.room_id=$M_ROOM_TABLE.room_id  where $M_ROOM_MEMBERS_TABLE.user_id = '$userId';");
//     List<Room> list =
//         res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
//     return list;
//   }

//   Future<List<Room>> getRoomListDesc(String userId) async {
//     Database db = await instance.database;
//     var res = await db.rawQuery("Select DISTINCT user_id,create_date,room_id,picture_path,room_name,room_desc,message FROM " +
//         "(Select ROW_NUMBER() OVER (ORDER BY $M_MSG_DETAIL_TABLE.send_datetime desc) as RowNum,$M_ROOM_MEMBERS_TABLE.user_id,$M_ROOM_TABLE.create_date, $M_ROOM_TABLE.room_id,$M_ROOM_TABLE.picture_path,$M_ROOM_TABLE.room_name,$M_ROOM_TABLE.room_desc," +
//         "(select $M_MSG_DETAIL_TABLE.msg_body from $M_MSG_DETAIL_TABLE  where $M_MSG_DETAIL_TABLE.room_id=$M_ROOM_TABLE.room_id) AS 'message'," +
//         "(select $M_MSG_DETAIL_TABLE.send_datetime from $M_MSG_DETAIL_TABLE  where $M_MSG_DETAIL_TABLE.room_id=$M_ROOM_TABLE.room_id) AS 'send_datetime' " +
//         "from $M_ROOM_TABLE" +
//         " left JOIN $M_MSG_DETAIL_TABLE ON $M_ROOM_TABLE.room_id=$M_MSG_DETAIL_TABLE.room_id  " +
//         "left JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.room_id=$M_ROOM_TABLE.room_id" +
//         "WHERE $M_ROOM_MEMBERS_TABLE.user_id='$userId' ORDER BY $M_MSG_DETAIL_TABLE.send_datetime desc) AS T;");
//     List<Room> list =
//         res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
//     return list;
//   }

//   Future<int> saveRoomMembersTable(RoomMembers roomMembers) async {
//     Database db = await instance.database;
//     String roomId = roomMembers.room_id!;
//     String roomMemberId = roomMembers.user_id!;
//     var res = await db.rawQuery(
//         "Select room_id from $M_ROOM_MEMBERS_TABLE where room_id = '$roomId' AND user_id = '$roomMemberId' ");
//     List<RoomMembers> list =
//         res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
//     if (list.length == 0) {
//       return await db.insert(M_ROOM_MEMBERS_TABLE, {
//         'ID': roomMembers.ID,
//         'room_id': roomMembers.room_id,
//         'app_code': roomMembers.app_code,
//         'user_id': roomMembers.user_id,
//         'login_id': roomMembers.login_id,
//         'user_type': roomMembers.user_type,
//         'create_user': roomMembers.create_user,
//         'create_date': roomMembers.create_date,
//         'edit_user': roomMembers.edit_user,
//         'edit_date': roomMembers.edit_date,
//         'row_key': roomMembers.row_key,
//         'transtamp': roomMembers.transtamp,
//         'deleted': roomMembers.deleted,
//         'merchant_no': roomMembers.merchant_no,
//         'nick_name': roomMembers.nick_name,
//         'picture_path': roomMembers.picture_path
//       });
//     } else
//       return 0;
//   }

//   Future<List<RoomMembers>> getRoomMembersList(String roomId) async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select $M_ROOM_MEMBERS_TABLE.user_id as user_id, $M_ROOM_MEMBERS_TABLE.nick_name as nick_name,$M_ROOM_MEMBERS_TABLE.picture_path as picture_path,$M_ROOM_MEMBERS_TABLE.login_id as login_id,$M_ROOM_TABLE.room_name as room_name from $M_ROOM_MEMBERS_TABLE LEFT JOIN $M_ROOM_TABLE ON $M_ROOM_TABLE.room_id=$M_ROOM_MEMBERS_TABLE.room_id  where $M_ROOM_MEMBERS_TABLE.room_id = '$roomId'  ORDER BY $M_ROOM_MEMBERS_TABLE.nick_name ASC;");
//     List<RoomMembers> list =
//         res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
//     return list;
//   }

//   Future<List<RoomMembers>> getRoomMemberName(String? userId) async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select nick_name from $M_ROOM_MEMBERS_TABLE where $M_ROOM_MEMBERS_TABLE.user_id = '$userId';");
//     List<RoomMembers> list =
//         res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
//     return list;
//   }

//   Future<int> updateRoomMemberPic(String? userId, String picturePath) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_ROOM_MEMBERS_TABLE SET picture_path = ? where user_id = ?",
//         [picturePath, userId]);
//   }

//   Future<int> updateRoomPic(String? roomId, String picturePath) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_ROOM_TABLE SET picture_path = ? where room_id = ?",
//         [picturePath, roomId]);
//   }

//   Future<int> deleteRoom() async {
//     Database db = await instance.database;
//     return await db.delete(M_ROOM_TABLE);
//   }

//   Future<int> deleteRoomMembers() async {
//     Database db = await instance.database;
//     return await db.delete(M_ROOM_MEMBERS_TABLE);
//   }

//   Future<int> saveMsgDetailTable(MessageDetails messageDetails) async {
//     Database db = await instance.database;
//     String clientMessageId = messageDetails.client_message_id!;
//     var res = await db.rawQuery(
//         "Select user_id from $M_MSG_DETAIL_TABLE where clientMessageId = '$clientMessageId'");
//     List<MessageDetails> list = res.isNotEmpty
//         ? res.map((m) => MessageDetails.fromJson(m)).toList()
//         : [];
//     if (list.length == 0)
//       return await db.insert(M_MSG_DETAIL_TABLE, {
//         'room_id': messageDetails.room_id,
//         'user_id': messageDetails.user_id,
//         'app_id': messageDetails.app_id,
//         'ca_uid': messageDetails.ca_uid,
//         'device_id': messageDetails.device_id,
//         'msg_body': messageDetails.msg_body,
//         'msg_binary': messageDetails.msg_binary,
//         'msg_binaryType': messageDetails.msg_binaryType,
//         'reply_to_id': messageDetails.reply_to_id,
//         'message_id': messageDetails.message_id,
//         'read_by': messageDetails.read_by,
//         'status': messageDetails.status,
//         'status_msg': messageDetails.status_msg,
//         'deleted': messageDetails.deleted,
//         'send_datetime': messageDetails.send_datetime,
//         'edit_datetime': messageDetails.edit_datetime,
//         'delete_datetime': messageDetails.delete_datetime,
//         'transtamp': messageDetails.transtamp,
//         'filePath': messageDetails.filePath,
//         'owner_id': messageDetails.owner_id,
//         'msgStatus': messageDetails.msgStatus,
//         'clientMessageId': messageDetails.client_message_id
//       });
//     else
//       return 0;
//   }

//   Future<int> updateMsgDetailTable(
//       String clientMessageId, String msgStatus, int message_id) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_MSG_DETAIL_TABLE SET msgStatus = ?,message_id = ?  where clientMessageId = ?",
//         [msgStatus, message_id, clientMessageId]);
//   }

//   Future<int> updateMsgStatus(String msgStatus, int messageId) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_MSG_DETAIL_TABLE SET msgStatus = ? where message_id = ?",
//         [msgStatus, messageId]);
//   }

//   Future<int> updateMsgDetailTableText(
//       String msg_body, int message_id, String editDateTime) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_MSG_DETAIL_TABLE SET msg_body = ?,edit_datetime = ? where message_id = ?",
//         [
//           msg_body,
//           DateFormat("yyyy-MM-dd HH:mm:ss")
//               .format(DateTime.parse(editDateTime).toLocal())
//               .toString(),
//           message_id
//         ]);
//   }

//   Future<int> updateRoomName(String roomName, String roomId) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_ROOM_TABLE SET room_name = ? where room_id = ?",
//         [roomName, roomId]);
//   }

//   Future<int> deleteMsg(int messageId, String deletedTime) async {
//     Database db = await instance.database;
//     return await db.rawUpdate(
//         "UPDATE $M_MSG_DETAIL_TABLE SET deleted = ?,delete_datetime = ?  where message_id = ?",
//         [
//           1,
//           DateFormat("yyyy-MM-dd HH:mm:ss")
//               .format(DateTime.parse(deletedTime).toLocal())
//               .toString(),
//           messageId
//         ]);
//   }

//   Future<int> deleteMsgDetailTable(int messageId) async {
//     Database db = await instance.database;
//     return await db.delete(M_MSG_DETAIL_TABLE,
//         where: 'message_id = ?', whereArgs: [messageId]);
//   }

//   Future<int> deleteMsgDetailTableByClientMessageId(
//       String clientMessageId) async {
//     Database db = await instance.database;
//     return await db.delete(M_MSG_DETAIL_TABLE,
//         where: 'clientMessageId = ?', whereArgs: [clientMessageId]);
//   }

//   Future<List<MessageDetails>> getLatestMsgDetail(String roomId) async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select user_id,owner_id,room_id,reply_to_id,message_id,clientMessageId from $M_MSG_DETAIL_TABLE where room_id = '$roomId' AND message_id>0   ORDER BY message_id DESC LIMIT 1;");
//     List<MessageDetails> list = res.isNotEmpty
//         ? res.map((m) => MessageDetails.fromJson(m)).toList()
//         : [];
//     return list;
//   }

//   // Future<List<MessageDetails>> getMsgDetailList(String roomId) async {
//   //   Database db = await instance.database;
//   //   var res = await db.rawQuery(
//   //       "Select DISTINCT $M_MSG_DETAIL_TABLE.room_id as room_id,$M_MSG_DETAIL_TABLE.user_id as user_id,$M_MSG_DETAIL_TABLE.msg_body as msg_body,$M_MSG_DETAIL_TABLE.msg_binaryType as msg_binaryType,$M_MSG_DETAIL_TABLE.send_datetime as send_datetime,$M_MSG_DETAIL_TABLE.reply_to_id as reply_to_id,$M_MSG_DETAIL_TABLE.filePath as filePath,$M_MSG_DETAIL_TABLE.msgStatus as msgStatus,$M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.clientMessageId as client_message_id,$M_ROOM_MEMBERS_TABLE.nick_name as nick_name from $M_MSG_DETAIL_TABLE LEFT JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.user_id=$M_MSG_DETAIL_TABLE.user_id  where $M_MSG_DETAIL_TABLE.room_id = '$roomId' and $M_MSG_DETAIL_TABLE.deleted == 0  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime ASC;");
//   //   List<MessageDetails> list = res.isNotEmpty
//   //       ? res.map((m) => MessageDetails.fromJson(m)).toList()
//   //       : [];
//   //   return list;
//   // }
//   Future<List<MessageDetails>> getMsgDetailList() async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select DISTINCT $M_MSG_DETAIL_TABLE.room_id as room_id,$M_MSG_DETAIL_TABLE.user_id as user_id,$M_MSG_DETAIL_TABLE.msg_body as msg_body,$M_MSG_DETAIL_TABLE.msg_binaryType as msg_binaryType,$M_MSG_DETAIL_TABLE.send_datetime as send_datetime,$M_MSG_DETAIL_TABLE.reply_to_id as reply_to_id,$M_MSG_DETAIL_TABLE.filePath as filePath,$M_MSG_DETAIL_TABLE.msgStatus as msgStatus,$M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.clientMessageId as client_message_id,$M_ROOM_MEMBERS_TABLE.nick_name as nick_name from $M_MSG_DETAIL_TABLE LEFT JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.user_id=$M_MSG_DETAIL_TABLE.user_id  where  $M_MSG_DETAIL_TABLE.deleted == 0  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime ASC;");
//     List<MessageDetails> list = res.isNotEmpty
//         ? res.map((m) => MessageDetails.fromJson(m)).toList()
//         : [];
//     return list;
//   }

//   Future<List<MessageDetails>> getAllMsgDetail() async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select DISTINCT $M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.user_id as user_id from $M_MSG_DETAIL_TABLE  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime ASC;");
//     List<MessageDetails> list = res.isNotEmpty
//         ? res.map((m) => MessageDetails.fromJson(m)).toList()
//         : [];
//     return list;
//   }

//   Future<List<MessageDetails>> getFailedMsgDetailList() async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "Select $M_MSG_DETAIL_TABLE.room_id as 'room_id',$M_MSG_DETAIL_TABLE.msg_body as 'msg_body',$M_MSG_DETAIL_TABLE.filePath as 'filePath',$M_MSG_DETAIL_TABLE.reply_to_id as 'reply_to_id',$M_MSG_DETAIL_TABLE.msg_binaryType as 'msg_binaryType',$M_MSG_DETAIL_TABLE.clientMessageId as 'client_message_id',$M_ROOM_TABLE.room_name as 'roomName'  from $M_MSG_DETAIL_TABLE LEFT JOIN $M_ROOM_TABLE ON $M_ROOM_TABLE.room_id=$M_MSG_DETAIL_TABLE.room_id   where msgStatus = 'SENDING';");

//     List<MessageDetails> list = res.isNotEmpty
//         ? res.map((m) => MessageDetails.fromJson(m)).toList()
//         : [];
//     return list;
//   }

//   Future<int> deleteMsgDetail() async {
//     Database db = await instance.database;
//     return await db.delete(M_MSG_DETAIL_TABLE);
//   }

//   Future<List<MessageDetails>> getLatestMsgToEachRoom() async {
//     Database db = await instance.database;
//     var res = await db.rawQuery(
//         "SELECT MAX($M_MSG_DETAIL_TABLE.message_id) as 'message_id',$M_MSG_DETAIL_TABLE.msg_binarytype,$M_MSG_DETAIL_TABLE.msg_body,$M_MSG_DETAIL_TABLE.room_id,$M_MSG_DETAIL_TABLE.send_datetime,$M_ROOM_MEMBERS_TABLE.nick_name,$M_MSG_DETAIL_TABLE.filePath FROM $M_MSG_DETAIL_TABLE left join $M_ROOM_MEMBERS_TABLE on $M_ROOM_MEMBERS_TABLE.room_id=$M_MSG_DETAIL_TABLE.room_id and $M_ROOM_MEMBERS_TABLE.user_id=$M_MSG_DETAIL_TABLE.user_id where $M_MSG_DETAIL_TABLE.msgStatus NOT IN ('SENDING','FAILED') AND $M_MSG_DETAIL_TABLE.message_id>0 AND $M_MSG_DETAIL_TABLE.deleted==0  group by $M_MSG_DETAIL_TABLE.room_id"
//         "");
//     List<MessageDetails> list = res.isNotEmpty
//         ? res.map((m) => MessageDetails.fromJson(m)).toList()
//         : [];
//     return list;
//   }
// }
class DatabaseHelper {
  static final _databaseName = "ePanduChat.db";
  static final _databaseVersion = 1;
  static const String MESSAGE_AND_AUTHOR_TABLE = 'MessageAndAuthorTable';
  static const String MESSAGE_TARGET_TABLE = 'MessageTargetTable';
  static const String USER_TABLE = 'UserTable';
  static const String RELATIONSHIP_TABLE = 'RelationshipTable';
  static const String M_ROOM_TABLE = 'RoomTable';
  static const String M_ROOM_MEMBERS_TABLE = 'RoomMembersTable';
  static const String M_MSG_DETAIL_TABLE = 'MsgDetailTable';
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
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> deleteDB() async {
    try {
      String path = join(await getDatabasesPath(), _databaseName);
      print('deleting db');
      _database = null;
      deleteDatabase(path);
    } catch (e) {
      print(e.toString());
    }
    print('db is deleted');
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        " CREATE TABLE $MESSAGE_AND_AUTHOR_TABLE (id TEXT PRIMARY KEY, author TEXT,data TEXT,sent_date_time INTEGER,type TEXT,is_seen TEXT);");
    await db.execute(
        " CREATE TABLE $MESSAGE_TARGET_TABLE (id TEXT PRIMARY KEY, message_id TEXT, target_id TEXT);");
    await db.execute(
        " CREATE TABLE $USER_TABLE (id TEXT PRIMARY KEY, name TEXT,phone_number TEXT, picture_path TEXT);");
    await db.execute(
        " CREATE TABLE $RELATIONSHIP_TABLE (id TEXT PRIMARY KEY, host_id TEXT, friend_id TEXT, FOREIGN KEY (friend_id) REFERENCES $USER_TABLE (id) );");
    await db.execute(
        " CREATE TABLE $M_ROOM_TABLE (ID TEXT NOT NULL,room_id TEXT NOT NULL,app_code TEXT,merchant_user_id TEXT,merchant_login_id TEXT,merchant_nick_name TEXT,user_id TEXT,login_id TEXT,member_nick_name TEXT,room_name TEXT,room_desc TEXT,create_user TEXT,create_date TEXT,edit_user TEXT,edit_date TEXT,row_key TEXT,transtamp TEXT,deleted TEXT,photo_filename TEXT,profile_photo TEXT,merchant_no TEXT,picture_path  TEXT,owner_id TEXT);");
    await db.execute(
        " CREATE TABLE $M_ROOM_MEMBERS_TABLE (ID TEXT NOT NULL,room_id TEXT NOT NULL,app_code TEXT,user_id TEXT,login_id TEXT,user_type TEXT,create_user TEXT,create_date TEXT,edit_user TEXT,edit_date TEXT,row_key TEXT,transtamp TEXT,deleted TEXT,merchant_no TEXT,nick_name TEXT,picture_path TEXT,FOREIGN KEY (room_id) REFERENCES $M_ROOM_TABLE (room_id) );");
    await db.execute(
        " CREATE TABLE $M_MSG_DETAIL_TABLE (id INTEGER PRIMARY KEY AUTOINCREMENT,room_id TEXT NOT NULL,user_id TEXT NOT NULL,app_id TEXT,ca_uid TEXT,device_id TEXT,msg_body TEXT,msg_binary TEXT,msg_binaryType TEXT,reply_to_id INT,message_id INT,read_by TEXT ,status TEXT,status_msg TEXT,deleted INT,send_datetime TEXT,edit_datetime TEXT,delete_datetime TEXT,transtamp TEXT,filePath TEXT,owner_id TEXT,msgStatus TEXT,clientMessageId TEXT,nickName TEXT);");
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
      MessageAndAuthorTable messageAndAuthorTable) async {
    Database db = await instance.database;
    return await db.insert(MESSAGE_AND_AUTHOR_TABLE, {
      'id': messageAndAuthorTable.id,
      'author': messageAndAuthorTable.author,
      'data': messageAndAuthorTable.data,
      'sent_date_time': messageAndAuthorTable.sentDateTime,
      'type': messageAndAuthorTable.type,
      'isSeen': messageAndAuthorTable.isSeen
    });
  }

  Future<int> saveMessageTargetTable(
      MessageTargetTable messageTargetTable) async {
    Database db = await instance.database;
    return await db.insert(MESSAGE_TARGET_TABLE, {
      'id': messageTargetTable.id,
      'message_id': messageTargetTable.messageId,
      'target_id': messageTargetTable.targetId
    });
  }

  Future<int> saveUserTable(UserProfile userProfile) async {
    Database db = await instance.database;
    return await db.insert(USER_TABLE, {
      'id': userProfile.iD,
      'name': userProfile.name,
      'phone_number': userProfile.phone,
      'picture_path': userProfile.picturePath
    });
  }

  Future<int> saveRelationshipTable(
      String id, String hostID, String friendID) async {
    Database db = await instance.database;
    return await db.insert(RELATIONSHIP_TABLE,
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
        "SELECT $MESSAGE_AND_AUTHOR_TABLE.id AS id, $MESSAGE_AND_AUTHOR_TABLE.author AS author, $MESSAGE_AND_AUTHOR_TABLE.data AS data, $MESSAGE_AND_AUTHOR_TABLE.sent_date_time AS sent_date_time, $MESSAGE_AND_AUTHOR_TABLE.type AS type,$MESSAGE_AND_AUTHOR_TABLE.is_seen AS is_seen FROM $MESSAGE_AND_AUTHOR_TABLE INNER JOIN $MESSAGE_TARGET_TABLE ON $MESSAGE_TARGET_TABLE.message_id = $MESSAGE_AND_AUTHOR_TABLE.id where $MESSAGE_AND_AUTHOR_TABLE.author = '$userId' AND $MESSAGE_TARGET_TABLE.target_id = '$targetId' OR $MESSAGE_AND_AUTHOR_TABLE.author = '$targetId' AND $MESSAGE_TARGET_TABLE.target_id = '$userId' ORDER BY $MESSAGE_AND_AUTHOR_TABLE.send_datetime DESC LIMIT $startIndex,$noOfRecords ;");

    List<Message> messages = [];
    if (maps.length > 0) {
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
        "Select $USER_TABLE.id As user_id, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone, $USER_TABLE.picture_path As picture_path from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");
    List<UserProfile> users = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(UserProfile.fromJson(maps[i] as Map<String, dynamic>));
        //print("phone: ${users[i].iD}");
      }
    }
    //print(users.length);
    return users;
  }

  Future<UserProfile?> getSingleContact(
      {String? userId, String? friendId}) async {
    Database db = await instance.database;

    List<Map> maps = await db.rawQuery(
        "Select id As ID from $RELATIONSHIP_TABLE where host_id = '$userId' And friend_id = '$friendId' ");

    UserProfile? user;
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i] as Map<String, dynamic>);
      }
    }
    return user;
  }

  Future<UserProfile?> getSingleUser({String? userId}) async {
    Database db = await instance.database;
    List<Map> maps = await db
        .rawQuery("Select id As ID from $USER_TABLE where id = '$userId'");

    UserProfile? user;
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i] as Map<String, dynamic>);
      }
    }
    return user;
  }

  //Update query
  Future<int> updateMessageTargetTable(
      MessageTargetTable messageTargetTable) async {
    Database db = await instance.database;
    return await db.update(MESSAGE_TARGET_TABLE, messageTargetTable.toMap(),
        where: "id = ?", whereArgs: [messageTargetTable.id]);
  }

  //Delete query
  Future<int> deleteMessageTargetTable(int id) async {
    Database db = await instance.database;
    return await db
        .delete(MESSAGE_TARGET_TABLE, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> saveRoomTable(Room room) async {
    Database db = await instance.database;
    String? userId = await localStorage.getUserId();
    String roomId = room.room_id!;
    var res = await db.rawQuery(
        "Select room_id from $M_ROOM_TABLE where room_id = '$roomId'");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    if (list.length == 0) {
      print('RoomId_' + room.room_id!);
      return await db.insert(M_ROOM_TABLE, {
        'ID': room.ID,
        'room_id': room.room_id,
        'app_code': room.app_code,
        'merchant_user_id': room.merchant_user_id,
        'merchant_login_id': room.merchant_login_id,
        'merchant_nick_name': room.merchant_nick_name,
        'user_id': room.user_id,
        'login_id': room.login_id,
        'member_nick_name': room.member_nick_name,
        'room_name': room.room_name,
        'room_desc': room.room_desc,
        'create_user': room.create_user,
        'create_date': room.create_date,
        'edit_user': room.edit_user,
        'edit_date': room.edit_date,
        'row_key': room.row_key,
        'transtamp': room.transtamp,
        'deleted': room.deleted,
        'photo_filename': room.photo_filename,
        'profile_photo': room.profile_photo,
        'merchant_no': room.merchant_no,
        'picture_path': room.picture_path,
        'owner_id': userId
      });
    } else
      return 0;
  }

  // Future<List<Room>> getRoomList(String userId) async {
  //   Database db = await instance.database;
  //   var res = await db.query(M_ROOM_TABLE);

  //   List<Room> list =
  //       res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
  //   return list;
  // }

  Future<List<Room>> getRoomList(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $M_ROOM_MEMBERS_TABLE.user_id,$M_ROOM_TABLE.create_date, $M_ROOM_TABLE.room_id,$M_ROOM_TABLE.picture_path,$M_ROOM_TABLE.room_name,$M_ROOM_TABLE.room_desc from $M_ROOM_TABLE LEFT JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.room_id=$M_ROOM_TABLE.room_id  where $M_ROOM_MEMBERS_TABLE.user_id = '$userId';");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<RoomHistoryModel>> getRoomListWithMessage(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT   $M_ROOM_TABLE.room_id,$M_ROOM_TABLE.picture_path,$M_ROOM_TABLE.room_name,$M_ROOM_TABLE.room_desc,$M_MSG_DETAIL_TABLE.message_id,$M_MSG_DETAIL_TABLE.msg_body,$M_MSG_DETAIL_TABLE.msg_binaryType,$M_MSG_DETAIL_TABLE.filePath, $M_MSG_DETAIL_TABLE.nickName AS nick_name,$M_MSG_DETAIL_TABLE.send_datetime FROM $M_ROOM_TABLE  LEFT JOIN $M_MSG_DETAIL_TABLE on $M_MSG_DETAIL_TABLE.room_id=$M_ROOM_TABLE.room_id where $M_ROOM_TABLE.owner_id = '$userId' and $M_MSG_DETAIL_TABLE.deleted=0  group by $M_ROOM_TABLE.room_id order by max($M_MSG_DETAIL_TABLE.send_datetime) desc;");
    List<RoomHistoryModel> list = res.isNotEmpty
        ? res.map((m) => RoomHistoryModel.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<Room>> getRoomListDesc(String userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery("Select DISTINCT user_id,create_date,room_id,picture_path,room_name,room_desc,message FROM " +
        "(Select ROW_NUMBER() OVER (ORDER BY $M_MSG_DETAIL_TABLE.send_datetime desc) as RowNum,$M_ROOM_MEMBERS_TABLE.user_id,$M_ROOM_TABLE.create_date, $M_ROOM_TABLE.room_id,$M_ROOM_TABLE.picture_path,$M_ROOM_TABLE.room_name,$M_ROOM_TABLE.room_desc," +
        "(select $M_MSG_DETAIL_TABLE.msg_body from $M_MSG_DETAIL_TABLE  where $M_MSG_DETAIL_TABLE.room_id=$M_ROOM_TABLE.room_id) AS 'message'," +
        "(select $M_MSG_DETAIL_TABLE.send_datetime from $M_MSG_DETAIL_TABLE  where $M_MSG_DETAIL_TABLE.room_id=$M_ROOM_TABLE.room_id) AS 'send_datetime' " +
        "from $M_ROOM_TABLE" +
        " left JOIN $M_MSG_DETAIL_TABLE ON $M_ROOM_TABLE.room_id=$M_MSG_DETAIL_TABLE.room_id  " +
        "left JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.room_id=$M_ROOM_TABLE.room_id" +
        "WHERE $M_ROOM_MEMBERS_TABLE.user_id='$userId' ORDER BY $M_MSG_DETAIL_TABLE.send_datetime desc) AS T;");
    List<Room> list =
        res.isNotEmpty ? res.map((m) => Room.fromJson(m)).toList() : [];
    return list;
  }

  Future<int> saveRoomMembersTable(RoomMembers roomMembers) async {
    Database db = await instance.database;
    String roomId = roomMembers.room_id!;
    String roomMemberId = roomMembers.user_id!;
    var res = await db.rawQuery(
        "Select room_id from $M_ROOM_MEMBERS_TABLE where room_id = '$roomId' AND user_id = '$roomMemberId' ");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    if (list.length == 0) {
      return await db.insert(M_ROOM_MEMBERS_TABLE, {
        'ID': roomMembers.ID,
        'room_id': roomMembers.room_id,
        'app_code': roomMembers.app_code,
        'user_id': roomMembers.user_id,
        'login_id': roomMembers.login_id,
        'user_type': roomMembers.user_type,
        'create_user': roomMembers.create_user,
        'create_date': roomMembers.create_date,
        'edit_user': roomMembers.edit_user,
        'edit_date': roomMembers.edit_date,
        'row_key': roomMembers.row_key,
        'transtamp': roomMembers.transtamp,
        'deleted': roomMembers.deleted,
        'merchant_no': roomMembers.merchant_no,
        'nick_name': roomMembers.nick_name,
        'picture_path': roomMembers.picture_path
      });
    } else
      return 0;
  }

  Future<List<RoomMembers>> getRoomMembersList(String roomId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $M_ROOM_MEMBERS_TABLE.user_id as user_id, $M_ROOM_MEMBERS_TABLE.nick_name as nick_name,$M_ROOM_MEMBERS_TABLE.picture_path as picture_path,$M_ROOM_MEMBERS_TABLE.login_id as login_id,$M_ROOM_TABLE.room_name as room_name from $M_ROOM_MEMBERS_TABLE LEFT JOIN $M_ROOM_TABLE ON $M_ROOM_TABLE.room_id=$M_ROOM_MEMBERS_TABLE.room_id  where $M_ROOM_MEMBERS_TABLE.room_id = '$roomId' and $M_ROOM_MEMBERS_TABLE.deleted = 'false'   ORDER BY $M_ROOM_MEMBERS_TABLE.nick_name ASC;");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<RoomMembers>> getDistinctRoomMembersList() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $M_ROOM_MEMBERS_TABLE.user_id as user_id from $M_ROOM_MEMBERS_TABLE ");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<List<RoomMembers>> getRoomMemberName(String? userId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select nick_name from $M_ROOM_MEMBERS_TABLE where $M_ROOM_MEMBERS_TABLE.user_id = '$userId';");
    List<RoomMembers> list =
        res.isNotEmpty ? res.map((m) => RoomMembers.fromJson(m)).toList() : [];
    return list;
  }

  Future<int> updateRoomMemberPic(String? userId, String picturePath,
      String nickName, String deleted) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $M_ROOM_MEMBERS_TABLE SET picture_path = ?,nick_name = ?,deleted = ? where user_id = ?",
        [
          picturePath,
          nickName,
          deleted,
          userId,
        ]);
  }

  Future<int> updateRoomMemberName(String? userId, String nickName) async {
    Database db = await instance.database;
    await db.rawUpdate(
        "UPDATE $M_MSG_DETAIL_TABLE SET nickName = ? where user_id = ?",
        [nickName, userId]);
    return await db.rawUpdate(
        "UPDATE $M_ROOM_MEMBERS_TABLE SET nick_name = ? where user_id = ?", [
      nickName,
      userId,
    ]);
  }

  Future<int> updateRoomPic(String? roomId, String picturePath) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $M_ROOM_TABLE SET picture_path = ? where room_id = ?",
        [picturePath, roomId]);
  }

  Future<int> deleteRoom() async {
    Database db = await instance.database;
    return await db.delete(M_ROOM_TABLE);
  }

  Future<int> deleteRoomById(String roomId) async {
    Database db = await instance.database;
    // return await db
    //     .delete("$M_ROOM_TABLE  where room_id = ?", whereArgs: [roomId]);

    return await db
        .delete(M_ROOM_TABLE, where: 'room_id = ?', whereArgs: [roomId]);
  }

  Future<int> deleteRoomMembers() async {
    Database db = await instance.database;
    return await db.delete(M_ROOM_MEMBERS_TABLE);
  }

  Future<int> deleteRoomMembersByRoomId(String roomId) async {
    Database db = await instance.database;
    return await db.delete(M_ROOM_MEMBERS_TABLE,
        where: 'room_id = ?', whereArgs: [roomId]);
  }

  Future<int> deleteMessagesByRoomId(String roomId) async {
    Database db = await instance.database;
    return await db
        .delete(M_MSG_DETAIL_TABLE, where: 'room_id = ?', whereArgs: [roomId]);
  }

  Future<int> saveMsgDetailTable(MessageDetails messageDetails) async {
    Database db = await instance.database;
    String clientMessageId = messageDetails.client_message_id!;
    var res = await db.rawQuery(
        "Select user_id from $M_MSG_DETAIL_TABLE where clientMessageId = '$clientMessageId'");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    if (list.length == 0)
      return await db.insert(M_MSG_DETAIL_TABLE, {
        'room_id': messageDetails.room_id,
        'user_id': messageDetails.user_id,
        'app_id': messageDetails.app_id,
        'ca_uid': messageDetails.ca_uid,
        'device_id': messageDetails.device_id,
        'msg_body': messageDetails.msg_body,
        'msg_binary': messageDetails.msg_binary,
        'msg_binaryType': messageDetails.msg_binaryType,
        'reply_to_id': messageDetails.reply_to_id,
        'message_id': messageDetails.message_id,
        'read_by': messageDetails.read_by,
        'status': messageDetails.status,
        'status_msg': messageDetails.status_msg,
        'deleted': messageDetails.deleted,
        'send_datetime': messageDetails.send_datetime,
        'edit_datetime': messageDetails.edit_datetime,
        'delete_datetime': messageDetails.delete_datetime,
        'transtamp': messageDetails.transtamp,
        'filePath': messageDetails.filePath,
        'owner_id': messageDetails.owner_id,
        'msgStatus': messageDetails.msgStatus,
        'clientMessageId': messageDetails.client_message_id,
        'nickName': messageDetails.nick_name,
      });
    else
      return 0;
  }

  Future<int> updateMsgDetailTable(
      String clientMessageId, String msgStatus, int messageId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $M_MSG_DETAIL_TABLE SET msgStatus = ?,message_id = ?  where clientMessageId = ?",
        [msgStatus, messageId, clientMessageId]);
  }

  Future<int> updateMsgStatus(String msgStatus, int messageId) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $M_MSG_DETAIL_TABLE SET msgStatus = ? where message_id = ?",
        [msgStatus, messageId]);
  }

  Future<int> updateMsgDetailTableText(
      String msgBody, int messageId, String editDateTime) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $M_MSG_DETAIL_TABLE SET msg_body = ?,edit_datetime = ? where message_id = ?",
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
        "UPDATE $M_ROOM_TABLE SET room_name = ? where room_id = ?",
        [roomName, roomId]);
  }

  Future<int> deleteMsg(int messageId, String deletedTime) async {
    Database db = await instance.database;
    return await db.rawUpdate(
        "UPDATE $M_MSG_DETAIL_TABLE SET deleted = ?,delete_datetime = ?  where message_id = ?",
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
    return await db.delete(M_MSG_DETAIL_TABLE,
        where: 'message_id = ?', whereArgs: [messageId]);
  }

  Future<int> deleteMsgDetailTableByClientMessageId(
      String clientMessageId) async {
    Database db = await instance.database;
    return await db.delete(M_MSG_DETAIL_TABLE,
        where: 'clientMessageId = ?', whereArgs: [clientMessageId]);
  }

  Future<List<MessageDetails>> getLatestMsgDetail(String roomId) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select user_id,owner_id,room_id,reply_to_id,message_id,clientMessageId from $M_MSG_DETAIL_TABLE where room_id = '$roomId' AND message_id>0   ORDER BY message_id DESC LIMIT 1;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  // Future<List<MessageDetails>> getMsgDetailList(String roomId) async {
  //   Database db = await instance.database;
  //   var res = await db.rawQuery(
  //       "Select DISTINCT $M_MSG_DETAIL_TABLE.room_id as room_id,$M_MSG_DETAIL_TABLE.user_id as user_id,$M_MSG_DETAIL_TABLE.msg_body as msg_body,$M_MSG_DETAIL_TABLE.msg_binaryType as msg_binaryType,$M_MSG_DETAIL_TABLE.send_datetime as send_datetime,$M_MSG_DETAIL_TABLE.reply_to_id as reply_to_id,$M_MSG_DETAIL_TABLE.filePath as filePath,$M_MSG_DETAIL_TABLE.msgStatus as msgStatus,$M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.clientMessageId as client_message_id,$M_ROOM_MEMBERS_TABLE.nick_name as nick_name from $M_MSG_DETAIL_TABLE LEFT JOIN $M_ROOM_MEMBERS_TABLE ON $M_ROOM_MEMBERS_TABLE.user_id=$M_MSG_DETAIL_TABLE.user_id  where $M_MSG_DETAIL_TABLE.room_id = '$roomId' and $M_MSG_DETAIL_TABLE.deleted == 0  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime ASC;");
  //   List<MessageDetails> list = res.isNotEmpty
  //       ? res.map((m) => MessageDetails.fromJson(m)).toList()
  //       : [];
  //   return list;
  // }
  Future<List<MessageDetails>> getMsgDetailList() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $M_MSG_DETAIL_TABLE.room_id as room_id,$M_MSG_DETAIL_TABLE.user_id as user_id,$M_MSG_DETAIL_TABLE.msg_body as msg_body,$M_MSG_DETAIL_TABLE.msg_binaryType as msg_binaryType,$M_MSG_DETAIL_TABLE.send_datetime as send_datetime,$M_MSG_DETAIL_TABLE.reply_to_id as reply_to_id,$M_MSG_DETAIL_TABLE.filePath as filePath,$M_MSG_DETAIL_TABLE.msgStatus as msgStatus,$M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.clientMessageId as client_message_id,$M_MSG_DETAIL_TABLE.nickName as nick_name from $M_MSG_DETAIL_TABLE  where  $M_MSG_DETAIL_TABLE.deleted == 0  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime ASC;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getAllMsgDetail() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.user_id as user_id from $M_MSG_DETAIL_TABLE  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime ASC;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getFailedMsgDetailList() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select $M_MSG_DETAIL_TABLE.room_id as 'room_id',$M_MSG_DETAIL_TABLE.msg_body as 'msg_body',$M_MSG_DETAIL_TABLE.filePath as 'filePath',$M_MSG_DETAIL_TABLE.reply_to_id as 'reply_to_id',$M_MSG_DETAIL_TABLE.msg_binaryType as 'msg_binaryType',$M_MSG_DETAIL_TABLE.clientMessageId as 'client_message_id',$M_ROOM_TABLE.room_name as 'roomName'  from $M_MSG_DETAIL_TABLE LEFT JOIN $M_ROOM_TABLE ON $M_ROOM_TABLE.room_id=$M_MSG_DETAIL_TABLE.room_id   where msgStatus = 'SENDING';");

    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<int> deleteMsgDetail() async {
    Database db = await instance.database;
    return await db.delete(M_MSG_DETAIL_TABLE);
  }

  Future<List<MessageDetails>> getLatestMsgToEachRoom() async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT MAX($M_MSG_DETAIL_TABLE.message_id) as 'message_id',$M_MSG_DETAIL_TABLE.msg_binarytype,$M_MSG_DETAIL_TABLE.msg_body,$M_MSG_DETAIL_TABLE.room_id,$M_MSG_DETAIL_TABLE.send_datetime,$M_ROOM_MEMBERS_TABLE.nick_name,$M_MSG_DETAIL_TABLE.filePath FROM $M_MSG_DETAIL_TABLE left join $M_ROOM_MEMBERS_TABLE on $M_ROOM_MEMBERS_TABLE.room_id=$M_MSG_DETAIL_TABLE.room_id and $M_ROOM_MEMBERS_TABLE.user_id=$M_MSG_DETAIL_TABLE.user_id where $M_MSG_DETAIL_TABLE.msgStatus NOT IN ('SENDING','FAILED') AND $M_MSG_DETAIL_TABLE.message_id>0 AND $M_MSG_DETAIL_TABLE.deleted==0  group by $M_MSG_DETAIL_TABLE.room_id"
        "");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }

  Future<List<MessageDetails>> getLazyLoadMsgDetailList(
      String roomId, int batchSize, int offset) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "Select DISTINCT $M_MSG_DETAIL_TABLE.room_id as room_id,$M_MSG_DETAIL_TABLE.user_id as user_id,$M_MSG_DETAIL_TABLE.msg_body as msg_body,$M_MSG_DETAIL_TABLE.msg_binaryType as msg_binaryType,$M_MSG_DETAIL_TABLE.send_datetime as send_datetime,$M_MSG_DETAIL_TABLE.reply_to_id as reply_to_id,$M_MSG_DETAIL_TABLE.filePath as filePath,$M_MSG_DETAIL_TABLE.msgStatus as msgStatus,$M_MSG_DETAIL_TABLE.message_id as message_id,$M_MSG_DETAIL_TABLE.clientMessageId as client_message_id,$M_MSG_DETAIL_TABLE.nickName as nick_name from $M_MSG_DETAIL_TABLE  where  $M_MSG_DETAIL_TABLE.deleted == 0 and $M_MSG_DETAIL_TABLE.room_id = '$roomId'  ORDER BY $M_MSG_DETAIL_TABLE.send_datetime DESC LIMIT $batchSize OFFSET $offset;");
    List<MessageDetails> list = res.isNotEmpty
        ? res.map((m) => MessageDetails.fromJson(m)).toList()
        : [];
    return list;
  }
}
