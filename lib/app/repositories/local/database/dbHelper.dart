import 'package:path/path.dart';
import 'package:salgadar_app/app/shared/utils/consts.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // Scripts de criacao das tabelas, sem autoincrement, pois apenas fazem cache.
  static const SCRIPT_CREATE_TABLE_USER_SQL =
      "CREATE TABLE IF NOT EXISTS $TABLE_USER_NAME ("
      "$USER_ID INTEGER NOT NULL,"
      "$USER_USERNAME TEXT NOT NULL,"
      "$USER_PASSWORD TEXT NOT NULL,"
      "$USER_NAME TEXT NOT NULL,"
      "$USER_BIRTHDAY TEXT NOT NULL,"
      "$USER_EMAIL TEXT NOT NULL,"
      "PRIMARY KEY($USER_ID)"
      ")";

  static const SCRIPT_CREATE_TABLE_ITEM_SQL =
      "CREATE TABLE IF NOT EXISTS $TABLE_ITEM_NAME ("
      "$ITEM_ID INTEGER NOT NULL,"
      "$ITEM_NAME TEXT NOT NULL,"
      "$ITEM_DESCRIPTION TEXT NOT NULL,"
      "$ITEM_IMAGE TEXT NOT NULL,"
      "$ITEM_CATEGORY TEXT NOT NULL,"
      "$ITEM_SUBCATEGORY TEXT NOT NULL,"
      "$ITEM_PRICE REAL NOT NULL,"
      "PRIMARY KEY($ITEM_ID)"
      ")";

  static const SCRIPT_CREATE_TABLE_CART_SQL =
      "CREATE TABLE IF NOT EXISTS $TABLE_CART_NAME ("
      "$CART_ID INTEGER NOT NULL,"
      "PRIMARY KEY($CART_ID)"
      ")";

  static const SCRIPT_CREATE_TABLE_ITEM_CART_SQL =
      "CREATE TABLE IF NOT EXISTS $TABLE_ITEM_CART_NAME ("
      "$ITEM_CART_ITEMID INTEGER NOT NULL,"
      "$ITEM_CART_CARTID INTEGER NOT NULL,"
      "$ITEM_CART_QTT INTEGER NOT NULL,"
      "$ITEM_CART_ITEMPRICE REAL NOT NULL,"
      "FOREIGN KEY($ITEM_CART_ITEMID) REFERENCES $TABLE_ITEM_NAME($ITEM_ID),"
      "FOREIGN KEY($ITEM_CART_CARTID) REFERENCES $TABLE_CART_NAME($CART_ID)"
      ")";

  static const SCRIPT_CREATE_TABLE_PURCHASE_SQL =
      "CREATE TABLE IF NOT EXISTS $TABLE_PURCHASE_NAME ("
      "$PURCHASE_ID INTEGER NOT NULL,"
      "$PURCHASE_USERID INTEGER NOT NULL,"
      "$PURCHASE_CARTID INTEGER NOT NULL,"
      "$PURCHASE_TOTALVALUE REAL NOT NULL,"
      "$PURCHASE_TOTALQTT INTEGER NOT NULL,"
      "$PURCHASE_DATE STRING NOT NULL,"
      "$PURCHASE_ISDELETED BLOB NOT NULL,"
      "PRIMARY KEY($PURCHASE_ID),"
      "FOREIGN KEY($PURCHASE_USERID) REFERENCES $TABLE_USER_NAME($USER_ID),"
      "FOREIGN KEY($PURCHASE_CARTID) REFERENCES $TABLE_CART_NAME($CART_ID)"
      ")";

  /// Execucao dos scripts na inicializacao do banco.
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(SCRIPT_CREATE_TABLE_USER_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_ITEM_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_CART_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_ITEM_CART_SQL);
        await db.execute(SCRIPT_CREATE_TABLE_PURCHASE_SQL);
      },
      version: 1,
    );
  }

  /// Reinicia todas as tabelas do banco.
  static Future<void> reinitializeTables() async {
    try {
      final db = await getDatabase();
      // Drop
      await db.execute("DROP TABLE IF EXISTS $TABLE_ITEM_NAME");
      await db.execute("DROP TABLE IF EXISTS $TABLE_USER_NAME");
      await db.execute("DROP TABLE IF EXISTS $TABLE_ITEM_CART_NAME");
      await db.execute("DROP TABLE IF EXISTS $TABLE_CART_NAME");
      await db.execute("DROP TABLE IF EXISTS $TABLE_PURCHASE_NAME");

      // Create
      await db.execute(SCRIPT_CREATE_TABLE_USER_SQL);
      await db.execute(SCRIPT_CREATE_TABLE_ITEM_SQL);
      await db.execute(SCRIPT_CREATE_TABLE_CART_SQL);
      await db.execute(SCRIPT_CREATE_TABLE_ITEM_CART_SQL);
      await db.execute(SCRIPT_CREATE_TABLE_PURCHASE_SQL);
    } catch (ex) {
      print("DBEXCEPTION: $ex");
    }
  }

  /// Reinicia uma tabela do banco.
  static Future<void> reinitializeTable({String tableName, String scriptCreateTable}) async {
    try {
      final db = await getDatabase();
      // Drop
      await db.execute("DROP TABLE IF EXISTS $tableName");

      // Create
      await db.execute(scriptCreateTable);
    } catch (ex) {
      print("DBEXCEPTION: $ex");
    }
  }


}
