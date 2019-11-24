import 'Note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String note_table='note_table';
  String colid='id';
  String coldesc='desc';
  String coltitle='title';
  String colpriority='priority';
  String coldate='date';
 DatabaseHelper.createInstance();

 factory DatabaseHelper(){
   if (_databaseHelper==null) {

     _databaseHelper=DatabaseHelper.createInstance();   }


     return _databaseHelper;
 }

Future<Database> get database async {
  if(_database==null){
    _database=await initializeDatabase();
  }
  return _database;
}
Future<Database> initializeDatabase() async{

Directory directory=await getApplicationDocumentsDirectory();
String path=directory.path+"notes.db";

var notesDatabase =openDatabase(path,version:1,onCreate:createDb);

return notesDatabase;

}


void createDb(Database db,int newversion) async{
 await db.execute(
   'CREATE TABLE $note_table($colid INTEGER PRIMARY KEY AUTOINCREMENT,$coltitle TEXT,$coldesc TEXT,$colpriority INTEGER,$coldate TEXT)'
   
 ); 
}
Future<List<Map<String,dynamic>>> getNoteMapList () async{
 Database db=await this.database;
 var result=await db.query(note_table,orderBy:'$colpriority ASC');
 return result; 
}

Future<int> insertNote(Note note) async{
  Database db=await this.database;
var result =db.insert(note_table, note.tomap());
return result;
}
Future<int> updateNote(Note note) async{

Database db=await this.database;
var result =db.update(note_table, note.tomap(),where: '$colid', whereArgs: [note.id]);
return result;
}

Future<int> deleteNote(int id) async{

Database db=await this.database;
var result=db.rawDelete('DELETE FROM $note_table where $colid=$id');  
return result;


}
Future<int> getCount() async{
  Database db=await this.database;

  List<Map<String,dynamic>> x=await db.rawQuery('SELECT COUNT (*) FROM $note_table');
  int result=Sqflite.firstIntValue(x);
  return result;
}
Future<List<Note>> getNoteList() async{
  var noteMapList =await getNoteMapList();
  int count=noteMapList.length;
  List<Note> notelist=List<Note>();
 for(var i=0;i<count;i++){
   notelist.add(Note.fromMapObject(noteMapList[i]));
 }
return notelist;
} 


}