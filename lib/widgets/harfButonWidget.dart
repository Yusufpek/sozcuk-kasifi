import 'package:flutter/material.dart';

class HarfButonWidget extends StatelessWidget {
  final Color renk;
  final String harf;
  final Function tiklandiginda;
  const HarfButonWidget(this.renk, this.harf, this.tiklandiginda);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.0,
      minWidth: 40.0,
      color: renk,
      textColor: Colors.white,
      child: Text(harf),
      onPressed: () {
        tiklandiginda(harf);
      },
      splashColor: Colors.red,
    );
  }
}
