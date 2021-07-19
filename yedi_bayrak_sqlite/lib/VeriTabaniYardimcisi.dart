import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

/*VERI TABANINA ERISIM ICIN KULLANILAN VT YARDIMCISI*/
class VeriTabaniYardimcisi{
  static final String vtAdi = "bayrak.db";

  static Future<Database> vtErisim() async{
    String vtYolu = join(await getDatabasesPath(),vtAdi);

    if(await databaseExists(vtYolu)){
      print("Veri tabani zaten kayitli");
    }else{
      ByteData data = await rootBundle.load("database/$vtAdi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(vtYolu).writeAsBytes(bytes,flush:true);
      print("Veri Tabanı kopyalandı");
    }

    return openDatabase(vtYolu);
  }
}