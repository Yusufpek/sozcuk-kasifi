import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animasyonlar {
  final String sHarfi = "https://assets3.lottiefiles.com/packages/lf20_pxk20owi.json";
  final String kHarfi = "https://assets3.lottiefiles.com/packages/lf20_uco7tvkc.json";

  Widget get sHarfiAnimasyonu => animasyon(sHarfi);
  Widget get kHarfiAnimasyonu => animasyon(kHarfi);

  Widget animasyon(String dosyaAdi) {
    return Lottie.network(dosyaAdi);
  }
}
