import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uc_splogin/main.dart';

class Anasayfa extends StatefulWidget {


  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String spKullaniciAdi;
  String spSifre;

  Future <void> oturumBilgisiOku() async{
    var sp = await SharedPreferences.getInstance();
    setState(() {
      spKullaniciAdi = sp.getString("kullaniciAdi")??"İsim Yok";
      spSifre = sp.getString("sifre")??"Sifre Yok";
    });
    
  }

   Future <void> cikisYap() async{
   
    var sp = await SharedPreferences.getInstance();
    sp.remove("kullaniciAdi");
    sp.remove("sifre");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Anasayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed:(){
              cikisYap();
            }
          )
        ],),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Kullanıcı Adı: $spKullaniciAdi",style:TextStyle(fontSize:30)),
            Text("Şifre : $spSifre",style:TextStyle(fontSize:30)),
          ],
          )
        )
    );
  }

  @override 
  void initState(){
    super.initState();
    oturumBilgisiOku();
  }
}