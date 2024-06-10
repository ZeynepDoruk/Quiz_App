import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_versiyon1/models/quiz_sorular.dart';
import 'package:quiz_versiyon1/screens/kategori_ekrani.dart';
import 'package:quiz_versiyon1/widgets/sonuc_grid_item.dart';

class SonucEkrani extends StatefulWidget {
  final List<String?> _selectedAnswers;
  final List<String> dogruCevaplar;
  final int cevapSayaci;
  final List<Quiz> sorular;

  const SonucEkrani(this.cevapSayaci, this._selectedAnswers, {super.key, required this.dogruCevaplar, required this.sorular});

  @override
  State<StatefulWidget> createState() {
    return _SonucEkraniState();
  }
}

class _SonucEkraniState extends State<SonucEkrani> {

  LinearGradient _getGradient(double dogruYuzde) {
    if (dogruYuzde >= 60) {
      return const LinearGradient(
        colors: [Color.fromARGB(255, 33, 29, 109), Color.fromARGB(255, 58, 169, 165)],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      ) ;
    }
    else if (dogruYuzde >= 30) {
      return const LinearGradient(
        colors: [Color.fromARGB(255, 255, 128, 8), Color.fromARGB(255, 255, 200, 55)],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      );
    }
    else {
      return const LinearGradient(
        colors: [Color.fromARGB(255, 223, 4, 4), Color.fromARGB(255, 201, 83, 33)],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      );
    }
  }

  Color _appbarColor(double dogruYuzde) {
    if (dogruYuzde >= 60) {
      return const Color.fromARGB(255, 33, 29, 109);
    }
    else if (dogruYuzde >= 30) {
      return const Color.fromARGB(255, 255, 132, 0);
    }
    else {
      return const Color.fromARGB(255, 224, 10, 10);
    }
  }


  @override
  Widget build(BuildContext context) {
    List<String?> selectedAnswers = List<String?>.from(widget._selectedAnswers);
    while (selectedAnswers.length < widget.dogruCevaplar.length) {
      selectedAnswers.add(null);
    }
    int dogruCevapSayisi = widget.cevapSayaci;
    double dogruYuzde = (dogruCevapSayisi / widget.dogruCevaplar.length) * 100;
    LinearGradient backgroundGradient = _getGradient(dogruYuzde);
    Color appbarGradient = _appbarColor(dogruYuzde);

    return Scaffold(
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
        backgroundColor: appbarGradient,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      value: dogruCevapSayisi / widget.dogruCevaplar.length,
                      color: Colors.green,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        dogruCevapSayisi.toString(),
                        style: const TextStyle(fontSize: 80, color: Colors.white),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${dogruYuzde.round()}%',
                        style: const TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
              Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: widget.dogruCevaplar.length,
                  itemBuilder: (context, index) {
                    final quiz = widget.sorular[index];
                    return SonucGridItem(
                      selectedAnswer: selectedAnswers[index],
                      correctAnswer: widget.dogruCevaplar[index],
                      index: index,
                      soru: quiz.soru,
                      secenekler: quiz.secenekler,
                    );
                  },
                ),
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KategoriEkrani()),);
              }, 
              child: Text( style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )
              ),
                'Ana Sayfaya Dön'),)
            ],
          ),
        ),
      ),
    );
  }
}
