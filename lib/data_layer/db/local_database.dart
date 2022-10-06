import 'package:provider_working/data_layer/db/cached_users.dart';
import 'package:provider_working/data_layer/models/user_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';


class LocalDatabase{
  static final LocalDatabase getInstance=LocalDatabase._init();

  static Database?_database;

  factory LocalDatabase(){
    return getInstance;
  }

  Future<Database> get database async{
    if(_database!=null){
      return _database!;
    }else {
      _database =await _initDB("users.db");
      return _database!;
    }
  }
  Future<Database> _initDB(String filePath) async{
    final dbPath= await getDatabasesPath();
    final path= join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  Future _createDB(Database db, int version) async{
    const idType="INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType="TEXT NOT NULL";
    const intType="INTEGER DEFAULT 0";
    const boolType="BOOLEAN NOT NULL";

    await db.execute('''
    CREATE TABLE $userTable(
    ${CachedUserFields.id} $idType,
    ${CachedUserFields.name} $textType,
    ${CachedUserFields.age} $intType,   
    ${CachedUserFields.count} $intType

   
    )
    ''');
    await db.close();
  }

  LocalDatabase._init();
//----------------------------------Cached Company Table------------------

  // Kiritish
  static Future<CachedUser> insertCachedUser(CachedUser cachedUser)async{
    final db= await getInstance.database;
    final id =await db.insert(userTable, cachedUser.toJson());
    return cachedUser.copyWith(id: id);
  }

  // From Api
  static Future<CachedUser> insertCachedUserFromApi(UserData userData)async{
    final db= await getInstance.database;
    CachedUser cachedUser =CachedUser( name: userData.name, age: userData.age, count: userData.count);
    final id =await db.insert(userTable, cachedUser.toJson());
    return cachedUser.copyWith(id: id);
  }
// Hamma datani olish
  static Future<List<CachedUser>> getAllCachedUser()async{
    final db= await getInstance.database;
    const orderBy= CachedUserFields.name;
    final result =await db.query(userTable, orderBy: orderBy);
    return result.map((json) => CachedUser.fromJson(json)).toList();
  }
// Hammasini o'chirish
  static Future<int> deleteAllCachedUsers() async {
    final db = await getInstance.database;
    return await db.delete(userTable);
  }
  // Id bo'yich o'chirish
  static Future<int> deleteCachedUserById(int id) async {
    final db = await getInstance.database;
    var t = await db
        .delete(userTable, where: "${CachedUserFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  // Yangilash
  static Future<int> updateCachedUser(CachedUser cachedUser) async {
    Map<String, dynamic> row = {
      CachedUserFields.name: cachedUser.name,
      CachedUserFields.age: cachedUser.age,
      CachedUserFields.count: cachedUser.count
    };

    final db = await getInstance.database;
    return await db.update(
      userTable,
      row,
      where: '${CachedUserFields.id} = ?',
      whereArgs: [cachedUser.id],
    );
  }


}