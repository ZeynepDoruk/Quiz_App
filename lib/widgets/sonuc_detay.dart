import 'package:flutter/material.dart';

class SonucDetayWidget extends StatelessWidget {
  final String soru;
  final List<String> secenekler;
  final String? selectedAnswer;
  final String correctAnswer;
  final int index;

  const SonucDetayWidget({
    super.key,
    required this.soru,
    required this.secenekler,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Soru ${index + 1}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(soru),
          const SizedBox(height: 10),
          ...secenekler.map((secenek) {
            bool isSelected = secenek == selectedAnswer;
            bool isCorrect = secenek == correctAnswer;

            return ListTile(
              title: Text(secenek),
              leading: Icon(
                isCorrect
                    ? Icons.check
                    : isSelected
                        ? Icons.close
                        : null,
                color: isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : null,
              ),
            );
          }).toList(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Kapat'),
        ),
      ],
    );
  }
}
