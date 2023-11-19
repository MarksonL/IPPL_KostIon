import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/member/kost/laporan_detail_member.dart';
import 'package:kostlon/screen/member/kost/paymentdetail_member.dart';
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
  User? user = FirebaseAuth.instance.currentUser;

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
                      var bayar = items
                          .where((payments) =>
                              payments['email_member'] == user?.email)
                          .toList();

                      return ListView.builder(
                        itemCount: bayar.length,
                        itemBuilder: (context, index) {
                          var item = bayar[index];

                          return ListTile(
                            title: Text("${item['nama_kos']}"),
                            subtitle: Text(
                              "Jumlah: ${item['pembayaran']}",
                              style: TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              final String id = bayar[index].id;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentDetailMember(
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
                      var laporan = items
                          .where((reports) => reports['member_id'] == user?.uid)
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: laporan.length,
                        itemBuilder: (context, index) {
                          var item = laporan[index];

                          return ListTile(
                            title: Text(
                                "${item['nama_kos']} - Kamar (${item['no_kamar']})"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Laporan: ${item['kerusakan']}"),
                                Text("Status Laporan: ${item['status']}"),
                              ],
                            ),
                            onTap: () {
                              final String id = items[index].id;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LaporanDetailMember(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
