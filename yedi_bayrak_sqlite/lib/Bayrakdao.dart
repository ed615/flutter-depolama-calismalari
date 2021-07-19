import 'package:yedi_bayrak_sqlite/VeriTabaniYardimcisi.dart';

import 'Bayrak.dart';

class Bayrakdao{
  static Future<List<Bayrak>> rastgele5Getir() async{
    var db = await VeriTabaniYardimcisi.vtErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM bayrak ORDER BY RANDOM() LIMIT 5");

    return List.generate(maps.length,(i){
      var satir = maps[i];
      return Bayrak(satir["bayrak_id"],satir["bayrak_ad"],satir["bayrak_gorsel"]);
    }
    
    );
  }

  static Future<List<Bayrak>> rastgele3Yanlis(int b_id) async{
    var db = await VeriTabaniYardimcisi.vtErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("""SELECT * FROM bayrak 
    WHERE bayrak_id != $b_id ORDER BY RANDOM() LIMIT 3 """);

    return List.generate(maps.length,(i){
      var satir = maps[i];
      return Bayrak(satir["bayrak_id"],satir["bayrak_ad"],satir["bayrak_gorsel"]);
    }
    );

  }
  

}