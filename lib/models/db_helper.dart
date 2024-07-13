import 'package:path/path.dart';
import 'package:quotes_app/models/quotes_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper dbHelper = DbHelper._();
  Database? db;

  Future<void> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "quote.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String category_table_query =
            "CREATE TABLE IF NOT EXISTS quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT NOT NULL UNIQUE, author TEXT NOT NULL UNIQUE);";
        await db.execute(category_table_query);

        String ie_table_query =
            "CREATE TABLE IF NOT EXISTS likedquotes(id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT NOT NULL UNIQUE, author TEXT NOT NULL UNIQUE);";

        await db.execute(ie_table_query);
      },
    );
  }

  Future<int> InsertlikedQuotes({
    required String q,
    required String a,
  }) async {
    if (db == null) {
      await initDB();
    }
    String query = "INSERT INTO likedquotes(quote, author) VALUES(?, ?);";

    List args = [q, a];

    return await db!.rawInsert(query, args); // returns the inserted record's id
  }

  // select all category data
  Future<List<QuotesModel>> selectlikedq() async {
    if (db == null) {
      await initDB();
    }

    String query = "SELECT * FROM likedquotes;";

    List<Map<String, dynamic>>? data = await db?.rawQuery(query);

    if (data != null) {
      // convert dart object to custom object
      List<QuotesModel> alllikedq = data
          .map((Map<String, dynamic> e) => QuotesModel.fromMap(data: e))
          .toList();

      return alllikedq;
    } else {
      return [];
    }
  }

  Future<int?> deleteQuote({required int id}) async {
    if (db == null) {
      await initDB();
    }

    String query = "DELETE FROM likedquotes WHERE id=?;";
    List args = [id];

    return await db?.rawDelete(query,
        args); // returns an int with value 1 (total no. of deleted records)
  }
}
