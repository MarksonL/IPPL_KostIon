import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class KosServices {
  // final User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance.collection('kos');
  final db01 = FirebaseFirestore.instance.collection("users");
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

  // READ: ambil data detail kos
  Stream<DocumentSnapshot<Object?>> getDetail(String id) {
    final dataStream = db.doc(id).snapshots();
    return dataStream;
  }

  // READ: list fasilitas
  Stream<QuerySnapshot> fasilitas(String id) {
    return db
        .doc(id)
        .collection('fasilitas')
        .orderBy('created', descending: true)
        .snapshots();
  }

  // ADD: tambah fasilitas
  Future<void> addFasilitas(Map<String, dynamic> body, String kosId) {
    return db.doc(kosId).collection('fasilitas').add(body);
  }

  Future<void> deleteFasilitas(String kosId, String id) {
    return db.doc(kosId).collection('fasilitas').doc(id).delete();
  }

  // READ: list peraturan
  Stream<QuerySnapshot> peraturan(String id) {
    return db
        .doc(id)
        .collection('peraturan')
        .orderBy('created', descending: true)
        .snapshots();
  }

  Future<String> getNomorWA(String kosId) async {
    final snapshot = await db.doc(kosId).get();
    final snapshot2 = await db01.doc(snapshot['owner_id']).get();
    return snapshot2['nomorWa'];
    // return data2['nomorWa'];
    // print(data);
    // return snapshot;
    // dynamic ownerID = snapshot.data()?.owner_id;
    // return db01.doc
  }

  // ADD: tambah peraturan
  Future<void> addPeraturan(Map<String, dynamic> body, String kosId) {
    return db.doc(kosId).collection('peraturan').add(body);
  }

  Future<void> deletePeraturan(String kosId, String id) {
    return db.doc(kosId).collection('peraturan').doc(id).delete();
  }
}
