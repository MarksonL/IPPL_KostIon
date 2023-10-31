import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LaporanServices {
  final User? user = FirebaseAuth.instance.currentUser;
  // final db = FirebaseFirestore.instance.collection('kos');
  final storage = FirebaseStorage.instance;

  Future<void> addData(Map<String, dynamic> body) async {
    // hit save image
    // simpan data
    // return db.add(body);
    return print(body);
  }
}
