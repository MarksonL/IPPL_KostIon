import 'package:flutter/material.dart';
import 'package:kostion/presentation/kostSearchDelegate.dart';
import 'package:kostion/data/model/kostData.dart';

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
        title: const Text('Beranda Penghuni Kost'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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
    );
  }
}
