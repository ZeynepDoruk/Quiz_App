
class Kategori {
  final String? kategoriAdi;
  final String? id;
  final String? ikon;
  final String altkategori;

  Kategori(this.id, this.kategoriAdi, this.ikon, this.altkategori);

  factory Kategori.fromMap(Map<String, dynamic> data) {
    return Kategori(
      data['id'],
      data['name'],
      data['ikon'],
      data['altkategori']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': kategoriAdi,
      'ikon': ikon,
      'altkategori': altkategori
  
};
}
}