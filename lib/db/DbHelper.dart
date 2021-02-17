import 'package:flutter_application_281/model/Movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  String _tableName = "movies";

  DbHelper._getInstance();

  static DbHelper _helper;

  factory DbHelper() {
    if (_helper == null) {
      _helper = DbHelper._getInstance();
    }
    return _helper;
  }

  Future<String> _getDBPath() async {
    return await getDatabasesPath();
  }

  Future<Database> createDB() async {
    String path = await _getDBPath();
    String dbPath = join(path, 'movies.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
       // String sql ="create table movies (id integer )";
       String sql =
            'CREATE TABLE movies (id INTEGER)';
            try{
        db.execute(sql);} catch(e){
          print("error $e");
        }
        
        print("done open");
      },
    );
  }

  Future<int> insertMovie(Movie movie) async {
    var db = await createDB();
    var row = db.insert(_tableName, movie.toMap());
    return row;
  }

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    var db = await createDB();
    return db.query(_tableName);
  }

  Future<int>deleteMovie(Movie movie) async {
    var db = await createDB();
    return db.delete(_tableName,where: 'id=?', whereArgs: [movie.id]);
  }

}
