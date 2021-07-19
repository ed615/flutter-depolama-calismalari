import 'package:flutter/material.dart';
import 'package:sekiz_sozluk_sqlite/Kelimeler.dart';
import 'DetaySayfa.dart';
import 'Kelimelerdao.dart';

void main() {
  runApp(MyApp());
}
/* UYGULAMA ACILDIGINDA TUM KELIMELERI LISTELEYEN ANASAYFA. */
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.yellow,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool aramaYapiliyorMu = false; 
  String aramaKelimesi = "";    

//Kelimelerdao.dart dosyasinda tanimlanmis kelime listeleme metodu
  Future<List<Kelimeler>> kelimeleriGoster() async{
    var kelimelerListesi = await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }

//Kelimelerdao.dart dosyasinda tanimlanmis kelime arama metodu
  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async{
    var kelimelerListesi = await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(    
        title:aramaYapiliyorMu ? //Arama yapiliyorsa textfield gorunur
        TextField(
          decoration:InputDecoration(hintText: "Arama yapılacak kelimeyi giriniz"),
          onChanged:(aramaSonucu){
            print("Arama sonucu: $aramaSonucu");
            setState(() {  //Harf girildikce kiyaslama yapilmasi icin setstate kullanilir
              aramaKelimesi = aramaSonucu;
            });
          }
        )

        :Text("Sözlük Uygulaması"),
        actions: [
          aramaYapiliyorMu ?  IconButton(//Arama yapilan textfield'in saginda iptal butonu gorunur haldedir.
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState(() {
              aramaYapiliyorMu = false;
              aramaKelimesi = "";
              });
              
            }
            ):
          IconButton(//Arama yapilamaz durumdayken search butonuna basilirsaarama yapma ozelligi aktif edilir.
            icon: Icon(Icons.search), 
            onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
              });
            }
            )
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyorMu ? aramaYap(aramaKelimesi): kelimeleriGoster(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimelerListesi = snapshot.data;
            return ListView.builder(  //Listeleme islemi
              itemCount: kelimelerListesi.length,
              itemBuilder: (context,indeks){
                var kelime = kelimelerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>DetaySayfa(kelime:kelime)));
                  },
                    child: SizedBox(
                    height: 50,
                    child: Card(  //Her bir kelime bir card icinde gosterilir.
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(kelime.ingilizce, style:TextStyle(fontWeight:FontWeight.bold)),
                          Text(kelime.turkce),
                      ],)
                    ),
                  ),
                );
              }
              );
          }else{
            return Container();
          }
        }
        )

    );
  }
}
