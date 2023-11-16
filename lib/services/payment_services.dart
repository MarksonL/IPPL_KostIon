import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentServices {
  final db = FirebaseFirestore.instance.collection('payments');

  Stream<QuerySnapshot> list() {
    return db.snapshots();
  }

  void store(Map<String, dynamic> body) {
    db.add(body);
  }

  // READ: ambil data detail kos
  Stream<DocumentSnapshot<Object?>> getDetail(String id) {
    final dataStream = db.doc(id).snapshots();
    return dataStream;
  }
}
