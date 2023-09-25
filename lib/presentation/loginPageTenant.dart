import 'package:flutter/material.dart';
import 'package:kostion/data/model/userProfile.dart';
import 'package:kostion/presentation/adminHomePage.dart';
import 'package:kostion/presentation/ownerHomePage.dart';
import 'package:kostion/presentation/registrationPage.dart';
import 'package:kostion/presentation/resetpasswordpage.dart';
import 'package:kostion/presentation/tenantHomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserType? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KostIon'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RadioListTile<UserType>(
                      title: const Text('Penghuni Kost'),
                      value: UserType.tenant,
                      groupValue: selectedUserType,
                      onChanged: (UserType? value) {
                        setState(() {
                          selectedUserType = value;
                        });
                      },
                    ),
                    RadioListTile<UserType>(
                      title: const Text('Pemilik Kost'),
                      value: UserType.owner,
                      groupValue: selectedUserType,
                      onChanged: (UserType? value) {
                        setState(() {
                          selectedUserType = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.lock)),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika autentikasi di sini
                    // Jika autentikasi berhasil, arahkan pengguna ke halaman beranda sesuai tipe pengguna
                    if (selectedUserType == UserType.tenant) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TenantHomePage()),
                      );
                    } else if (selectedUserType == UserType.owner) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OwnerHomePage()),
                      );
                    } else if (selectedUserType == UserType.admin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminHomePage()),
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                  child: const Text('Daftar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordPage()),
                    );
                  },
                  child: const Text('Lupa Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
