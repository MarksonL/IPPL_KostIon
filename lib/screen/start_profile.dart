import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        String name = _nameController.text;

        final userRef = FirebaseFirestore.instance.collection("users");
        await userRef.doc(uid).set({'name': name, 'role': _selectedRole});
        print("user id: $uid");
      }
    } catch (e) {
      print('Kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Awal'),
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
