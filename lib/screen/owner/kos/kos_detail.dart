// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/components/peraturan_builder.dart';
import 'package:kostlon/services/kos_services.dart';

import 'components/fasilitas_builder.dart';
import 'components/list_text.dart';

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
  TextEditingController _inputFasilitas = TextEditingController();
  TextEditingController _inputPeraturan = TextEditingController();
  late DocumentSnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kos'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: kosServices.getDetail(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final item = snapshot.data;
                return ListView(
                  shrinkWrap: true, //
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      child: Image.network(
                        item!['image'],
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    ListText(
                      label: 'Nama kos',
                      content: item['name'],
                    ),
                    ListText(
                      label: 'alamat',
                      content: item['alamat'],
                    ),
                    ListText(
                      label: 'Harga',
                      content: item['price'].toString(),
                    ),
                    ListText(
                      label: 'Jumlah Kamar',
                      content: item['jumlah'].toString(),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => _addfasilitas(context),
                            child: Text('Tambah Fasilitas'),
                          ),
                          TextButton(
                            onPressed: () => _addperaturan(context),
                            child: Text('Tambah pengaturan'),
                          )
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: Text('Fasilitas'),
                      children: [
                        FasilitasBuilder(
                            kosServices: kosServices, id: widget.id)
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Peraturan'),
                      children: [
                        PeraturanBuilder(
                            kosServices: kosServices, widget: widget)
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Data Kosong'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addfasilitas(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah fasilitas'),
          content: TextField(
            controller: _inputFasilitas,
            decoration: InputDecoration(hintText: "Nama fasilitas"),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal')),
            TextButton(
                onPressed: () {
                  kosServices.addFasilitas({
                    'name': _inputFasilitas.text,
                    "created": Timestamp.now()
                  }, widget.id);
                  Navigator.pop(context);
                  _inputFasilitas.clear();
                },
                child: Text('Simpan')),
          ],
        );
      },
    );
  }

  Future<void> _addperaturan(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah peraturan'),
          content: TextField(
            controller: _inputPeraturan,
            decoration: InputDecoration(hintText: "Nama peraturan"),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal')),
            TextButton(
                onPressed: () {
                  kosServices.addPeraturan({
                    'name': _inputPeraturan.text,
                    "created": Timestamp.now()
                  }, widget.id);
                  Navigator.pop(context);
                  _inputFasilitas.clear();
                },
                child: Text('Simpan')),
          ],
        );
      },
    );
  }
}
