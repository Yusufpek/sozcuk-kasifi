import 'package:flutter/material.dart';
import 'sabitler/textler.dart';
import 'sayfalar/anaMenu.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget with Texts{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: baslik,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AnaMenu(),
    );
  }
}