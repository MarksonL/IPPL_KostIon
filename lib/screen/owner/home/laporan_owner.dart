import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/laporan_detail.dart';
import 'package:kostlon/services/laporan_services.dart';

class LaporanOwnerScreen extends StatefulWidget {
  const LaporanOwnerScreen({super.key});

  @override
  State<LaporanOwnerScreen> createState() => _LaporanOwnerScreenState();
}

class _LaporanOwnerScreenState extends State<LaporanOwnerScreen> {
  LaporanServices laporanServices = LaporanServices();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: laporanServices.list(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var items = snapshot.data!.docs;
        var laporan =
            items.where((reports) => reports['owner_id'] == user?.uid).toList();

        return ListView.builder(
          shrinkWrap: true,
          itemCount: laporan.length,
          itemBuilder: (context, index) {
            var item = laporan[index];

            return ListTile(
              title: Text("${item['nama_kos']} - Kamar (${item['no_kamar']})"),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Laporan: ${item['kerusakan']}"),
                    Text("Deskripsi: ${item['deskripsi']}"),
                  ]),
              onTap: () {
                final String id = laporan[index].id;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LaporanDetail(
                      id: id,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
