// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/kos_services.dart';

class OwnerKosDetailPage extends StatefulWidget {
  const OwnerKosDetailPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<OwnerKosDetailPage> createState() => _OwnerKosDetailPageState();
}

class _OwnerKosDetailPageState extends State<OwnerKosDetailPage> {
  KosServices kosServices = KosServices();
  late DocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kos'),
      ),
      body: StreamBuilder(
        stream: kosServices.getDetail(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final item = snapshot.data;
            return ListView(
              children: [
                Container(
                  child: Image.network(
                    item!['image'],
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(item['name']),
              ],
            );
          } else {
            return Center(
              child: Text('Data Kosong'),
            );
          }
        },
      ),
    );
  }
}
