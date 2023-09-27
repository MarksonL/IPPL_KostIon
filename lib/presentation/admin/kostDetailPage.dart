import 'package:flutter/material.dart';
import 'package:kostion/data/model/kost.dart';

class KostDetailPage extends StatelessWidget {
  final Kost kost;

  KostDetailPage({required this.kost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kost'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Nama Kost: ${kost.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Alamat Kost: ${kost.location}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Jenis Kost: ${kost.type}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Deskripsi Kost: ${kost.description}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk memverifikasi kost
              },
              child: const Text('Verifikasi Kost'),
            ),
          ],
        ),
      ),
    );
  }
}
