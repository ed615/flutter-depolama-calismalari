import 'package:sekiz_sozluk_sqlite/Kelimeler.dart';
import 'package:sekiz_sozluk_sqlite/VeritabaniYardimcisi.dart';

/*VERITABANI YARDIMCISI*/
class Kelimelerdao{

 Future<List<Kelimeler>> tumKelimeler() async{
   var db = await VeritabaniYardimcisi.veritabaniErisim();//vt yardimcisindan veritabani alinir.

  List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");// SQL sorgusu ile kelimeler listelenir

  return List.generate(maps.length, (i){
    var satir = maps[i];
    return Kelimeler(satir["kelime_id"],satir["ingilizce"],satir["turkce"]);
  }
);
}

 Future<List<Kelimeler>> kelimeAra(String aramaKelimesi) async{
   var db = await VeritabaniYardimcisi.veritabaniErisim();

  List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$aramaKelimesi%'");

  return List.generate(maps.length, (i){
    var satir = maps[i];
    return Kelimeler(satir["kelime_id"],satir["ingilizce"],satir["turkce"]);
  }
);
}

}