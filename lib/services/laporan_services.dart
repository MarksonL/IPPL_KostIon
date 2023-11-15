import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanServices {
  final db = FirebaseFirestore.instance.collection('reports');

  Stream<QuerySnapshot> list() {
    return db.snapshots();
  }

  // READ: ambil data detail kos
  Stream<DocumentSnapshot<Object?>> getDetail(String id) {
    final dataStream = db.doc(id).snapshots();
    return dataStream;
  }

  void store(Map<String, dynamic> body) {
    db.add(body);
  }

  Future<void> updateStatus(String id, String newStatus) async {
    await db.doc(id).update({'status': newStatus});
  }
}
