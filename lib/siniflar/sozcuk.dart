class Sozcuk{
  String sozcuk;
  String aciklama;

  Sozcuk(this.sozcuk, this.aciklama);

  bool kontrolEt(String yazilanSozcuk) => yazilanSozcuk == sozcuk;
}