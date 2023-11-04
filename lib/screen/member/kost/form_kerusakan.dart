import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:kostlon/services/laporan_services.dart';
import 'dart:io';

import 'package:kostlon/utils/color_theme.dart';

class LaporanKerusakanForm extends StatefulWidget {
  @override
  _LaporanKerusakanFormState createState() => _LaporanKerusakanFormState();
}

class _LaporanKerusakanFormState extends State<LaporanKerusakanForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomorKamarController = TextEditingController();
  TextEditingController _judulKerusakanController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  XFile? _selectedImage;
  // final LaporanServices laporanServices = LaporanServices();

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  void submit(BuildContext context) async {
    User? member = FirebaseAuth.instance.currentUser;
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> body = {
        // 'name': member?.displayName,
        // 'member_id': member?.uid,
        // 'kos': 'kos 1',
        // 'kos_id': '1',
        // 'kamar': _nomorKamarController.text,
        // 'judul': _judulKerusakanController.text,
        // 'keterangan': _keteranganController.text
      };
      try {
        // Implementasikan logika untuk mengirim laporan kerusakan ke server atau penyimpanan data
        // ...
        // Setelah berhasil mengirim laporan, tampilkan pesan sukses atau kembali ke halaman sebelumnya
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Laporan kerusakan berhasil dikirim'),
        //   ),
        // );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporkan Kerusakan'),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Pilih Gambar Kerusakan'),
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
              ),
              // GAMBAR KERUSAKAN
              // _image != null
              //     ? Image.file(
              //         _image,
              //         height: 150,
              //       )
              //     : Container(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Nomor Kamar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _nomorKamarController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nomor kamar tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Judul Kerusakan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _judulKerusakanController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Judul kerusakan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Keterangan Kerusakan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _keteranganController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Keterangan kerusakan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => submit(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary),
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
