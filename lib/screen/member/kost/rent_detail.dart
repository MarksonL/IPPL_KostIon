// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/member/kost/form_kerusakan.dart';
import 'package:kostlon/screen/member/kost/form_pembayaran.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:kostlon/services/member_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class RentDetailPage extends StatefulWidget {
  const RentDetailPage({
    super.key,
    required this.id,
  });

  final String id;
  @override
  State<RentDetailPage> createState() => _RentDetailPageState();
}

class _RentDetailPageState extends State<RentDetailPage> {
  MemberServices memberServices = MemberServices();

  String _endDate(String start, String period) {
    DateTime from = DateTime.parse(start);
    int sum = (int.parse(period) * 30);
    return from.add(Duration(days: sum.toInt())).toString().split(" ")[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Sewa'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.primary,
      ),
      body: StreamBuilder(
        stream: memberServices.detailRent(widget.id),
        builder: (context, snapshot) {
          print(widget.id);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var item = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama kos: "),
                  Text(
                    "${item!['name']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Alamat: "),
                  Text(
                    "${item['alamat']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Tanggal Sewa Dimulai: "),
                  Text(
                    "${item['tanggal_mulai']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Tanggal Sewa Berakhir: "),
                  Text(
                    "${_endDate(item['tanggal_mulai'], item['durasi_sewa'])}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Harga Sewa: "),
                  Text(
                    "${item['price']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  ActionPembayaran(
                    kos: {
                      "kos_id": item['kos_id'],
                      "nama_kos": item['name'],
                    },
                  ),
                  ActionLaporan(),
                  // ActionKeluar(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ActionKeluar extends StatelessWidget {
  const ActionKeluar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Konfirmasi Keluar Kos'),
                content: Text('Apakah Anda yakin ingin keluar kos?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text("Permintaan Dikirim"),
                              content: Text(
                                  "Permintaan keluar kost anda telah dikirim, mohon untuk menunggu dari konfirmasi dari pemilik kost"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Oke"))
                              ],
                            );
                          }));
                    },
                    child: Text('Keluar Kos'),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'Keluar Kos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ActionLaporan extends StatelessWidget {
  const ActionLaporan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaporanKerusakanForm(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: AppColor.primary,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'Laporkan Kerusakan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ActionPembayaran extends StatelessWidget {
  const ActionPembayaran({super.key, required this.kos});
  final Map<String, dynamic> kos;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PembayaranForm(
                kos: kos,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
