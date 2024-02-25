import 'package:flora1/db/db_functions/data_model.dart';
import 'package:sqflite/sqflite.dart';

late Database db;
Future<void> opendb() async {
  print("Database opened");
  db = await openDatabase('User_db1.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE User_Info (first_name TEXT ,sec_name TEXT ,zone TEXT ,mobile TEXT ,User_id TEXT)');
  });
}

String? user_id;
var user1;
Future<String> check() async {
  List<Map> table = (await db.rawQuery('SELECT * FROM User_Info'));
  return table.elementAt(0).values.elementAt(4).toString();
}

Future<void> read_info() async {
  final list = await db.rawQuery('SELECT * FROM User_Info');
  list.forEach((map) {
    user1 = User_info_model.fromMap(map);
  });
}

Future<void> create_user(String Fir_name, String Sec_name, String zone,
    String mob_number, String Userid) async {
  db.rawInsert('INSERT INTO User_Info VALUES (?,?,?,?,?)',
      [Fir_name, Sec_name, zone, mob_number, Userid]);
}

Future<void> update_user(String Userid) async {
  db.rawUpdate('UPDATE User_Info SET  User_id=?', [Userid]);
}

Future<void> New_insert() async {
  db.rawInsert(
      'INSERT INTO User VALUES ("hello","ljdljflj","userid",1,"zone")');
}

Future<void> Delete(String name) async {
  await db.rawDelete('DELETE FROM User_Info WHERE User_id = ?', [name]);
}
