import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
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

  // CREATE: tambah data kos
  Future<void> addData(Map<String, dynamic> body, File? imageFile) async {
    if (imageFile != null) {
      try {
        // Generate unique filename for the image
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();

        // Upload the image to Firebase Storage
        final storageRef = storage.ref().child('kos_images/$imageName.jpg');
        final uploadTask = storageRef.putFile(imageFile);

        // Wait for the upload task to complete
        await uploadTask.whenComplete(() async {
          // Get the download URL for the uploaded image
          final imageUrl = await storageRef.getDownloadURL();

          // Add the image URL to the data
          body['image_url'] = imageUrl;

          // Add the data to Firestore
          await db.add(body);
        });
      } catch (e) {
        print('Error uploading image and adding data: $e');
      }
    } else {
      // If no image is provided, add the data without an image
      await db.add(body);
    }
  }
}
