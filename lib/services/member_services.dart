import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MemberServices {
  // final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance.collection('kos');
  final storage = FirebaseStorage.instance;

  // CREATE: tambah data kos { "asdasd": string, int dlll }
  Future<void> addData(Map<String, dynamic> body) {
    // hit save image
    // simpan dataß
    return db.add(body);
  }
}
