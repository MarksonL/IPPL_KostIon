import 'package:flutter/material.dart';

class PaymentMemberScreen extends StatelessWidget {
  PaymentMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> data = [
      {
        "periode": "September 2023",
        "tipe": "Pembayaran cash",
        "tgl": "01-09-2023"
      },
      {
        "periode": "Agustus 2023",
        "tipe": "Pembayaran cash",
        "tgl": "01-08-2023"
      },
      {"periode": "Juli 2023", "tipe": "Pembayaran cash", "tgl": "01-07-2023"},
      {"periode": "Juni 2023", "tipe": "Pembayaran tf", "tgl": "01-06-2023"},
    ];
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]['periode']),
          subtitle: Text(data[index]['tipe']),
          trailing: Text(data[index]['tgl']),
        );
      },
    );
  }
}
