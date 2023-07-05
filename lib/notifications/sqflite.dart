import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DB{
  static final DB D=DB.internal()!;
  static DB? internal(){}
  static Database? _db;
  Future<Database> create() async{
    if(_db != null) {
      return _db!;
    }
    String path= join(await getDatabasesPath(),'QR-scanner.db');
    _db=await openDatabase(path,version: 1,onCreate: (Database b,int v)
    {
      b.execute('create table notifications(date varchar(100),publisher varchar(30),content varchar(500))');
    } );
    return _db!;
  }
  Future<void> insertDB(String date,String content,String publisher) async{
    Database v=await create();
   await  v.insert('notifications', {"date":date,"publisher":publisher,"content":content});
  }
  Future<List> query() async{
    Database v=await create();
      return v.rawQuery("SELECT * FROM notifications" );
  }
  Future<int> delete_all() async{
    Database v=await create();
      return v.delete('notifications');
  }
  Future<int> delete(String id) async{
    Database v=await create();
    return v.delete('notifications',where: 'date=?',whereArgs: [id]);
  }
}