import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class KosServices {
  // final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance.collection('kos');
  final storage = FirebaseStorage.instance;

  // READ: ambil data kos
  Stream<QuerySnapshot> getData() {
    final dataStream = db.orderBy('created', descending: true).snapshots();
    return dataStream;
  }

  // CREATE: tambah data kos { "asdasd": string, int dlll }
  Future<void> addData(Map<String, dynamic> body) {
    // hit save image
    // simpan dataß
    return db.add(body);
  }

  // READ: ambil data kos
  Stream<DocumentSnapshot<Object?>> getDetail(String id) {
    final dataStream = db.doc(id).snapshots();
    return dataStream;
  }

  // READ: list fasilitas
  Stream<QuerySnapshot> fasilitas(String id) {
    return db.doc(id).collection('fasilitas').snapshots();
  }

  // ADD: tambah fasilitas
  Future<void> addFasilitas(Map<String, dynamic> body, String kosId) {
    return db.doc(kosId).collection('fasilitas').add(body);
  }
}
