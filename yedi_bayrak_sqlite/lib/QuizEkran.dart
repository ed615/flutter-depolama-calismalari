import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:yedi_bayrak_sqlite/SonucEkran.dart';
import 'Bayrak.dart';
import 'Bayrakdao.dart';

class QuizEkran extends StatefulWidget {

  @override
  _QuizEkranState createState() => _QuizEkranState();
}

class _QuizEkranState extends State<QuizEkran> {
  var sorular = <Bayrak>[]; //sorular bayrak classından cekilip listelenecek
  var yanlisSecenekler = <Bayrak>[];
  Bayrak dogruCevap;
  var tumSecenekler= HashSet<Bayrak>();//hashset icinde yerleri degisiyor
  
  int soruSayac = 0;
  int dogruSayac = 0;
  int yanlisSayac = 0;

  String bayrakGorselAdi = "placeholder.png";
  String buttonAyazi="";
  String buttonByazi="";
  String buttonCyazi="";
  String buttonDyazi="";

  @override
  void initState() {// Baslangicta sorular alinir
    super.initState();
    sorulariAl();
  }
 
  Future<void> sorulariAl() async{//Rastgele bes tane bayrak secilip soru haline getirilir
    sorular = await Bayrakdao.rastgele5Getir();
    soruYukle();
  }
  
  Future<void> soruYukle() async{
    dogruCevap = sorular[soruSayac];
    bayrakGorselAdi = dogruCevap.bayrak_gorsel;
    yanlisSecenekler = await Bayrakdao.rastgele3Yanlis(dogruCevap.bayrak_id);

    tumSecenekler.clear();
    tumSecenekler.add(dogruCevap);
    tumSecenekler.add(yanlisSecenekler[0]);
    tumSecenekler.add(yanlisSecenekler[1]);
    tumSecenekler.add(yanlisSecenekler[2]);

    buttonAyazi = tumSecenekler.elementAt(0).bayrak_ad;
    buttonByazi = tumSecenekler.elementAt(1).bayrak_ad;
    buttonCyazi = tumSecenekler.elementAt(2).bayrak_ad;
    buttonDyazi = tumSecenekler.elementAt(3).bayrak_ad;

    setState(() {// Yeni soruya geciste islemin sayfada yenilenmesi
      
    });

  }

  void soruSayacKontrol(){// Soru sayisi 5'i bulana kadar çozulen soru sayisi artar
    soruSayac = soruSayac + 1;
    if(soruSayac!=5){
      soruYukle();
    }else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SonucEkran(dogruSayisi: dogruSayac,)));
    }
  
  }

  void dogruKontrol(String buttonYazi){
    if(dogruCevap.bayrak_ad == buttonYazi){
      dogruSayac++;
    }else{
      yanlisSayac++;
    }
  }
    
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
    
          appBar: AppBar(    
            title: Text("Quiz Ekranı"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Doğru: $dogruSayac"),
                    Text("Yanlış: $yanlisSayac"),
                  ],
                  ),
                soruSayac!=5 ? Text("${soruSayac+1}. Soru",style:TextStyle(fontSize: 30)):
                Text("5. Soru",style:TextStyle(fontSize: 30)),

                Image.asset("images/$bayrakGorselAdi"),

                SizedBox(
                  height:50,
                  width: 250,
                  child: ElevatedButton(
                    child: Text(buttonAyazi),
                    onPressed:(){
                      dogruKontrol(buttonAyazi);
                      soruSayacKontrol();
                    }
                  ),
                ),
                SizedBox(
                  height:50,
                  width: 250,
                  child: ElevatedButton(
                    child: Text(buttonByazi),
                    onPressed:(){
                    dogruKontrol(buttonByazi);
                    soruSayacKontrol();
                    }
                  ),
                ),
                SizedBox(
                  height:50,
                  width: 250,
                  child: ElevatedButton(
                    child: Text(buttonCyazi),
                    onPressed:(){
                     dogruKontrol(buttonCyazi);
                     soruSayacKontrol();
                    }
                  ),
                ),
                SizedBox(
                  height:50,
                  width: 250,
                  child: ElevatedButton(
                    child: Text(buttonDyazi),
                    onPressed:(){
                      dogruKontrol(buttonDyazi);
                      soruSayacKontrol();
                    }
                  ),
                ),
               
    
              ],
            ),
          ),
    
        );
      }
    }