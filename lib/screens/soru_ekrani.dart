import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_versiyon1/data/kategori_verisi.dart';
import 'package:quiz_versiyon1/models/quiz_sorular.dart';
import 'package:quiz_versiyon1/quiz_service.dart';
import 'package:quiz_versiyon1/screens/sonuc_ekrani.dart';
import 'package:quiz_versiyon1/widgets/cevap_buton.dart';
import 'package:quiz_versiyon1/widgets/zamanlay%C4%B1c%C4%B1.dart';

Color _getCategoryColor(String categoryId) {
  return kategoriRenkleri[categoryId] ?? Colors.grey;
}

class SoruEkrani extends StatefulWidget {
  final String categoryId;
  final String altkategoriId;

  const SoruEkrani({Key? key, required this.categoryId, required this.altkategoriId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SoruEkraniState createState() => _SoruEkraniState();
}

class _SoruEkraniState extends State<SoruEkrani> with SingleTickerProviderStateMixin {
  late Future<List<Quiz>> _sorular;
  late List<Quiz> _secilenSorular;
  int _soruIndex = 0;
  String? _selectedOption;
  final List<String?> _selectedAnswers = [];
  List<String> dogruCevaplar = [];
  int cevapSayaci = 0;
  bool sinavBitirme = true;
  late AnimationController _controller;

  @override
  void dispose() {
    super.dispose();
    if (_controller.isAnimating || _controller.isCompleted) {
      _controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _sorular = QuizService().getQuestionsByCategory(widget.categoryId, widget.altkategoriId);

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _controller.addListener(() {
      if (_controller.isCompleted) {
        sinavBitirme = false;
        _showTimeUpDialog(context);
      }
    });
    _controller.forward();

    _sorular.then((sorular) {
      sorular.shuffle(Random());
      int soruSayisi = 5;
      _secilenSorular = sorular.take(soruSayisi).toList();
      dogruCevaplar = _secilenSorular.map((quiz) => quiz.cevap).toList();
      setState(() {});
    });
  }

  void _showTimeUpDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("SÜRE DOLDU!!"),
          content: const Text("Süreniz doldu, sonuç ekranına yönlendiriliyorsunuz.",
          style: TextStyle(
            fontSize: 18,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSonucEkrani();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSonucEkrani() {
    _sorular.then((sorular) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SonucEkrani(
            cevapSayaci,
            _selectedAnswers,
            dogruCevaplar: dogruCevaplar, sorular: sorular,
          ),
        ),
      );
    });
  }

  void _sonrakiSoruyaGec(List<Quiz> sorular, Quiz quiz) {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir seçenek seçin')),
      );
    } else {
      setState(() {
        if (_selectedOption == _secilenSorular[_soruIndex].cevap) {
          cevapSayaci++;
        }

        _selectedAnswers.add(_selectedOption);

        if (_soruIndex < _secilenSorular.length - 1) {
          _soruIndex++;
          _selectedOption = null;
        }
      });
    }
    if (sinavBitirme == false) {
      _navigateToSonucEkrani();
    }
  }

  void _showConfirmationDialog(BuildContext context, List<Quiz> sorular, Quiz quiz) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quizi Bitirmek İstediğine Emin Misin?"),
          content: const Text("Quizi bitirirsen, sonuç ekranına yönlendirileceksin."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("İptal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sinavBitirme = false;
                  _sonrakiSoruyaGec(sorular, quiz);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Quizi Bitir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(widget.categoryId);
    return Scaffold(
      backgroundColor: categoryColor,
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text(
          'Quizzly',
          style: GoogleFonts.rubikVinyl(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400
            )
          ),
          ),
        backgroundColor: categoryColor,
      ),
      body: FutureBuilder<List<Quiz>>(
        future: _sorular,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Sorular bulunamadı"));
          } else {
            final sorular = snapshot.data!;

            if (dogruCevaplar.isEmpty) {
              for (var quiz in sorular) {
                dogruCevaplar.add(quiz.cevap);
              }
            }
            if (_soruIndex >= _secilenSorular.length) {
              return const Center(child: Text("Tüm soruları tamamladınız"));
            }
            final quiz = _secilenSorular[_soruIndex];

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Zamanlayaci(animation: StepTween(begin: 30, end: 0).animate(_controller),),
                        Container(
                          width: 400,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 30.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            minHeight: 150,
                          ),
                          child: Center(
                            child: Text(
                              quiz.soru,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 400.0,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 30.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: quiz.secenekler.map((secenek) {
                              return CevapButonu(
                                secenek: secenek,
                                isSelected: _selectedOption == secenek,
                                onPressed: () {
                                  setState(() {
                                    _selectedOption = secenek;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(context, sorular, quiz);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 247, 21, 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(150, 60),
                          ),
                          child: const Text(
                            'Quizi Bitir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _soruIndex < _secilenSorular.length - 1
                              ? () => _sonrakiSoruyaGec(_secilenSorular, quiz)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 1, 176, 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(150, 60),
                          ),
                          child: const Text(
                            'Sonraki Soru',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

