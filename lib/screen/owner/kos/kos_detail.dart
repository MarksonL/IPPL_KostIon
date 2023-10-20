import 'package:flutter/material.dart';
import 'package:kostlon/services/kos_services.dart';

class OwnerKosDetailPage extends StatefulWidget {
  const OwnerKosDetailPage({
    super.key,
    this.id,
  });

  final String? id;

  @override
  State<OwnerKosDetailPage> createState() => _OwnerKosDetailPageState();
}

class _OwnerKosDetailPageState extends State<OwnerKosDetailPage> {
  KosServices kosServices = KosServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kos'),
      ),
    );
  }
}
