import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kostlon/utils/color_theme.dart';

class PembayaranForm extends StatefulWidget {
  @override
  _PembayaranFormState createState() => _PembayaranFormState();
}

class _PembayaranFormState extends State<PembayaranForm> {
  final TextEditingController descriptionController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage;
    });
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
              Text(
                'Upload Foto Pembayaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
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
              Text(
                'Deskripsi Pembayaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Masukkan deskripsi pembayaran',
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String description = descriptionController.text;
                    // Lakukan sesuatu dengan deskripsi dan gambar yang dipilih
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.teal,
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  ),
                  child: Text(
                    'Kirim Pembayaran',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
