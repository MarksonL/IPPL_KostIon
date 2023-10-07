// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class PaymentOwnerScreen extends StatefulWidget {
  const PaymentOwnerScreen({super.key});

  @override
  State<PaymentOwnerScreen> createState() => _PaymentOwnerScreenState();
}

class _PaymentOwnerScreenState extends State<PaymentOwnerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Text('pembayaran')],
    );
  }
}
