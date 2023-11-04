import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerServices {
  final db = FirebaseFirestore.instance.collection('kos_member');

  // READ: ambil data kos
  Stream<QuerySnapshot> list(String ownerId) {
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

  void approve(String docId) {
    db.doc(docId).update({'approved': true});
  }

  void reject(String docId) {
    db.doc(docId).delete();
  }
}
