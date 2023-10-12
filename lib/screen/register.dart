import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  String _selectedRole = 'member'; // Default role adalah 'member'

  void _handleRoleChange(String? value) {
    setState(() {
      if (value != null) {
        _selectedRole = value;
      }
    });
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Lakukan pendaftaran pengguna ke Firebase dengan email dan password, dan simpan nama dan role
        // Contoh menggunakan Firebase Authentication
        User? user =
            (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ))
                .user;
        // Simpan informasi tambahan pengguna ke Firestore atau Realtime Database sesuai kebutuhan
        // Anda dapat menggunakan Firebase Firestore untuk ini
        if (user != null) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': _nameController.text,
            'role': _selectedRole,
          });
        }

        // Registrasi sukses, lanjutkan ke halaman berikutnya atau tampilkan pesan sukses
      } catch (e) {
        // Penanganan kesalahan
        print("Kesalahan saat mendaftar: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 10),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  child: Text('Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
