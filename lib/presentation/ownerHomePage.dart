import 'package:flutter/material.dart';
import 'package:kostion/presentation/kostRegistrationPage.dart';

class OwnerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Pemilik Kost'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KostRegistrationPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Selamat Datang, Pemilik Kost!'),
      ),
    );
  }
}
