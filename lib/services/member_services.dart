import 'package:cloud_firestore/cloud_firestore.dart';

class MemberServices {
  final db = FirebaseFirestore.instance.collection('kos_member');

  Stream<QuerySnapshot> listKostRent(String userId) {
    final dataStream = db
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots();
    return dataStream;
  }

  // CREATE: tambah data member
  bool addData(Map<String, dynamic> body) {
    bool res = false;
    final isSubmit = db
        .where('kos_id', isEqualTo: body['kos_id'])
        .count()
        .get()
        .then((value) {
      if (value.count > 0) {
        res = false;
      } else {
        db.add(body);
        res = true;
      }
    });
    return res;
  }
}
