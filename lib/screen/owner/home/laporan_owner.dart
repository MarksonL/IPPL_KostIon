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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: laporanServices.list(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var items = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];

              return ListTile(
                title:
                    Text("${item['kerusakan']} - Kamar (${item['no_kamar']})"),
                subtitle: Text("${item['deskripsi']}"),
                onTap: () {
                  final String id = items[index].id;
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
      ),
    );
  }
}
