// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class PaymentOwnerScreen extends StatefulWidget {
  const PaymentOwnerScreen({super.key});

  @override
  State<PaymentOwnerScreen> createState() => _PaymentOwnerScreenState();
}

class _PaymentOwnerScreenState extends State<PaymentOwnerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 24,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: BorderDirectional(
              bottom: BorderSide(
                width: 0.5,
                color: AppColor.textPrimary,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListData(
                label: "Anggota",
                data: "Jhon Doe",
              ),
              ListData(
                label: "Kamar",
                data: "R19",
              ),
              ListData(
                label: "Cash",
                data: "300,000",
              ),
            ],
          ),
        );
      },
    );
  }
}

class ListData extends StatelessWidget {
  const ListData({
    super.key,
    required this.label,
    required this.data,
  });

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColor.textPrimary),
        ),
        Text(
          data,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
