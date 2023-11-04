import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TransactionServices {
  // final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance.collection('transaction');
  final storage = FirebaseStorage.instance;

  // CREATE: tambah data pengajuan kos
  Future<void> addData(Map<String, dynamic> body) {
    return db.add(body);
  }
}
