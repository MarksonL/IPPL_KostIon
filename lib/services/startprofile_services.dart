import 'package:cloud_firestore/cloud_firestore.dart';

class RoleServices {
  final db = FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getData() {
    final dataStream = db.snapshots();
    return dataStream;
  }

  Future<void> addData(Map<String, dynamic> body) {
    return db.add(body);
  }
}
