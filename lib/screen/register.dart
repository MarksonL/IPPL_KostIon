import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kostlon/screen/start_profile.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Registrasi sukses, lanjutkan ke halaman berikutnya atau tampilkan pesan sukses
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => StartProfilePage()));
      } on FirebaseAuthException catch (e) {
        // Tangani pengecualian Firebase Authentication
        if (e.code == 'email-already-in-use') {
          // Email sudah terdaftar, tampilkan pemberitahuan kepada pengguna
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Akun sudah ada'),
                content: Text(
                    'Email ini sudah terdaftar. Silakan gunakan email lain atau masuk dengan email ini.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Tutup'),
                  ),
                ],
              );
            },
          );
        } else {
          // Penanganan kesalahan lainnya
          print('Kesalahan saat mendaftar: ${e.message}');
        }
      } catch (e) {
        // Penanganan kesalahan lainnya
        print('Kesalahan saat mendaftar: $e');
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
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
