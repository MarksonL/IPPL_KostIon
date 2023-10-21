import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kostlon/screen/member/home_member.dart';
import 'package:kostlon/screen/owner/home_owner.dart';
import 'package:kostlon/utils/color_theme.dart';

class StartProfilePage extends StatefulWidget {
  @override
  _StartProfilePageState createState() => _StartProfilePageState();
}

class _StartProfilePageState extends State<StartProfilePage> {
  String _selectedRole = 'member';
  final TextEditingController _nameController = TextEditingController();

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
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda ingin menyimpan profil?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
                _saveProfile();
              },
              child: Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('Tidak'),
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

        final userRef = FirebaseFirestore.instance.collection("users");
        await userRef.doc(uid).set({'name': name, 'role': _selectedRole});

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Profil Berhasil Disimpan'),
              content: Text('Profil Anda telah berhasil disimpan.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog sukses
                    if (_selectedRole == 'member') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeMemberPage()));
                    } else if (_selectedRole == 'owner') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeOwnerPage()));
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atur Profil'),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Isi Profil Anda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Text(
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
                Text(
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
                Text(
                  'Owner',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Flexible(
            //   flex: 1, // Proporsi fleksibilitas, bisa disesuaikan
            //   child: Container(), // Spacer untuk memberi ruang kosong
            // ),
            // Expanded(
            //   child: Container(), // Spacer untuk membuat tombol di tengah
            // ),
            ElevatedButton(
              onPressed: _submitProfile,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 0,
                backgroundColor: AppColor.primary,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text('Simpan Profil'),
            ),
          ],
        ),
      ),
    );
  }
}