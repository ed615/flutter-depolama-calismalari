import 'package:flutter/material.dart';
import 'package:yedi_bayrak_sqlite/QuizEkran.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red,

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(    
        title: Text("Bayrak Uygulaması Sqlite Local"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("QUIZE HOŞ GELDİNİZ",style:TextStyle(fontSize: 30)),
            SizedBox(
              height:40,
              width:150,
              child: ElevatedButton(
                child:Text("BAŞLA",style:TextStyle(fontSize: 20)),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizEkran()));
                }
                ),
            )

          ],
        ),
      ),

    );
  }
}
