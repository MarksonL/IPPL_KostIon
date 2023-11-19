import 'package:cloud_firestore/cloud_firestore.dart';

class MemberServices {
  final db = FirebaseFirestore.instance.collection('kos_member');

  Stream<QuerySnapshot> listKostRent(String userId) {
    final dataStream = db.where('user_id', isEqualTo: userId).snapshots();
    return dataStream;
  }

  // CREATE: tambah data member
  bool addData(Map<String, dynamic> body) {
    db.add(body);
    return true;
  }

  Stream<DocumentSnapshot> detailRent(String docId) {
    final dataStream = db.doc(docId).snapshots();
    return dataStream;
  }

  void reqKeluar(String docId) {
    db.doc(docId).update({'reqKeluar': true});
  }
}
