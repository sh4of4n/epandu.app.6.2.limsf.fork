import 'dart:async';
import 'dart:io' as io;
import 'package:epandu/common_library/services/model/chat_model.dart';
import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ChatDatabase {
  Database? _db;
  static const String id = 'id';
  static const String name = 'name';
  static const String messageAndAuthorTable = 'MessageAndAuthorTable';
  static const String messageTargetTable = 'MessageTargetTable';
  static const String userTable = 'UserTable';
  static const String relationshipTable = 'RelationshipTable';

  static const String dbName = 'ePanduChat.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $messageAndAuthorTable (id TEXT PRIMARY KEY, author TEXT,data TEXT,sent_date_time INTEGER,type TEXT,is_seen TEXT);");
    await db.execute(
        " CREATE TABLE $messageTargetTable (id TEXT PRIMARY KEY, message_id TEXT, target_id TEXT);");
    await db.execute(
        " CREATE TABLE $userTable (id TEXT PRIMARY KEY, name TEXT,phone_number TEXT, picture_path TEXT);");
    await db.execute(
        " CREATE TABLE $relationshipTable (id TEXT PRIMARY KEY, host_id TEXT, friend_id TEXT, FOREIGN KEY (friend_id) REFERENCES $userTable (id) );");
  }

  //Insert Query
  Future<int> saveMessageAndAuthorTable(
      MessageAndAuthorTable messageAndAuthorTable) async {
    var dbClient = await (db as FutureOr<Database>);

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $messageAndAuthorTable (id,author,data,sent_date_time,type,is_seen) VALUES ('${messageAndAuthorTable.id}','${messageAndAuthorTable.author}','${messageAndAuthorTable.data}','${messageAndAuthorTable.sentDateTime}','${messageAndAuthorTable.type}','${messageAndAuthorTable.isSeen}')";
      return await txn.rawInsert(query);
    });

    return 1;
  }

  Future<int> saveMessageTargetTable(
      MessageTargetTable messageTargetTable) async {
    var dbClient = await (db as FutureOr<Database>);

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $messageTargetTable (id,message_id,target_id) VALUES ('${messageTargetTable.id}','${messageTargetTable.messageId}','${messageTargetTable.targetId}')";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  Future<int> saveUserTable(UserProfile userProfile) async {
    var dbClient = await (db as FutureOr<Database>);
    String? picturePath = userProfile.picturePath;
    if (userProfile.picturePath == null || userProfile.picturePath!.isEmpty) {
      picturePath = "";
    }
    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $userTable (id,name,phone_number,picture_path) VALUES ('${userProfile.userId}','${userProfile.name}','${userProfile.phone}','$picturePath');";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  Future<int> saveRelationshipTable(
      String id, String hostID, String friendID) async {
    var dbClient = await (db as FutureOr<Database>);

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $relationshipTable (id,host_id,friend_id) VALUES ('$id','$hostID','$friendID')";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  //Read Query
  Future<List<Message>> getMessageAndAuthorTable(
      {String? userId,
      String? targetId,
      int? startIndex,
      int? noOfRecords}) async {
    var dbClient = await (db as FutureOr<Database>);
    List<Map> maps = await dbClient.rawQuery(
        "SELECT $messageAndAuthorTable.id AS id, $messageAndAuthorTable.author AS author, $messageAndAuthorTable.data AS data, $messageAndAuthorTable.sent_date_time AS sent_date_time, $messageAndAuthorTable.type AS type,$messageAndAuthorTable.is_seen AS is_seen FROM $messageAndAuthorTable INNER JOIN $messageTargetTable ON $messageTargetTable.message_id = $messageAndAuthorTable.id where $messageAndAuthorTable.author = '$userId' AND $messageTargetTable.target_id = '$targetId' OR $messageAndAuthorTable.author = '$targetId' AND $messageTargetTable.target_id = '$userId' ORDER BY $messageAndAuthorTable.sent_date_time DESC LIMIT $startIndex,$noOfRecords ;");
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
    var dbClient = await (db as FutureOr<Database>);
    List<Map> maps = await dbClient.rawQuery(
        "Select $userTable.id As user_id, $userTable.name As name, $userTable.phone_number As phone, $userTable.picture_path As picture_path from $userTable Inner Join $relationshipTable On $userTable.id = $relationshipTable.friend_id where $relationshipTable.host_id = '$userId'  ORDER BY $userTable.name LIMIT $startIndex,$noOfRecords;");

    /*
    List<Map> maps = await dbClient.rawQuery(
        "Select friend_id As user_id from $RELATIONSHIP_TABLE where host_id = '$userId' LIMIT $startIndex,$noOfRecords;");
    */

    List<UserProfile> users = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        users.add(UserProfile.fromJson(maps[i] as Map<String, dynamic>));
        print("phone: ${users[i].iD}");
      }
    }
    print(users.length);
    return users;
  }

  Future<UserProfile?> getSingleContact(
      {String? userId, String? friendId}) async {
    var dbClient = await (db as FutureOr<Database>);
    /*List<Map> maps = await dbClient.rawQuery(
        "Select $USER_TABLE.id As iD, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");
    */
    List<Map> maps = await dbClient.rawQuery(
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
    var dbClient = await (db as FutureOr<Database>);
    /*List<Map> maps = await dbClient.rawQuery(
        "Select $USER_TABLE.id As iD, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");
    */
    List<Map> maps = await dbClient
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
    var dbClient = await (db as FutureOr<Database>);
    return await dbClient.update(messageTargetTable, messageTarget.toMap(),
        where: '$id = ?', whereArgs: [messageTarget.id]);
  }

  //Delete query
  Future<int> deleteMessageTargetTable(int id) async {
    var dbClient = await (db as FutureOr<Database>);
    return await dbClient
        .delete(messageTargetTable, where: '$id = ?', whereArgs: [id]);
  }
}
