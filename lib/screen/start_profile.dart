import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kostlon/screen/auth.dart';
import 'package:kostlon/utils/color_theme.dart';

class StartProfilePage extends StatefulWidget {
  @override
  _StartProfilePageState createState() => _StartProfilePageState();
}

class _StartProfilePageState extends State<StartProfilePage> {
  String _selectedRole = 'member';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nomorWa = TextEditingController();

  void _handleRoleChange(String? value) {
    setState(() {
      if (value != null) {
        _selectedRole = value;
      }
    });
  }

  Future<void> _submitProfile() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda ingin menyimpan profil?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveProfile(); // Tutup dialog konfirmasi
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  void _saveProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        String name = _nameController.text;
        String nomorWa = _nomorWa.text;
        if (name.isEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Terjadi Kesalahan'),
                content: const Text('Mohon untuk dapat mengisi nama anda'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup dialog sukses
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          final userRef = FirebaseFirestore.instance.collection("users");
          await userRef
              .doc(uid)
              .set({'name': name, 'role': _selectedRole, 'nomorWa': nomorWa});

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Profil Berhasil Disimpan'),
                content: Text(
                    'Silakan lakukan verifikasi akun melalui link yang terdapat pada email yang telah dikirimkan untuk menyelesaikan proses verifikasi akun'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup dialog sukses
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Terjadi Kesalahan'),
              content: Text(
                  'Terjadi kesalahan dalam proses ini, mohon coba lagi nanti'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atur Profil'),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Isi Profil Anda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Nama Pengguna',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: AppColor.secondary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.primary),
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nomorWa,
              decoration: InputDecoration(
                  labelText: 'Nomor WhatsApp',
                  hintText: 'contoh: 62812-3456-7890 (gunakan kode negara)',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: AppColor.secondary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColor.primary),
                  )),
            ),
            SizedBox(height: 20),
            const Text(
              'Pilih Peran:',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: 'member',
                  groupValue: _selectedRole,
                  onChanged: _handleRoleChange,
                  activeColor: AppColor.primary,
                ),
                const Text(
                  'Member',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                SizedBox(width: 20),
                Radio(
                  value: 'owner',
                  groupValue: _selectedRole,
                  onChanged: _handleRoleChange,
                  activeColor: AppColor.primary,
                ),
                const Text(
                  'Owner',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitProfile,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  backgroundColor: AppColor.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
                child: const Text('Simpan Profil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
