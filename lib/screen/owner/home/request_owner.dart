// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/rule_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RequestOwnerScreen extends StatefulWidget {
  const RequestOwnerScreen({super.key});

  @override
  State<RequestOwnerScreen> createState() => _RequestOwnerScreenState();
}

class _RequestOwnerScreenState extends State<RequestOwnerScreen> {
  final RulesServices rulesServices = RulesServices();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('permintaan kos'),
    );
  }
}
