import 'package:flutter/material.dart';
import 'package:kostion/presentation/kostDetailPage.dart';

class NewKostListPage extends StatelessWidget {
  final List<Kost> newKosts;

  NewKostListPage({required this.newKosts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kost Baru'),
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
