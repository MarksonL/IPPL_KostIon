import 'package:flutter/material.dart';
import 'package:kostion/presentation/owner/kostRegistrationPage.dart';
import 'package:kostion/presentation/kostSearchDelegate.dart';
import 'package:kostion/presentation/owner/OwnerProfilePage.dart';
import 'package:kostion/data/model/kostData.dart';
import 'package:kostion/presentation/kostSearchDelegate.dart';

class OwnerHomePage extends StatefulWidget {
  @override
  _OwnerHomePageState createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
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
      body: Column(
        children: [
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
                                const SizedBox(height: 5),
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kos Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari Kos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            // Jika pengguna mengklik ikon profil (indeks 2)
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => KostSearchDelegate()),
            );
          } else if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OwnerProfilePage()),
            );
          }
        },
      ),
    );
  }
}
