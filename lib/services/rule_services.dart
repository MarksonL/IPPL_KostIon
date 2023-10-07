import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RulesServices {
  // final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance.collection('rules');

  // READ: ambil data kos
  Stream<QuerySnapshot> getData() {
    final dataStream = db.orderBy('created', descending: true).snapshots();
    return dataStream;
  }

  // CREATE: tambah data kos
  Future<void> addData(Map<String, dynamic> body) {
    return db.add(body);
  }

  // DELETE: hapus data kos
  Future<void> deleteData(String idData) {
    return db.doc(idData).delete();
  }
}
