import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kostlon/screen/member/home_member.dart';
import 'package:kostlon/screen/owner/home_owner.dart';

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
              decoration: InputDecoration(labelText: 'Nama Pengguna'),
            ),
            SizedBox(height: 20),
            Text('Pilih Peran:'),
            Row(
              children: [
                Radio(
                  value: 'member',
                  groupValue: _selectedRole,
                  onChanged: _handleRoleChange,
                ),
                Text('Member'),
                Radio(
                  value: 'owner',
                  groupValue: _selectedRole,
                  onChanged: _handleRoleChange,
                ),
                Text('Owner'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitProfile,
              child: Text('Simpan Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
