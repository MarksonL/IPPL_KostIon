import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

enum UserType { tenant, owner, admin }

class UserProfile {
  final String name;
  final String email;
  final UserType userType;

  UserProfile({
    required this.name,
    required this.email,
    required this.userType,
  });
}

class Kost {
  final String name;
  final String location;
  final String type; // Jenis kost (pria, wanita, campuran)
  final String description; // Deskripsi kost

  Kost({
    required this.name,
    required this.location,
    required this.type,
    required this.description,
  });
}

List<UserProfile> userProfiles = [
  UserProfile(
    name: 'John Doe',
    email: 'john@example.com',
    userType: UserType.tenant,
  ),
  UserProfile(
    name: 'Jane Smith',
    email: 'jane@example.com',
    userType: UserType.owner,
  ),
  // Tambahkan profil pengguna lainnya di sini
];

List<Kost> availableKosts = [
  Kost(name: 'Kost A', location: 'Jalan A', type: 'laki', description: 'keren'),
  Kost(
      name: 'Kost B',
      location: 'Jalan B',
      type: 'perempuan',
      description: 'keren juga'),
  // Tambahkan daftar kost yang tersedia di sini
];

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
        title: Text('KostIon'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  RadioListTile<UserType>(
                    title: Text('Penghuni Kost'),
                    value: UserType.tenant,
                    groupValue: selectedUserType,
                    onChanged: (UserType? value) {
                      setState(() {
                        selectedUserType = value;
                      });
                    },
                  ),
                  RadioListTile<UserType>(
                    title: Text('Pemilik Kost'),
                    value: UserType.owner,
                    groupValue: selectedUserType,
                    onChanged: (UserType? value) {
                      setState(() {
                        selectedUserType = value;
                      });
                    },
                  ),
                  RadioListTile<UserType>(
                    title: Text('Admin'),
                    value: UserType.admin,
                    groupValue: selectedUserType,
                    onChanged: (UserType? value) {
                      setState(() {
                        selectedUserType = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika autentikasi di sini
                  // Jika autentikasi berhasil, arahkan pengguna ke halaman beranda sesuai tipe pengguna
                  if (selectedUserType == UserType.tenant) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TenantHomePage()),
                    );
                  } else if (selectedUserType == UserType.owner) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OwnerHomePage()),
                    );
                  } else if (selectedUserType == UserType.admin) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHomePage()),
                    );
                  }
                },
                child: Text('Login'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                child: Text('Daftar'),
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
    );
  }
}

class TenantHomePage extends StatefulWidget {
  @override
  _TenantHomePageState createState() => _TenantHomePageState();
}

class _TenantHomePageState extends State<TenantHomePage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredKosts = availableKosts.where((kost) {
      final kostNameLower = kost.name.toLowerCase();
      final searchLower = searchText.toLowerCase();
      return kostNameLower.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Penghuni Kost'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: KostSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Cari Kost',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredKosts.length,
              itemBuilder: (context, index) {
                final kost = filteredKosts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Tambahkan logika untuk menampilkan detail kost
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/kost_image.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  kost.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  kost.location,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KostSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementasi hasil pencarian
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = availableKosts.where((kost) {
      final kostNameLower = kost.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return kostNameLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final kost = suggestionList[index];
        return ListTile(
          title: Text(kost.name),
          onTap: () {
            close(context, kost.name);
          },
        );
      },
    );
  }
}

class KostRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kost Baru'),
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
            SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Alamat Kost',
              ),
            ),
            SizedBox(height: 20.0),
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
            SizedBox(height: 20.0),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Deskripsi Kost',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan data pendaftaran kost baru
              },
              child: Text('Daftar Kost Baru'),
            ),
          ],
        ),
      ),
    );
  }
}

class OwnerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Pemilik Kost'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
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
            icon: Icon(Icons.list),
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

class NewKostListPage extends StatelessWidget {
  final List<Kost> newKosts;

  NewKostListPage({required this.newKosts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kost Baru'),
      ),
      body: ListView.builder(
        itemCount: newKosts.length,
        itemBuilder: (context, index) {
          final kost = newKosts[index];
          return ListTile(
            title: Text(kost.name),
            subtitle: Text(kost.location),
            onTap: () {
              // Tampilkan detail kost dan berikan opsi untuk memverifikasi
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KostDetailPage(kost: kost),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class KostDetailPage extends StatelessWidget {
  final Kost kost;

  KostDetailPage({required this.kost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kost'),
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
            SizedBox(height: 10.0),
            Text(
              'Alamat Kost: ${kost.location}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Jenis Kost: ${kost.type}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Deskripsi Kost: ${kost.description}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk memverifikasi kost
              },
              child: Text('Verifikasi Kost'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika pendaftaran di sini
                },
                child: Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika reset password di sini
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
