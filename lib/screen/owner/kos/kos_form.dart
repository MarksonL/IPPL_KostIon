import 'package:flutter/material.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OwnerKostFormPage extends StatefulWidget {
  const OwnerKostFormPage({super.key});

  @override
  State<OwnerKostFormPage> createState() => _OwnerKostFormPageState();
}

class _OwnerKostFormPageState extends State<OwnerKostFormPage> {
  final KosServices rulesServices = KosServices();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  int _jumlahKamar = 1; // Default jumlah kamar
  XFile? _selectedImage; // Inisialisasi _selectedImage dengan null

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage;
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
              onPressed: () {
                String namaKos = _namaController.text;
                String alamat = _alamatController.text;
                String harga = _hargaController.text;

                // Logika untuk menyimpan data kos ke database
                // Panggil fungsi atau service yang sesuai untuk menyimpan data
                // rulesServices.simpanDataKos(namaKos, alamat, harga, _jumlahKamar);
                // Logika untuk menyimpan data kos ke database
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
