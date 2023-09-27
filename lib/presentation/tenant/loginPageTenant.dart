import 'package:flutter/material.dart';
import 'package:kostion/data/model/userProfile.dart';
import 'package:kostion/presentation/registrationPage.dart';
import 'package:kostion/presentation/resetpasswordpage.dart';
import 'package:kostion/presentation/tenant/tenantHomePage.dart';

class LoginPageTenant extends StatefulWidget {
  @override
  _LoginPageTenantState createState() => _LoginPageTenantState();
}

class _LoginPageTenantState extends State<LoginPageTenant> {
  UserType? selectedUserType;

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
              ]),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          'Selamat Datang Penghuni Kos!',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber),
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
              labelText: "Username",
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TenantHomePage()),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
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
          MaterialPageRoute(builder: (context) => ResetPasswordPage()),
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
                MaterialPageRoute(builder: (context) => RegistrationPage()),
              );
            },
            child: const Text('Daftar'))
      ],
    );
  }
}
