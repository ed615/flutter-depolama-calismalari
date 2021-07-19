import 'package:flutter/material.dart';


/*BASARI ORANININ GORUNTULENDIGI EKRAN*/
class SonucEkran extends StatefulWidget {
  int dogruSayisi;
  SonucEkran({this.dogruSayisi});
  @override
  _SonucEkranState createState() => _SonucEkranState();
}

class _SonucEkranState extends State<SonucEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(    
        title: Text("Sonuç Ekranı"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [// Basari orani yuzdelik olarak hesaplanir.
            Text("${widget.dogruSayisi} DOĞRU ${5-widget.dogruSayisi} YANLIŞ", style:TextStyle(fontSize: 35)),
            Text("% ${((100*widget.dogruSayisi)~/5).toInt()} Başarı", style:TextStyle(fontSize: 40, color: Colors.blue.shade900)),
            SizedBox(
              height:50,
              width:200,
              child: ElevatedButton(
                child: Text("TEKRAR DENE"),
                onPressed:(){
                  Navigator.pop(context);
                }
                ),
            )

          ],
        ),
      ),

    );
  }
}