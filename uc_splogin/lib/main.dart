import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uc_splogin/Anasayfa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future <bool> oturumKontrol() async{
    var sp = await SharedPreferences.getInstance();

      String spKullaniciAdi = sp.getString("kullaniciAdi")??"İsim Yok";
      String spSifre = sp.getString("sifre")??"Sifre Yok";

      if(spKullaniciAdi == "admin" && spSifre == "123"){
        return true;
      }else{
        return false;
      }
  }
 
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<bool>(
        future:oturumKontrol(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool gecisIzni = snapshot.data;
            return gecisIzni?Anasayfa():LoginPage();
          }else{
            return Container();
          }
        }
      ),
    );
  }
}

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();  

  Future <void> girisKontrol() async{
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if(ka == "admin" && s == "123"){
    var sp = await SharedPreferences.getInstance();
    sp.setString("kullaniciAdi",ka);
    sp.setString("sifre",s);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
    }else{
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Hatalı Giriş Yapıldı"),));
    }
    
  }

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(    
        title: Text("Giriş Ekranı"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfKullaniciAdi,
                decoration: InputDecoration(
                  hintText:"Kullanıcı Adı"
                )
              ),
              TextField(
                controller: tfSifre,
                obscureText: true,
                decoration: InputDecoration(
                  hintText:"Şifre"
                )
              ),
              ElevatedButton(
                child:Text("Giriş"),
                onPressed:(){
                  girisKontrol();
                  
                }
              )

              

            ],
          ),
        ),
      ),

    );
  }
}
