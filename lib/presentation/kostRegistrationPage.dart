import 'package:flutter/material.dart';

class KostRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kost Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama Kost',
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Alamat Kost',
              ),
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Jenis Kost',
              ),
              items: ['Pria', 'Wanita', 'Campuran'].map((String jenis) {
                return DropdownMenuItem<String>(
                  value: jenis,
                  child: Text(jenis),
                );
              }).toList(),
              onChanged: (String? value) {},
            ),
            const SizedBox(height: 20.0),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Deskripsi Kost',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan data pendaftaran kost baru
              },
              child: const Text('Daftar Kost Baru'),
            ),
          ],
        ),
      ),
    );
  }
}
