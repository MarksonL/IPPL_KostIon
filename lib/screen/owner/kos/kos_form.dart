import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kostlon/services/kos_services.dart';

class OwnerKostFormPage extends StatefulWidget {
  const OwnerKostFormPage({super.key});

  @override
  State<OwnerKostFormPage> createState() => _OwnerKostFormPageState();
}

class _OwnerKostFormPageState extends State<OwnerKostFormPage> {
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

  void submit(BuildContext context) async {
    // ambil data user yang sedang login
    User? owner = FirebaseAuth.instance.currentUser;
    //
    Map<String, dynamic> body = {
      "name": _namaController.text,
      "owner": owner?.displayName,
      "owner_id": owner?.uid,
      "price": int.parse(_hargaController.text),
      "alamat": _alamatController.text,
      "publish": true,
      "jumlah": _jumlahKamar,
      "created": Timestamp.now()
    };
    try {
      await kosServices.addData(body);
      // action setelah data berhasil di tambahkan
      reset();
      // navigasi ke halaman utama
      Navigator.pop(context);
      print('sucess');
    } catch (e) {
      print(e);
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
        title: Text("Formulir tambah kos"),
        centerTitle: true,
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
            SizedBox(height: 20),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Kos'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harga (per bulan)'),
            ),
            SizedBox(height: 20),
            Text(
              'Jumlah Kamar',
              style: TextStyle(fontSize: 15),
            ),
            Row(
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => submit(context),
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
