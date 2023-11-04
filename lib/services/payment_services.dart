import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentServices {
  final db = FirebaseFirestore.instance.collection('payments');

  void store(Map<String, dynamic> body) {
    db.add(body);
  }
}
