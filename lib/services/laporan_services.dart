import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanServices {
  final db = FirebaseFirestore.instance.collection('reports');

  void store(Map<String, dynamic> body) {
    db.add(body);
  }
}
