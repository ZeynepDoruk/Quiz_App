import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GirisSayfasi extends StatelessWidget {

  final void Function() ekran;

  const GirisSayfasi( this.ekran, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children : [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/giris2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
           height: 300,
          ),
          Text(
            'Quizzly',
            style: GoogleFonts.rubikVinyl(
              textStyle: const TextStyle(
                fontSize: 48,
                color: Color.fromARGB(255, 239, 242, 243),
                fontWeight: FontWeight.w900,
              )              
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Hadi Başlayalım!',
            style: GoogleFonts.mPlusRounded1c(
              fontSize: 30,
              color: Color.fromARGB(255, 246, 244, 244),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Bilgini test et ve eğlen',
            style: GoogleFonts.mPlusRounded1c(
              fontSize: 20,
              color: const Color.fromARGB(255, 251, 251, 251),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: ekran,
           // ignore: sort_child_properties_last
           style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 167, 176, 175),
            
            padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 20
            ),
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
          
           ),
           child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
                ),
              const SizedBox(width: 8),
              Text(
            'Başla',
            style: GoogleFonts.mPlusRounded1c(
              fontSize: 25,
              color: Colors.white,
            ),
            ),
            ],
           )
           )
        ],
      ),

          )
        ]
      ),
      
    );
  }
}