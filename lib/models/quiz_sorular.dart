class Quiz {
  final String soru;
  final List<String> secenekler;
  final String cevap;

  Quiz({
    required this.soru,
    required this.secenekler,
    required this.cevap,
  });

  factory Quiz.fromMap(Map<String, dynamic> data) {
    return Quiz(
      soru: data['soru'],
      secenekler: List<String>.from(data['seçenekler']),
      cevap: data['cevap'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'soru': soru,
      'seçenekler': secenekler,
      'cevap': cevap,
};
}
}