import 'package:flutter/material.dart';
import 'package:sekiz_sozluk_sqlite/Kelimeler.dart';

/*KELIME BLGISININ GOSTERILDIGI DETAY SAYFASI*/
class DetaySayfa extends StatefulWidget {
  Kelimeler kelime;
  DetaySayfa({this.kelime});

  

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(    
        title: Text("Detay Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.kelime.ingilizce}",style:TextStyle(color: Colors.deepPurpleAccent, fontSize: 40)),
            Text("${widget.kelime.turkce}",style:TextStyle(color: Colors.pinkAccent, fontSize: 30)),

          ],
        ),
      )

    );
  }
}