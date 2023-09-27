import 'package:flutter/material.dart';

class TenantProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profil Pengguna'),
          backgroundColor: Colors.amber,
        ),
        body: UserProfile(),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage(
                        'assets/user_avatar.jpg'), // Ganti dengan gambar profil pengguna
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.black, // Ganti dengan warna teks yang sesuai
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Email: user@example.com', // Ganti dengan informasi profil pengguna
                    style: TextStyle(
                      fontSize: 16.0,
                      color:
                          Colors.black, // Ganti dengan warna teks yang sesuai
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.person),
            title:
                Text('Tentang Saya'), // Ganti dengan informasi profil pengguna
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('0878xxxxx'), // Ganti dengan informasi profil pengguna
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(
                'Jl.Sbhgxyennsjhsd No 1xx'), // Ganti dengan informasi profil pengguna
          ),
          Divider(),
          // Tambahkan informasi profil lainnya di sini sesuai kebutuhan Anda
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk mengganti akun di sini, arahkan ke formulir ubah profil
            },
            child: Text('Ubah Profil'),
          )
        ],
      ),
    );
  }
}
