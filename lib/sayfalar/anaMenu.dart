import 'package:flutter/material.dart';
import 'package:sifreli_sozuklerin_kesfi/sabitler/textler.dart';
import '../sabitler/yaziStilleri.dart';
import 'nasilOynanir.dart';
import 'normalOyunModu.dart';
import 'zamanaKarsi.dart';

class AnaMenu extends StatelessWidget with TextStyles, Texts {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Container(
            color: Colors.cyan[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.orange,
                    child: Text(baslik, style: yaziStiliAnaBaslik),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      color: Colors.orange,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  oyunModu2,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ZamanaKarsi()),
                                  );
                                },
                              ),
                              RaisedButton(
                                color: Colors.green,
                                child: Text(
                                  oyunModu1,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NormalOyunModu()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                              color: Colors.deepOrange,
                              child: Text(
                                nasilOynanir,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NasilOynanir()),
                                );
                              }),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.orange,
                    child: Text(by, style: byStili),
                  ),
                ],
              ),
            ),
          ),
          NasilOynanir()
        ],
      ),
    );
  }
}
