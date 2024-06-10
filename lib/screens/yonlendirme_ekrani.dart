import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_versiyon1/screens/soru_ekrani.dart';

class YonlendirmeEkrani extends StatefulWidget {
  final String categoryId;
  final String altkategoriId;
  final Color categoryBackgroundColor;

  const YonlendirmeEkrani({
    Key? key,
    required this.categoryId,
    required this.altkategoriId,
    required this.categoryBackgroundColor,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _YonlendirmeEkraniState createState() => _YonlendirmeEkraniState();
}

class _YonlendirmeEkraniState extends State<YonlendirmeEkrani> {
    bool _showLoading = false;

  @override
  void initState() {
    super.initState();
     Timer(const Duration(seconds: 0), () {
      setState(() {
        _showLoading = true;
      });
    });
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SoruEkrani(
            categoryId: widget.categoryId,
            altkategoriId: widget.altkategoriId,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.categoryBackgroundColor,
      appBar: AppBar(
        backgroundColor: widget.categoryBackgroundColor,
        title: Text(
          'Quizzly',
          style: GoogleFonts.rubikVinyl(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.categoryId.toUpperCase(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Quizi Başlamak Üzere!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            const SizedBox(height: 50),
             _showLoading
                ? const SpinKitRipple(
                    color: Colors.white,
                    size: 100.0,
                  ) 
                : Container(),
          ],
        ),
      ),
    );
  }
}
