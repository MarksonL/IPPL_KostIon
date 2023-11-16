// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:kostlon/services/payment_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class PembayaranForm extends StatefulWidget {
  const PembayaranForm({
    super.key,
    required this.kos,
  });

  final Map<String, dynamic> kos;
  @override
  _PembayaranFormState createState() => _PembayaranFormState();
}

class _PembayaranFormState extends State<PembayaranForm> {
  final TextEditingController _jumlahController = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();
  XFile? _selectedImage;

  PaymentServices paymentServices = PaymentServices();
  final KosServices kosServices = KosServices();

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage;
    });
  }

  void submit(BuildContext context) async {
    if (_selectedImage != null) {
      final fileRef = storageRef.child('pembayaran/${_selectedImage!.name}');
      final File file = File(_selectedImage!.path);
      // context.loaderOverlay.show();
      try {
        await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        storeData(context, url.toString());
        debugPrint(url.toString());
        // context.loaderOverlay.hide();
      } catch (e) {
        // context.loaderOverlay.hide();
        debugPrint('terjadi kesalahan');
      }
    }
  }

  void storeData(BuildContext context, String urlImage) {
    User? user = FirebaseAuth.instance.currentUser;
    paymentServices.store({
      "member_id": user!.uid,
      "image": urlImage,
      "status": "new",
      "pembayaran": _jumlahController.text,
      ...widget.kos,
      "created": Timestamp.now()
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Pembayaran'),
        backgroundColor: AppColor
            .primary, // Atur warna latar belakang app bar menjadi oranye
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kotak informasi rincian pembayaran
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rincian Pembayaran:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    StreamBuilder(
                      // Menggunakan StreamBuilder untuk menampilkan data yang berubah dari Firestore
                      stream: kosServices.getDetail(widget.kos[
                          'kos_id']), // Anggap 'kos_id' adalah identifier unik untuk 'kos' Anda
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Text('Data tidak ditemukan.');
                        } else {
                          // Jika data tersedia, tampilkan
                          var kosData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama Kos: ${kosData['name']}'),
                              Text('Harga Sewa/bulan: ${kosData['price']}'),
                              // Tambahkan detail lain sesuai kebutuhan
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Formulir Pembayaran:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: _getImage,
                  child: _selectedImage == null
                      ? Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey,
                          child: Icon(Icons.camera_alt,
                              size: 50, color: Colors.white),
                          alignment: Alignment.center,
                        )
                      : Image.file(
                          File(_selectedImage!.path),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 8),
              TextFormField(
                controller: _jumlahController,
                decoration: InputDecoration(
                  label: Text('Jumlah Pembayaran'),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  submit(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColor.primary, // Warna latar belakang tombol
                ),
                child: Text(
                  'Kirim Pembayaran',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Kotak informasi rincian pembayaran
            ],
          ),
        ),
      ),
    );
  }
}
