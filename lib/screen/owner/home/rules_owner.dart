// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class RulesOwnerScreen extends StatefulWidget {
  const RulesOwnerScreen({super.key});

  @override
  State<RulesOwnerScreen> createState() => _RulesOwnerScreenState();
}

class _RulesOwnerScreenState extends State<RulesOwnerScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Text('rules')],
    );
  }
}
