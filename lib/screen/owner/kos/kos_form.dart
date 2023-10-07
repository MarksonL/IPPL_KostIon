import 'package:flutter/material.dart';

class OwnerKostFormPage extends StatefulWidget {
  const OwnerKostFormPage({super.key});

  @override
  State<OwnerKostFormPage> createState() => _OwnerKostFormPageState();
}

class _OwnerKostFormPageState extends State<OwnerKostFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form tambah kos"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(children: []),
      ),
    );
  }
}
