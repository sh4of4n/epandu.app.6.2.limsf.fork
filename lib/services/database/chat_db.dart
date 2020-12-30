import 'dart:async';
import 'dart:io' as io;
import 'package:epandu/common_library/services/model/chat_model.dart';
import 'package:epandu/common_library/services/model/profile_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ChatDatabase {
  Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String MESSAGE_AND_AUTHOR_TABLE = 'MessageAndAuthorTable';
  static const String MESSAGE_TARGET_TABLE = 'MessageTargetTable';
  static const String USER_TABLE = 'UserTable';
  static const String RELATIONSHIP_TABLE = 'RelationshipTable';

  static const String DB_NAME = 'ePanduChat.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $MESSAGE_AND_AUTHOR_TABLE (id TEXT PRIMARY KEY, author TEXT,data TEXT,sent_date_time INTEGER,type TEXT,is_seen TEXT);");
    await db.execute(
        " CREATE TABLE $MESSAGE_TARGET_TABLE (id TEXT PRIMARY KEY, message_id TEXT, target_id TEXT);");
    await db.execute(
        " CREATE TABLE $USER_TABLE (id TEXT PRIMARY KEY, name TEXT,phone_number TEXT, picture_path TEXT);");
    await db.execute(
        " CREATE TABLE $RELATIONSHIP_TABLE (id TEXT PRIMARY KEY, host_id TEXT, friend_id TEXT, FOREIGN KEY (friend_id) REFERENCES $USER_TABLE (id) );");
  }

  //Insert Query
  Future<int> saveMessageAndAuthorTable(
      MessageAndAuthorTable messageAndAuthorTable) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $MESSAGE_AND_AUTHOR_TABLE (id,author,data,sent_date_time,type,is_seen) VALUES ('${messageAndAuthorTable.id}','${messageAndAuthorTable.author}','${messageAndAuthorTable.data}','${messageAndAuthorTable.sentDateTime}','${messageAndAuthorTable.type}','${messageAndAuthorTable.isSeen}')";
      return await txn.rawInsert(query);
    });

    return 1;
  }

  Future<int> saveMessageTargetTable(
      MessageTargetTable messageTargetTable) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $MESSAGE_TARGET_TABLE (id,message_id,target_id) VALUES ('${messageTargetTable.id}','${messageTargetTable.messageId}','${messageTargetTable.targetId}')";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  Future<int> saveUserTable(UserProfile userProfile) async {
    var dbClient = await db;
    String picturePath = userProfile.picturePath;
    if (userProfile.picturePath == null || userProfile.picturePath.isEmpty) {
      picturePath = "";
    }
    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $USER_TABLE (id,name,phone_number,picture_path) VALUES ('${userProfile.userId}','${userProfile.name}','${userProfile.phone}','$picturePath');";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  Future<int> saveRelationshipTable(
      String id, String hostID, String friendID) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $RELATIONSHIP_TABLE (id,host_id,friend_id) VALUES ('$id','$hostID','$friendID')";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  //Read Query
  Future<List<Message>> getMessageAndAuthorTable(
      {String userId, String targetId, int startIndex, int noOfRecords}) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT $MESSAGE_AND_AUTHOR_TABLE.id AS id, $MESSAGE_AND_AUTHOR_TABLE.author AS author, $MESSAGE_AND_AUTHOR_TABLE.data AS data, $MESSAGE_AND_AUTHOR_TABLE.sent_date_time AS sent_date_time, $MESSAGE_AND_AUTHOR_TABLE.type AS type,$MESSAGE_AND_AUTHOR_TABLE.is_seen AS is_seen FROM $MESSAGE_AND_AUTHOR_TABLE INNER JOIN $MESSAGE_TARGET_TABLE ON $MESSAGE_TARGET_TABLE.message_id = $MESSAGE_AND_AUTHOR_TABLE.id where $MESSAGE_AND_AUTHOR_TABLE.author = '$userId' AND $MESSAGE_TARGET_TABLE.target_id = '$targetId' OR $MESSAGE_AND_AUTHOR_TABLE.author = '$targetId' AND $MESSAGE_TARGET_TABLE.target_id = '$userId' ORDER BY $MESSAGE_AND_AUTHOR_TABLE.sent_date_time DESC LIMIT $startIndex,$noOfRecords ;");
    List<Message> messages = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        messages.add(Message.fromJson(maps[maps.length - 1 - i]));
      }
    }
    return messages;
  }

  Future<List<UserProfile>> getContactList(
      {String userId, int startIndex, int noOfRecords}) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "Select $USER_TABLE.id As user_id, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone, $USER_TABLE.picture_path As picture_path from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");

    /*
    List<Map> maps = await dbClient.rawQuery(
        "Select friend_id As user_id from $RELATIONSHIP_TABLE where host_id = '$userId' LIMIT $startIndex,$noOfRecords;");
    */

    List<UserProfile> users = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(UserProfile.fromJson(maps[i]));
        print("phone: ${users[i].iD}");
      }
    }
    print(users.length);
    return users;
  }

  Future<UserProfile> getSingleContact({String userId, String friendId}) async {
    var dbClient = await db;
    /*List<Map> maps = await dbClient.rawQuery(
        "Select $USER_TABLE.id As iD, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");
    */
    List<Map> maps = await dbClient.rawQuery(
        "Select id As ID from $RELATIONSHIP_TABLE where host_id = '$userId' And friend_id = '$friendId' ");

    UserProfile user;
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i]);
      }
    }
    return user;
  }

  Future<UserProfile> getSingleUser({String userId}) async {
    var dbClient = await db;
    /*List<Map> maps = await dbClient.rawQuery(
        "Select $USER_TABLE.id As iD, $USER_TABLE.name As name, $USER_TABLE.phone_number As phone from $USER_TABLE Inner Join $RELATIONSHIP_TABLE On $USER_TABLE.id = $RELATIONSHIP_TABLE.friend_id where $RELATIONSHIP_TABLE.host_id = '$userId'  ORDER BY $USER_TABLE.name LIMIT $startIndex,$noOfRecords;");
    */
    List<Map> maps = await dbClient
        .rawQuery("Select id As ID from $USER_TABLE where id = '$userId'");

    UserProfile user;
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i]);
      }
    }
    return user;
  }

  //Update query
  Future<int> updateMessageTargetTable(
      MessageTargetTable messageTargetTable) async {
    var dbClient = await db;
    return await dbClient.update(
        MESSAGE_TARGET_TABLE, messageTargetTable.toMap(),
        where: '$ID = ?', whereArgs: [messageTargetTable.id]);
  }

  //Delete query
  Future<int> deleteMessageTargetTable(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(MESSAGE_TARGET_TABLE, where: '$ID = ?', whereArgs: [id]);
  }
}
