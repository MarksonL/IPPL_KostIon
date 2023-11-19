import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/components/list_text.dart';
import 'package:kostlon/services/payment_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class PaymentDetailOwner extends StatefulWidget {
  const PaymentDetailOwner({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<PaymentDetailOwner> createState() => _PaymentDetailOwner();
}

class _PaymentDetailOwner extends State<PaymentDetailOwner> {
  PaymentServices paymentServices = PaymentServices();
  late DocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Pembayaran'),
          backgroundColor: AppColor.primary,
          elevation: 0,
        ),
        body: ListView(
          children: [
            StreamBuilder(
                stream: paymentServices.getDetail(widget.id),
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
                          label: 'Nama Kos',
                          content: item['nama_kos'],
                        ),
                        ListText(
                          label: 'Nama Member',
                          content: item['member_name'],
                        ),
                        ListText(
                          label: 'Jumlah Dibayarkan',
                          content: item['pembayaran'],
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('Data Kosong'),
                    );
                  }
                })
          ],
        ));
  }
}
