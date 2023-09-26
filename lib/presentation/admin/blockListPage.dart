import 'package:flutter/material.dart';

class BlockUserPage extends StatelessWidget {
  // Konstruktor untuk mengirimkan data pengguna atau kost yang akan diblokir
  // Anda dapat menambahkan parameter sesuai kebutuhan
  const BlockUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemblokiran'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Tampilkan informasi tentang pengguna atau kost yang akan diblokir
            const Text('Nama Pengguna atau Kost'),
            const SizedBox(height: 20),
            // Tombol untuk melakukan pemblokiran
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika pemblokiran di sini
                // Anda dapat mengubah status pengguna atau kost menjadi "diblokir"
                // dan kembali ke halaman admin
                Navigator.pop(
                    context); // Kembali ke halaman admin setelah pemblokiran
              },
              child: const Text('Blokir'),
            ),
          ],
        ),
      ),
    );
  }
}
