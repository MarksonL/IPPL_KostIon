import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/components/list_text.dart';
import 'package:kostlon/services/laporan_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class LaporanDetailMember extends StatefulWidget {
  const LaporanDetailMember({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LaporanDetailMember> createState() => _LaporanDetailMember();
}

class _LaporanDetailMember extends State<LaporanDetailMember> {
  LaporanServices laporanServices = LaporanServices();
  late DocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Laporan'),
          backgroundColor: AppColor.primary,
          elevation: 0,
        ),
        body: ListView(
          children: [
            StreamBuilder(
                stream: laporanServices.getDetail(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final item = snapshot.data;
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          child: Image.network(
                            item!['image'],
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                        ListText(
                          label: 'Judul Kerusakan',
                          content: item['kerusakan'],
                        ),
                        ListText(
                          label: 'Deskripsi Kerusakan',
                          content: item['deskripsi'],
                        ),
                        ListText(label: 'Nama Kos', content: item['nama_kos']),
                        ListText(
                          label: 'Nomor Kamar',
                          content: item['no_kamar'],
                        ),
                        ListText(
                          label: 'Status Kerusakan',
                          content: item['status'],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('Data Kosong'),
                    );
                  }
                })
          ],
        ));
  }
}
