import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/harfButonWidget.dart';
import '../widgets/yazilanHarfWidget.dart';
import '../sabitler/sorular.dart';
import '../sabitler/textler.dart';
import '../sabitler/yaziStilleri.dart';
import '../siniflar/sozcuk_export.dart';

class ZamanaKarsi extends StatefulWidget {
  @override
  _ZamanaKarsiState createState() => _ZamanaKarsiState();
}

class _ZamanaKarsiState extends State<ZamanaKarsi> with TextStyles, Texts {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<EglenceModuSozcuk> sozcukler;
  late EglenceModuSozcuk sozcuk;
  int _soruSayisi = -1, _zaman = 100, _puan = 0, _pasHakki = 5;
  bool zamanAkiyorMu = false, ilkPasArtir = true, ikiPasArtir = true;
  String k1 = "", k2 = "", k3 = "", ipucu = "", cevap = "";
  //
  late Timer _timer;
  Color zamanRengi = Colors.cyan, butonRengi1 = Colors.green, butonRengi2 = Colors.blue;

  @override
  void initState() {
    sozcukler = Sorular().eglenceModuSozcukler;
    sozcukler.shuffle();
    sozcuk = sozcukler[0];
    super.initState();
  }

  void _showScaffold(String message, Color renk) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      elevation: 5,
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: renk,
      duration: Duration(seconds: 1),
    ));
  }
  //

  void harfeTiklandiginda(String str) {
    if (_zaman > 0) {
      setState(() {
        //Yazdırma işlemi
        if (k1 == null || k1 == "") {
          k1 = str;
        } else if (k2 == null || k2 == "") {
          k2 = str;
        } else if (k3 == null || k3 == "") {
          k3 = str;
          kontrolEt();
        } else {}
      });
    }
  }

  void _zamaniAzalt() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_zaman > 0 && zamanAkiyorMu) {
          _zaman--;
        } else {
          zamanAkiyorMu = false;
          _timer.cancel();
        }
        if (_zaman < 15) {
          zamanRengi = Colors.red;
        } else {
          zamanRengi = Colors.cyan;
        }
      });
    });
  }

  void soruGec() {
    _soruSayisi++;
    temizle();
    ipuclariniYazdir();
  }

  void temizle() {
    setState(() {
      k1 = "";
      k2 = "";
      k3 = "";
    });
  }

  void kontrolEt() {
    String kelime = (k1 + k2 + k3);
    setState(() {
      if (sozcuk.kontrolEt(kelime)) {
        _showScaffold("Doğru Cevap", Colors.green);
        soruGec();
        _puan += sozcuk.puan;
      } else {
        temizle();
        _showScaffold("Yanlış Cevap", Colors.red);
      }
      //
      if (_puan > 50) {
        if (ilkPasArtir) {
          _pasHakki++;
          ilkPasArtir = false;
        }
      }
      if (_puan > 100) {
        if (ikiPasArtir) {
          _pasHakki++;
          ikiPasArtir = false;
        }
      }
    });
  }

  Widget aciklama = Text("");
  void ipuclariniYazdir() {
    try {
      setState(() {
        sozcuk = sozcukler[_soruSayisi];
        aciklama = Text(
          "${sozcuk.aciklama}",
          style: ipucuStili,
        );
      });
    } catch (e) {
      aciklama = Text("");
      print("Hata " + e.toString());
    }
  }

  Widget oyun() {
    if (_soruSayisi == -1) {
      //Giriş sayfası
      return Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.green,
                child: Text(
                  "Eğlence Moduna Hoş Geldin \n$_zaman Saniyen Var Bol Şans !",
                  style:
                      TextStyle(fontSize: 18, fontFamily: "Calibri", fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                elevation: 10,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text("Başla",
                    style: TextStyle(
                        fontSize: 22, fontFamily: "Calibri", fontWeight: FontWeight.bold)),
                color: Colors.deepOrange,
                onPressed: () {
                  zamanAkiyorMu = true;
                  soruGec();
                  _zamaniAzalt();
                },
              ),
            ],
          ),
        ),
      );
    } else if (_zaman <= 0 || _soruSayisi >= sozcukler.length) {
      //oyun bitti istatistikler
      return Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Oyun Bitti ! \nPuanınız : $_puan",
                style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Times New Roman"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      color: Colors.purple,
                      child: Text(
                        "Menüye Dön !",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      //oyun
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  elevation: 10,
                  padding: EdgeInsets.all(10),
                  color: Colors.deepOrange,
                  child: Text("EĞLENCE",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onPressed: () => temizle(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.cyan,
                      child: Text("Puan : $_puan",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Calibri",
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: zamanRengi,
                      child: Text("Süre : $_zaman",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Calibri",
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: _yazilanKelimeWidget),
        Expanded(flex: 3, child: _aciklamaWidget),
        Expanded(flex: 2, child: _harflerWidget),
        Expanded(flex: 1, child: _altBolme)
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(baslik),
      ),
      body: Center(
        child: oyun(),
      ),
    );
  }

  Widget get _yazilanKelimeWidget => Container(
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              color: Colors.purple,
              padding: EdgeInsets.all(10),
              child: Text("Kelime:", style: yazilanKelimeStili),
            ),
            YazilanHarfWidget(k1),
            YazilanHarfWidget(k2),
            YazilanHarfWidget(k3),
          ],
        ),
      );
  Widget get _aciklamaWidget => Container(
        padding: EdgeInsets.all(15),
        color: Colors.deepOrange,
        child: Center(
          child: aciklama,
        ),
      );
  Widget get _harflerWidget => Container(
        color: Colors.deepOrangeAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HarfButonWidget(butonRengi2, "Ç", harfeTiklandiginda),
                HarfButonWidget(butonRengi1, "T", harfeTiklandiginda),
                HarfButonWidget(butonRengi2, "A", harfeTiklandiginda),
                HarfButonWidget(butonRengi1, "İ", harfeTiklandiginda),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HarfButonWidget(butonRengi1, "B", harfeTiklandiginda),
                HarfButonWidget(butonRengi2, "K", harfeTiklandiginda),
                HarfButonWidget(butonRengi1, "S", harfeTiklandiginda),
                HarfButonWidget(butonRengi2, "E", harfeTiklandiginda),
              ],
            ),
          ],
        ),
      );
  Widget get _altBolme => Container(
        color: Colors.orange,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              silButon,
              pasButon,
            ],
          ),
        ),
      );
  Widget get silButon => ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text("Sil"),
        onPressed: () => temizle(),
      );
  Widget get pasButon => ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
      child: Text("Pas $_pasHakki"),
      onPressed: () {
        if (_pasHakki > 0) {
          soruGec();
          setState(() {
            _pasHakki--;
          });
        }
      });
}
