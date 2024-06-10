import 'package:flutter/material.dart';
import 'package:quiz_versiyon1/widgets/sonuc_detay.dart';

class SonucGridItem extends StatelessWidget {
  final String? selectedAnswer;
  final String correctAnswer;
  final int index;
  final String soru;
  final List<String> secenekler;
  const SonucGridItem({super.key, required this.selectedAnswer, required this.correctAnswer, required this.index, required this.soru, required this.secenekler});

  @override
  Widget build(BuildContext context) {

    Color itemColor;

    if (selectedAnswer == null) {
      itemColor = Colors.grey;
    } else if (selectedAnswer == correctAnswer) {
      itemColor = Colors.green;
    } else {
      itemColor = Colors.red;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SonucDetayWidget(
              soru: soru,
              secenekler: secenekler,
              selectedAnswer: selectedAnswer,
              correctAnswer: correctAnswer,
              index: index,
            );
          },
        );
      },
      child: Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Soru ${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
    )
      ),
    );
  }
}
