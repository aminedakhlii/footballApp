import 'package:sqflite/sqflite.dart';


/*

Future insert(table , map) async {

  final Database db = await database() ;
  await db.insert(table, map, conflictAlgorithm: ConflictAlgorithm.replace);

}

Future<List<dynamic>> retrieve (table) async {
  final Database db = await database() ;
  final List<Map<String,dynamic>> maps = await db.query(table) ;

  return List.generate(maps.length, (i){
    return maps[i] ;
  });
}

Future update (table , map) async {
  final Database db = await database() ;
  await db.update(table, map, where: "id = ?", whereArgs: table.id) ;
}

Future delete (table, id) async {
  final Database db = await database() ;
  await db.delete(table, where: "id = ?", whereArgs: id) ;
}

Future deleteAll(path) async  {
  await deleteDatabase(path);

}

Future retrieveElement(table , id) async {
  final Database db = await database() ;
  final dynamic element = await db.query(table , where: "id = ?" , whereArgs: id) ;
  return element ;
}

*/