import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In
import 'package:kostion/data/model/userProfile.dart';
import 'package:kostion/presentation/owner/OwnerRegistrationPage.dart';
import 'OwnerResetPasswordPage.dart';
import 'package:kostion/presentation/owner/OwnerHomePage.dart';

class LoginPageOwner extends StatefulWidget {
  @override
  _LoginPageOwnerState createState() => _LoginPageOwnerState();
}

class _LoginPageOwnerState extends State<LoginPageOwner> {
  GoogleSignInAccount? _currentUser;

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // Buat instance dari GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('KostIon'),
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputfield(context),
                _forgotpassword(context),
                _registrasi(context),
                _googleSignInButton(), // Tambahkan tombol login Google
              ]),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          'Selamat Datang Pemilik Kos!',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        Text(
          'Silahkan Login',
          style: TextStyle(fontSize: 20, color: Colors.amber),
        ),
      ],
    );
  }

  _inputfield(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.person)),
        ),
        SizedBox(height: 15),
        TextField(
          decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
        ),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: ()
              // logikanya belum
              {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OwnerHomePage()),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        )
      ],
    );
  }

  _forgotpassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OwnerResetPasswordPage()),
        );
      },
      child: const Text('Lupa Password?'),
    );
  }

  _registrasi(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Belum memiliki akun?'),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OwnerRegistrationPage()),
              );
            },
            child: const Text('Daftar'))
      ],
    );
  }

  // Tambahkan method untuk menampilkan tombol login Google
  Widget _googleSignInButton() {
    return ElevatedButton(
      onPressed: _handleGoogleSignIn, // Panggil method _handleGoogleSignIn
      child: Text(
        'Login dengan Google',
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  // Tambahkan method untuk menangani login dengan Google
  void _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Login berhasil, Anda dapat menavigasi ke halaman yang sesuai di sini
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OwnerHomePage()),
        );
      } else {
        // Login dibatalkan atau gagal
        // Handle kesalahan atau tindakan yang sesuai
      }
    } catch (error) {
      // Handle kesalahan login Google
      print(error.toString());
    }
  }
}
