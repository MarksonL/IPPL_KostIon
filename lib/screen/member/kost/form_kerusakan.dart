// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields, library_private_types_in_public_api, use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:kostlon/services/laporan_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class LaporanKerusakanForm extends StatefulWidget {
  const LaporanKerusakanForm({
    super.key,
    required this.kos,
  });

  final Map<String, dynamic> kos;
  @override
  _LaporanKerusakanFormState createState() => _LaporanKerusakanFormState();
}

class _LaporanKerusakanFormState extends State<LaporanKerusakanForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomorKamarController = TextEditingController();
  TextEditingController _judulKerusakanController = TextEditingController();
  TextEditingController _keteranganController = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();
  final KosServices kosServices = KosServices();
  Map<String, dynamic> kos = {};

  XFile? _selectedImage;
  final LaporanServices laporanServices = LaporanServices();

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  void submit(BuildContext context) async {
    if (_selectedImage != null) {
      final fileRef = storageRef.child('laporan/${_selectedImage!.name}');
      final File file = File(_selectedImage!.path);
      try {
        await fileRef.putFile(file);
        final url = await fileRef.getDownloadURL();
        storeData(context, url.toString());
        debugPrint(url.toString());
      } catch (e) {
        debugPrint('terjadi kesalahan');
      }
    }
  }

  void storeData(BuildContext context, String urlImage) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Ambil data kos berdasarkan ID kos dari widget
      DocumentSnapshot kosDoc =
          await KosServices().getDetail(widget.kos['kos_id']).first;
      Map<String, dynamic> kosData = kosDoc.data() as Map<String, dynamic>;

      // Simpan data laporan beserta informasi dari data kos
      laporanServices.store({
        "member_id": user!.uid,
        "image": urlImage,
        "status": "dilaporkan",
        "no_kamar": _nomorKamarController.text,
        "kerusakan": _judulKerusakanController.text,
        "deskripsi": _keteranganController.text,
        "created": Timestamp.now(),
        "kos_id": widget.kos['kos_id'], // Tambahkan kos_id
        "owner_id": kosData['owner_id'], // Tambahkan owner_id
        "nama_kos": kosData['name'],
        // Tambahkan field lain yang diinginkan
      });

      Navigator.pop(context);
    } catch (e) {
      // Handle error jika terjadi kesalahan
      debugPrint('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporkan Kerusakan'),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
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
                      borderSide:
                          BorderSide(color: AppColor.primary, width: 1.0),
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
                      borderSide:
                          BorderSide(color: AppColor.primary, width: 1.0),
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
                      borderSide:
                          BorderSide(color: AppColor.primary, width: 1.0),
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => submit(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary),
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
