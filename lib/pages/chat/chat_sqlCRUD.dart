import 'dart:async';
import 'dart:io' as io;
import 'package:epandu/services/api/model/chat_model.dart';
import 'package:epandu/services/api/model/profile_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TABLE1 = 'MessageAndAuthorTable';
  static const String TABLE2 = 'MessageTargetTable';
  static const String TABLE3 = 'UserTable';
  static const String TABLE4 = 'RelationshipTable';

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
        "CREATE TABLE $TABLE1 (id TEXT PRIMARY KEY, author TEXT,data TEXT,sent_date_time INTEGER,type TEXT,is_seen TEXT);");
    await db.execute(
        " CREATE TABLE $TABLE2 (id TEXT PRIMARY KEY, message_id TEXT, target_id TEXT);");
    await db.execute(
        " CREATE TABLE $TABLE3 (id TEXT PRIMARY KEY, name TEXT,phone_number TEXT, picture_path TEXT);");
    await db.execute(
        " CREATE TABLE $TABLE4 (id TEXT PRIMARY KEY, host_id TEXT, friend_id TEXT, FOREIGN KEY (friend_id) REFERENCES $TABLE3 (id) );");
  }

  //Insert Query
  Future<int> saveTable1(MessageAndAuthorTable messageAndAuthorTable) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $TABLE1 (id,author,data,sent_date_time,type,is_seen) VALUES ('${messageAndAuthorTable.id}','${messageAndAuthorTable.author}','${messageAndAuthorTable.data}','${messageAndAuthorTable.sentDateTime}','${messageAndAuthorTable.type}','${messageAndAuthorTable.isSeen}')";
      return await txn.rawInsert(query);
    });

    return 1;
  }

  Future<int> saveTable2(MessageTargetTable messageTargetTable) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $TABLE2 (id,message_id,target_id) VALUES ('${messageTargetTable.id}','${messageTargetTable.messageId}','${messageTargetTable.targetId}')";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  Future<int> saveTable3(UserProfile userProfile) async {
    var dbClient = await db;
    String picturePath = userProfile.picturePath;
    if (userProfile.picturePath == null || userProfile.picturePath.isEmpty) {
      picturePath = "";
    }
    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $TABLE3 (id,name,phone_number,picture_path) VALUES ('${userProfile.userId}','${userProfile.name}','${userProfile.phone}','$picturePath');";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  Future<int> saveTable4(String id, String hostID, String friendID) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      var query =
          "INSERT INTO $TABLE4 (id,host_id,friend_id) VALUES ('$id','$hostID','$friendID')";
      return await txn.rawInsert(query);
    });
    return 1;
  }

  //Read Query

  Future<List<Message>> getMessagesTable1(
      {String selfId, String targetId, int startIndex, int noOfRecords}) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT $TABLE1.id AS id, $TABLE1.author AS author, $TABLE1.data AS data, $TABLE1.sent_date_time AS sent_date_time, $TABLE1.type AS type,$TABLE1.is_seen AS is_seen FROM $TABLE1 INNER JOIN $TABLE2 ON $TABLE2.message_id = $TABLE1.id where $TABLE1.author = '$selfId' AND $TABLE2.target_id = '$targetId' OR $TABLE1.author = '$targetId' AND $TABLE2.target_id = '$selfId' ORDER BY $TABLE1.sent_date_time DESC LIMIT $startIndex,$noOfRecords ;");
    List<Message> messages = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        messages.add(Message.fromJson(maps[maps.length - 1 - i]));
      }
    }
    return messages;
  }

  Future<List<UserProfile>> getContactList(
      {String selfId, int startIndex, int noOfRecords}) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "Select $TABLE3.id As user_id, $TABLE3.name As name, $TABLE3.phone_number As phone, $TABLE3.picture_path As picture_path from $TABLE3 Inner Join $TABLE4 On $TABLE3.id = $TABLE4.friend_id where $TABLE4.host_id = '$selfId'  ORDER BY $TABLE3.name LIMIT $startIndex,$noOfRecords;");

    /*
    List<Map> maps = await dbClient.rawQuery(
        "Select friend_id As user_id from $TABLE4 where host_id = '$selfId' LIMIT $startIndex,$noOfRecords;");
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

  Future<UserProfile> getSingleContact({String selfId, String friendId}) async {
    var dbClient = await db;
    /*List<Map> maps = await dbClient.rawQuery(
        "Select $TABLE3.id As iD, $TABLE3.name As name, $TABLE3.phone_number As phone from $TABLE3 Inner Join $TABLE4 On $TABLE3.id = $TABLE4.friend_id where $TABLE4.host_id = '$selfId'  ORDER BY $TABLE3.name LIMIT $startIndex,$noOfRecords;");
    */
    List<Map> maps = await dbClient.rawQuery(
        "Select id As ID from $TABLE4 where host_id = '$selfId' And friend_id = '$friendId' ");

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
        "Select $TABLE3.id As iD, $TABLE3.name As name, $TABLE3.phone_number As phone from $TABLE3 Inner Join $TABLE4 On $TABLE3.id = $TABLE4.friend_id where $TABLE4.host_id = '$selfId'  ORDER BY $TABLE3.name LIMIT $startIndex,$noOfRecords;");
    */
    List<Map> maps = await dbClient
        .rawQuery("Select id As ID from $TABLE3 where id = '$userId'");

    UserProfile user;
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user = UserProfile.fromJson(maps[i]);
      }
    }
    return user;
  }

  //Delete query

  Future<int> deleteTable2(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE2, where: '$ID = ?', whereArgs: [id]);
  }

  //Update query

  Future<int> updateTable2(MessageTargetTable messageTargetTable) async {
    var dbClient = await db;
    return await dbClient.update(TABLE2, messageTargetTable.toMap(),
        where: '$ID = ?', whereArgs: [messageTargetTable.id]);
  }
}
