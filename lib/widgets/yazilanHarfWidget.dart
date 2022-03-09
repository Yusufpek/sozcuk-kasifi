import 'package:flutter/material.dart';
import '../sabitler/yaziStilleri.dart';

class YazilanHarfWidget extends StatelessWidget with TextStyles {
  final String? harf;
  YazilanHarfWidget(this.harf);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 7),
      color: Colors.deepPurpleAccent,
      child: Text(
        "$harf",
        style: yazilanKelimeStili,
        textAlign: TextAlign.center,
      ),
      height: 40,
      width: 40,
    );
  }
}
