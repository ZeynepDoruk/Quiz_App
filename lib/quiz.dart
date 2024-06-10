import 'package:flutter/material.dart';
import 'package:quiz_versiyon1/screens/giris_ekrani.dart';
import 'package:quiz_versiyon1/screens/kategori_ekrani.dart';

class Quizzly extends StatefulWidget {
  const Quizzly({super.key});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quizzly> {

  // ignore: non_constant_identifier_names
  String EkranDegistir = "giris-ekrani";

  void ekran() {
    setState(() {
      if(EkranDegistir == 'giris-ekrani') {
        EkranDegistir = 'kategori-ekrani';
      }
      else if(EkranDegistir == 'kategori-ekrani') {
        EkranDegistir = "soru-ekrani";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ekranWidget = GirisSayfasi(ekran);
    if(EkranDegistir == 'soru-ekrani') {
    } else if (EkranDegistir == 'kategori-ekrani') {
      ekranWidget = const KategoriEkrani();
    } 

    return MaterialApp(
      home: Scaffold(
        body: ekranWidget,
      ),
    );
  }
}

