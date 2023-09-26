import 'package:flutter/material.dart';

class TenantProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 70.0,
            backgroundImage: AssetImage(
                'assets/user_avatar.jpg'), // Ganti dengan gambar profil pengguna
          ),
          SizedBox(height: 10.0),
          Text(
            'Nama Pengguna',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Email: pengguna@example.com', // Ganti dengan alamat email pengguna
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk mengarahkan pengguna ke halaman edit profil
            },
            child: Text('Edit Profil'),
          ),
        ],
      ),
    );
  }
}
