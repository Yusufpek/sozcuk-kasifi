import 'package:flutter/material.dart';

mixin TextStyles {
  final TextStyle yaziStiliAnaBaslik = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontFamily: "Times New Roman");
  final TextStyle byStili = TextStyle(
    fontSize: 16,
    fontFamily: "Times New Roman",
  );
  final TextStyle altBaslikStili = TextStyle(fontSize: 18);
  final TextStyle ipucuStili =
      TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Times New Roman");
  final TextStyle yazilanKelimeStili = TextStyle(color: Colors.white, fontSize: 20);
  final TextStyle harfStili =
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  final TextStyle altBolmeStili = TextStyle(color: Colors.white, fontSize: 18);
}
