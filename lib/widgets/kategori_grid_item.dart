
import 'package:flutter/material.dart';
import 'package:quiz_versiyon1/data/kategori_verisi.dart';
import 'package:quiz_versiyon1/models/kategori.dart';
import 'package:quiz_versiyon1/screens/yonlendirme_ekrani.dart';

class KategoriItem extends StatelessWidget {
  final Kategori kategori;

  const KategoriItem({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    const iconColor = Colors.white;
    final kategoriRenk = kategoriRenkleri[kategori.kategoriAdi?.toLowerCase()] ?? Colors.grey;


    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => YonlendirmeEkrani(
            categoryId: kategori.id!,
            altkategoriId: kategori.altkategori,
            categoryBackgroundColor: kategoriRenk,
            )
          )
        );
      },
      
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        
        decoration: BoxDecoration(
          color: kategoriRenk,
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(10, 10), 
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Image.network(
                kategori.ikon ?? '',
                width: 80,
                height: 80,
                color: iconColor,
              ),
              const SizedBox(height: 10), 
              Text(
                kategori.kategoriAdi?.toUpperCase() ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}