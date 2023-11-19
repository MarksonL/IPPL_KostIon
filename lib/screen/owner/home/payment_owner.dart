// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/paymentdetail_owner.dart';
import 'package:kostlon/services/payment_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class PaymentOwnerScreen extends StatefulWidget {
  const PaymentOwnerScreen({super.key});

  @override
  State<PaymentOwnerScreen> createState() => _PaymentOwnerScreenState();
}

class _PaymentOwnerScreenState extends State<PaymentOwnerScreen> {
  PaymentServices paymentServices = PaymentServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
              onTap: () {
                final String id = items[index].id;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentDetailOwner(
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
