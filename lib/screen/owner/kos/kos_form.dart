// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kostlon/utils/color_theme.dart';

import 'package:kostlon/services/kos_services.dart';

class OwnerKostFormPage extends StatefulWidget {
  const OwnerKostFormPage({super.key});

  @override
  State<OwnerKostFormPage> createState() => _OwnerKostFormPageState();
}

class _OwnerKostFormPageState extends State<OwnerKostFormPage> {
  final storageRef = FirebaseStorage.instance.ref();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final KosServices kosServices = KosServices();
  int _jumlahKamar = 1; // Default jumlah kamar
  XFile? _selectedImage; // Inisialisasi _selectedImage dengan null

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage;
    });
  }

  // 1. upload gambar untuk mendapatkan url
  void submit(BuildContext context) async {
    if (_selectedImage == null) {
      // Tampilkan pesan kesalahan jika tidak ada gambar yang dipilih.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon untuk memilih gambar kost'),
          duration: Duration(seconds: 1),
        ),
      );
    } else if (_namaController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _hargaController.text.isEmpty) {
      // Tampilkan pesan kesalahan jika salah satu kolom yang dibutuhkan kosong.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon untuk mengisi form dengan benar'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      final fileRef = storageRef.child('kos/${_selectedImage!.name}');
      final File file = File(_selectedImage!.path);
      context.loaderOverlay.show();
      try {
        final resp = await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        storeData(context, url.toString());
        debugPrint(url.toString());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan saat menyimpan data'),
            duration: Duration(seconds: 1),
          ),
        );
        debugPrint('Terjadi kesalahan: $e');
      } finally {
        context.loaderOverlay.hide();
      }
    }
  }

  // 2. simpan data ke firebase database
  void storeData(BuildContext context, String imgPath) async {
    // ambil data user yang sedang login
    User? owner = FirebaseAuth.instance.currentUser;
    //
    Map<String, dynamic> body = {
      "image": imgPath,
      "name": _namaController.text,
      "owner": owner?.displayName,
      "owner_id": owner?.uid,
      "price": int.parse(_hargaController.text),
      "alamat": _alamatController.text,
      "publish": true,
      "jumlah": _jumlahKamar,
      "created": Timestamp.now()
    };

    context.loaderOverlay.show();
    try {
      await kosServices.addData(body);
      // action setelah data berhasil di tambahkan
      reset();
      // navigasi ke halaman utama
      Navigator.pop(context);
      context.loaderOverlay.hide();
    } catch (e) {
      context.loaderOverlay.hide();
      debugPrint(e.toString());
    }
  }

  void reset() {
    setState(() {
      _namaController.clear();
      _hargaController.clear();
      _alamatController.clear();
      _jumlahKamar = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedImage =
        null; // Inisialisasi _selectedImage dengan null dalam initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text("Formulir tambah kos"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: _getImage,
              child: _selectedImage == null
                  ? Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey,
                      child:
                          Icon(Icons.camera_alt, size: 50, color: Colors.white),
                      alignment: Alignment.center,
                    )
                  : Image.file(
                      File(_selectedImage!.path),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: ElevatedButton(
            //     onPressed: () => _uploadFile(),
            //     child: Text('Upload File'),
            //   ),
            // ),
            SizedBox(height: 20),
            TextInput(
              inputController: _namaController,
              label: 'Nama Kos',
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            TextInput(
              inputController: _alamatController,
              label: 'Alamat',
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            TextInput(
              inputController: _hargaController,
              label: 'Harga (per bulan)',
              type: TextInputType.number,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Jumlah Kamar',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_jumlahKamar > 1) {
                          _jumlahKamar--;
                        }
                      });
                    },
                  ),
                  Text(
                    '$_jumlahKamar',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _jumlahKamar++;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () => submit(context),
                child: Text('Simpan'),
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.label,
      required TextEditingController inputController,
      required this.type})
      : _controller = inputController;

  final TextEditingController _controller;
  final String label;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _controller,
        keyboardType: type,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
