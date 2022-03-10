import 'package:flutter/material.dart';

import '../sabitler/textler.dart';
import '../sabitler/yaziStilleri.dart';

class NasilOynanir extends StatelessWidget with Texts, TextStyles {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(baslik),
      ),
      body: Container(
        height: double.maxFinite,
        color: Colors.purple,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _nasilOyanirWidget,
              _bilgilendirmeWidget,
              _oyunModu1AciklamaWidget,
              _oyunModu2AciklamaWidget,
              _byWidget,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _nasilOyanirWidget => Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          color: Colors.deepOrange,
          padding: EdgeInsets.all(10),
          child: Text(
            nasilOynanir,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      );
  Widget get _bilgilendirmeWidget => Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.orange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Bilgilendirme", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(bilgilendirme, style: TextStyle(fontSize: 17)),
            ],
          ),
        ),
      );
  Widget get _oyunModu1AciklamaWidget => Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(oyunModu1, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(oyunModu1Aciklama, style: TextStyle(fontSize: 17)),
            ],
          ),
        ),
      );
  Widget get _oyunModu2AciklamaWidget => Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(oyunModu2, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(oyunModu2Aciklama, style: TextStyle(fontSize: 17)),
            ],
          ),
        ),
      );
  Widget get _byWidget => Container(
        padding: EdgeInsets.all(10),
        color: Colors.deepOrange,
        child: Text(by, style: byStili),
      );
}
