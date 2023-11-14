import 'package:flutter/material.dart';
import 'package:kostlon/services/laporan_services.dart';

class LaporanDetail extends StatefulWidget {
  const LaporanDetail({super.key});

  @override
  State<LaporanDetail> createState() => _LaporanDetail();
}

class _LaporanDetail extends State<LaporanDetail> {
  LaporanServices laporanServices = LaporanServices();

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: StreamBuilder (builder: ),
    // )
    return Scaffold(
      body: Center(child: Text("Laporan Detail")),
    );
  }
}
