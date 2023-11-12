import 'package:flutter/material.dart';
import 'package:kostlon/services/laporan_services.dart';
import 'package:kostlon/services/payment_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class PaymentMemberScreen extends StatefulWidget {
  const PaymentMemberScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMemberScreen> createState() => _PaymentMemberScreenState();
}

class _PaymentMemberScreenState extends State<PaymentMemberScreen> {
  PaymentServices paymentServices = PaymentServices();
  LaporanServices laporanServices = LaporanServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: SafeArea(
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColor.primary,
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Pembayaran"),
                Tab(text: "Laporan"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab Pembayaran
                  StreamBuilder(
                    stream: paymentServices.list(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var items = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var item = items[index];

                          return ListTile(
                            title: Text("${item['nama_kos']}"),
                            subtitle: Text(
                              "Jumlah: ${item['pembayaran']}",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Tab Laporan
                  StreamBuilder(
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
                            title: Text(
                                "${item['kerusakan']} - Kamar (${item['no_kamar']})"),
                            subtitle: Text("${item['deskripsi']}"),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // Widget build(BuildContext context) {
  //   List<Map> data = [
  //     {
  //       "periode": "September 2023",
  //       "tipe": "Pembayaran cash",
  //       "tgl": "01-09-2023"
  //     },
  //     {
  //       "periode": "Agustus 2023",
  //       "tipe": "Pembayaran cash",
  //       "tgl": "01-08-2023"
  //     },
  //     {"periode": "Juli 2023", "tipe": "Pembayaran cash", "tgl": "01-07-2023"},
  //     {"periode": "Juni 2023", "tipe": "Pembayaran tf", "tgl": "01-06-2023"},
  //   ];
  //   return ListView.builder(
  //     itemCount: data.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(data[index]['periode']),
  //         subtitle: Text(data[index]['tipe']),
  //         trailing: Text(data[index]['tgl']),
  //       );
  //     },
  //   );
  // }
