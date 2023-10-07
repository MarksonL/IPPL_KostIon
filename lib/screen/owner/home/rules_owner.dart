// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class RulesOwnerScreen extends StatefulWidget {
  const RulesOwnerScreen({super.key});

  @override
  State<RulesOwnerScreen> createState() => _RulesOwnerScreenState();
}

class _RulesOwnerScreenState extends State<RulesOwnerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: BorderDirectional(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.black12,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListData(
                data: "Peraturan nomer ${index++}",
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
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
