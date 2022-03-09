import 'dart:async';

import 'package:flutter/material.dart';

import '../sabitler/sorular.dart';
import '../sabitler/textler.dart';
import '../sabitler/yaziStilleri.dart';
import '../siniflar/normalModSozcuk.dart';
import '../siniflar/sozcuk_export.dart';
import '../widgets/harfButonWidget.dart';
import '../widgets/yazilanHarfWidget.dart';

class NormalOyunModu extends StatefulWidget {
  @override
  _NormalOyunModuState createState() => _NormalOyunModuState();
}

class _NormalOyunModuState extends State<NormalOyunModu> with TextStyles, Texts {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showScaffold(String message, Color renk) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      elevation: 5,
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: renk,
      duration: Duration(seconds: 2),
    ));
  }

  List<Sozcuk> sozcukler = Sorular().normalModSoczukler;
  NormalModSozcuk sozcuk;
  int _soruSayisi = -1, _zaman = 30, _puan = 0, _pasHakki = 5, _kazanilacakPuan = 8;
  bool zamanAkiyorMu = false, ikinciAktif = false, ipucu1Acik = false, ipucu2Acik = false;
  //ikinci aktif 1. ipucu açıldıktan sonra açılacak
  String k1 = "", k2 = "", k3 = "", k4 = "", dogruluk, bitisNedeni;
  //
  // ignore: unused_field
  Timer _timer;
  Color zamanRengi = Colors.orange, butonRengi1 = Colors.green, butonRengi2 = Colors.blue;
  void _zamaniAzalt() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_zaman > 0 && zamanAkiyorMu) {
          _zaman--;
        } else {
          //_timer.cancel();
        }
        if (_zaman < 10) {
          zamanRengi = Colors.red;
        } else {
          zamanRengi = Colors.orange;
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void harfeTiklandiginda(String str) {
    if (_zaman > 0 && zamanAkiyorMu) {
      setState(() {
        //Yazdırma işlemi
        if (k1 == null || k1 == "") {
          k1 = str;
        } else if (k2 == null || k2 == "") {
          k2 = str;
        } else if (k3 == null || k3 == "") {
          k3 = str;
        } else if (k4 == null || k4 == "") {
          k4 = str;
        } else {}
      });
    }
  }

  void sifirla() {
    _zaman = 30;
    zamanAkiyorMu = false;
    ipucu1Acik = false;
    ipucu2Acik = false;
    ikinciAktif = false;
    sil();
  }

  void soruSayisiniArtir() {
    setState(() {
      _soruSayisi++;
      sifirla();
    });
  }

  void kontrolEt() {
    String yazilanSozcuk = (k1 + k2 + k3 + k4);
    if (yazilanSozcuk == null || yazilanSozcuk == "") {
      dogruluk = "bos";
    } else if (sozcuk.kontrolEt(yazilanSozcuk)) {
      soruSayisiniArtir();
      _puan += _kazanilacakPuan;
      dogruluk = "dogru";
    } else {
      dogruluk = "yanlis";
      sil();
      setState(() {
        _puan--;
      });
    }
  }

  void sil() {
    setState(() {
      k1 = "";
      k2 = "";
      k3 = "";
      k4 = "";
    });
  }

  TextStyle ipucuStili =
      TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Times New Roman");
  void ipuclariniYazdir() {
    try {
      if (_soruSayisi < sozcukler.length) {
        sozcuk = sozcukler[_soruSayisi];
        _kazanilacakPuan = sozcuk.puan;
      }
    } catch (e) {
      print("Hata " + e);
    }
  }

  Widget oyun() {
    if (_soruSayisi == -1) {
      return Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                child: Text(
                  "Normal Oyun Moduna Hoş Geldin !\n\n Notlar \nHer soruda verilen ipucu sayısı değişebilir \nİpucu Açıldğında Süren Başlar\n \nBol Şans ! ",
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
                  setState(() {
                    _zamaniAzalt();
                    _soruSayisi = 1;
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else if (_zaman <= 0 || _soruSayisi >= sozcukler.length) {
      zamanAkiyorMu = false;
      if (_zaman <= 0) {
        bitisNedeni = "Süreniz Doldu";
      } else if (_soruSayisi >= 43) {
        bitisNedeni = "Tebrikler tüm soruları gördünüz";
      } else {
        bitisNedeni = "";
      }
      return Container(
        color: Colors.orange,
        child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              color: Colors.teal,
              child: Text(
                "OYUN BİTTİ !!!",
                style: TextStyle(color: Colors.white, fontSize: 25),
              )),
          Container(
              padding: EdgeInsets.all(20),
              color: Colors.deepOrange,
              child: Text(
                "Gördüğünüz Soru Sayısı : $_soruSayisi \nPuanınız: $_puan",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Text(
              "Bitiş nedeni: $bitisNedeni",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Row(
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
              RaisedButton(
                padding: EdgeInsets.all(10),
                color: Colors.green,
                child: Text(
                  "Yeniden Oyna !",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  _soruSayisi = 0;
                  _zaman = 30;
                  _pasHakki = 5;
                  sifirla();
                },
              )
            ],
          ),
        ])),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                      child:
                          Text("$_soruSayisi", style: TextStyle(fontSize: 18, color: Colors.white)),
                      onPressed: null),
                  Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.deepOrange,
                      child: Text(
                        "Puan: $_puan",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  FloatingActionButton(
                      backgroundColor: zamanRengi,
                      child: Text("$_zaman", style: TextStyle(fontSize: 18, color: Colors.white)),
                      onPressed: null),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    color: Colors.purple,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Kelime:",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  YazilanHarfWidget(k1),
                  YazilanHarfWidget(k2),
                  YazilanHarfWidget(k3),
                  YazilanHarfWidget(k4),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue,
                          child: Text("1.İpucu"),
                          onPressed: () {
                            setState(() {
                              zamanAkiyorMu = true;
                              ikinciAktif = true;
                              ipucu1Acik = true;
                            });
                          },
                        ),
                        if (ipucu1Acik)
                          Container(
                              padding: EdgeInsets.all(10), child: _aciklamaWidget(sozcuk.aciklama)),
                      ],
                    ),
                  ),
                  if (sozcuk.aciklama2 != null)
                    Container(
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.blue,
                            child: Text("2.İpucu"),
                            onPressed: () {
                              if (ikinciAktif) {
                                ikinciAktif = false;
                                ipucu2Acik = true;
                              }
                            },
                          ),
                          if (ipucu2Acik)
                            Container(
                                padding: EdgeInsets.all(10),
                                child: _aciklamaWidget(sozcuk.aciklama2)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.deepPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HarfButonWidget(butonRengi1, "B", harfeTiklandiginda),
                      HarfButonWidget(butonRengi2, "K", harfeTiklandiginda),
                      HarfButonWidget(butonRengi1, "S", harfeTiklandiginda),
                      HarfButonWidget(butonRengi2, "E", harfeTiklandiginda),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      HarfButonWidget(butonRengi2, "Ç", harfeTiklandiginda),
                      HarfButonWidget(butonRengi1, "T", harfeTiklandiginda),
                      HarfButonWidget(butonRengi2, "A", harfeTiklandiginda),
                      HarfButonWidget(butonRengi1, "İ", harfeTiklandiginda),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text("Kontrol Et", style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      kontrolEt();
                      if (dogruluk == "dogru") {
                        _showScaffold("Doğru Cevap !", Colors.green);
                      } else if (dogruluk == "yanlis") {
                        _showScaffold("Yanlış Cevap !", Colors.red);
                      } else if (dogruluk == "bos") {
                        _showScaffold("Boş Geçmeyiniz !", Colors.deepOrange);
                      }
                    },
                  ),
                  _silButonu,
                  _pasButonu,
                ],
              ),
            ),
          ),
        ],
      );
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

  Widget _aciklamaWidget(String aciklama) => Center(child: Text(aciklama, style: ipucuStili));
  Widget get _silButonu => RaisedButton(
        color: Colors.orange,
        child: Text("Sil", style: altBolmeStili),
        onPressed: sil,
      );
  Widget get _pasButonu => RaisedButton(
        color: Colors.green,
        child: Text("Pas $_pasHakki", style: altBolmeStili),
        onPressed: () {
          if (_pasHakki > 0) {
            _pasHakki--;
            soruSayisiniArtir();
          }
        },
      );
}
