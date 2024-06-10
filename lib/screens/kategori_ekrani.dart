import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_versiyon1/models/kategori.dart';
import 'package:quiz_versiyon1/quiz_service.dart';
import 'package:quiz_versiyon1/widgets/kategori_grid_item.dart';

class KategoriEkrani extends StatefulWidget {
  const KategoriEkrani({super.key});


  @override
  // ignore: library_private_types_in_public_api
  _KategoriEkraniState createState() => _KategoriEkraniState();
}

class _KategoriEkraniState extends State<KategoriEkrani> {
  late Future<List<Kategori>> _kategoriListesi;

  @override
  void initState() {
    super.initState();
    _kategoriListesi = QuizService().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 248),
      appBar: AppBar(
        title: Text(
          'Quizzly',
          style: GoogleFonts.rubikVinyl(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 10, 10, 10),
              fontWeight: FontWeight.w400
            )
          ),
          ),
      backgroundColor: Color.fromARGB(255, 245, 245, 246),
          shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 0,
            ),
            Center(
              child: Text(
                "Kategoriler",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: FutureBuilder<List<Kategori>>(
                future: _kategoriListesi,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Bir hata oluştu: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Kategori bulunamadı"));
                  } else {
                    final kategoriler = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: kategoriler.length,
                      itemBuilder: (context, index) {
                        return KategoriItem(
                          kategori: kategoriler[index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
