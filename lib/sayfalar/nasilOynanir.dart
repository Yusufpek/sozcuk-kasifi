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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  color: Colors.deepOrange,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    nasilOynanir,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
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
              ),
              Padding(
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
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.orange,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Teşekkürler:",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        tesekkurIcerigi,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.deepOrange,
                child: Text(by, style: byStili),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
