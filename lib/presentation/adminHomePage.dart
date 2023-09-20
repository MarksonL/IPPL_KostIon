import 'package:flutter/material.dart';
import 'package:kostion/presentation/newKostListPage.dart';
import 'package:kostion/data/model/kost.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Buat daftar kost yang baru didaftarkan
    List<Kost> newKosts = [
      Kost(
        name: 'Kost C',
        location: 'Jalan C',
        type: 'Campuran',
        description: 'Kost dengan fasilitas lengkap.',
      ),
      // Tambahkan daftar kost yang baru didaftarkan di sini
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Admin'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // Tampilkan daftar kost yang baru didaftarkan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewKostListPage(newKosts: newKosts),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Selamat Datang, Admin!'),
      ),
    );
  }
}
