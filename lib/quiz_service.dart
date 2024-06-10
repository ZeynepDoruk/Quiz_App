import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_versiyon1/models/kategori.dart';
import 'package:quiz_versiyon1/models/quiz_sorular.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Kategori>> getCategories() async {
    QuerySnapshot querySnapshot = await _firestore.collection('Kategoriler').get();
    return querySnapshot.docs.map((doc) => Kategori.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<Quiz>> getQuestionsByCategory(String categoryId, String altkategoriid) async {
    QuerySnapshot querySnapshot = await _firestore.collection('Kategoriler')
      .doc(categoryId)
      .collection(altkategoriid)
      .get();

    return querySnapshot.docs.map((doc) => Quiz.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
