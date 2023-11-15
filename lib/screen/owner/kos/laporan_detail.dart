import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/components/list_text.dart';
import 'package:kostlon/services/laporan_services.dart';

class LaporanDetail extends StatefulWidget {
  const LaporanDetail({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LaporanDetail> createState() => _LaporanDetail();
}

class _LaporanDetail extends State<LaporanDetail> {
  LaporanServices laporanServices = LaporanServices();
  late DocumentSnapshot<Map<String, dynamic>> data;
  String status = 'dilaporkan';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Laporan'),
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
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  // Toggling status kerusakan antara "dalam pengerjaan" dan "selesai"
                                  String newStatus =
                                      status == 'dalam pengerjaan'
                                          ? 'selesai'
                                          : 'dalam pengerjaan';

                                  try {
                                    // Update status di Firestore
                                    await laporanServices.updateStatus(
                                        widget.id, newStatus);

                                    // Dapatkan ulang data dari Firestore
                                    final updatedData = await laporanServices
                                        .getDetail(widget.id);
                                    if (updatedData != null) {
                                      setState(() {
                                        status = newStatus;
                                      });
                                    }
                                  } catch (e) {
                                    debugPrint('Terjadi kesalahan: $e');
                                    // Tampilkan pesan kesalahan kepada pengguna
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Terjadi kesalahan. Coba lagi nanti.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(status == 'dalam pengerjaan'
                                  ? 'Ubah ke Selesai'
                                  : 'Ubah ke Dalam Pengerjaan'),
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
