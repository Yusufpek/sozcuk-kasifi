import 'sozcuk.dart';

class NormalModSozcuk extends Sozcuk {
  String? aciklama2;
  int puan = 8;
  NormalModSozcuk(sozcuk, aciklama, {this.aciklama2}) : super(sozcuk, aciklama) {
    if (aciklama2 == null) puan = 4;
  }
}
