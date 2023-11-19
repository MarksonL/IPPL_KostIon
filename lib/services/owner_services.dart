import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerServices {
  final db = FirebaseFirestore.instance.collection('kos_member');
  final db01 = FirebaseFirestore.instance.collection('kos');

  // READ: ambil data kos
  Stream<QuerySnapshot> reqMasuk(String ownerId) {
    final dataStream = db
        .where('owner_id', isEqualTo: ownerId)
        .where('approved', isEqualTo: false)
        .snapshots();
    return dataStream;
  }

  // READ: ambil data kos
  Stream<QuerySnapshot> member(String ownerId) {
    final dataStream = db
        .where('owner_id', isEqualTo: ownerId)
        .where('approved', isEqualTo: true)
        .snapshots();
    return dataStream;
  }

  Stream<QuerySnapshot> reqKeluar(String ownerId) {
    final dataStream = db
        .where('owner_id', isEqualTo: ownerId)
        .where('reqKeluar', isEqualTo: true)
        .snapshots();
    return dataStream;
  }

  void approveMasuk(String docId) {
    db.doc(docId).update({'approved': true});
  }

  void rejectMasuk(String docId) {
    db.doc(docId).delete();
  }

  void approveKeluar(String docId) {
    db.doc(docId).update({'approved': false});
    db.doc(docId).delete();
  }
}
