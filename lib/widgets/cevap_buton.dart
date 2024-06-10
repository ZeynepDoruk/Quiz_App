import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CevapButonu extends StatelessWidget {
  final String secenek;
  final bool isSelected;
  final VoidCallback onPressed;

  const CevapButonu({
    super.key,
    required this.secenek,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color.fromARGB(255, 178, 169, 169) : const Color.fromARGB(255, 250, 245, 245), 
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
        ),
        onPressed: onPressed,
        child: Text(secenek,
        style: GoogleFonts.roboto(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 25,
        )
        ),
      ),
    );
  }
}
