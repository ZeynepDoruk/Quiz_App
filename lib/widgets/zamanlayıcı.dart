import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Zamanlayaci extends AnimatedWidget {
  Zamanlayaci({super.key, required this.animation, }):super(listenable: animation);

  Animation<int> animation;
  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    var timerText = '${clockTimer.inMinutes.remainder(60).toString()} :'
        '${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text('${timerText}',
        style: GoogleFonts.rubikVinyl(
          textStyle: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.w400,
            color: Colors.white
          ),
        ));
  }
}
