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
                  shrinkWrap: true,
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
                      child: Row(
                        children: [Text('Tambah data')],
                      ),
                    ),
                    ExpansionTile(
                      title: Text('Fasilitas'),
                      children: [
                        FasilitasBuilder(
                            kosServices: kosServices, widget: widget)
                      ],
                    ),
                    ExpansionTile(
                      title: Text('Peraturan'),
                      children: [
                        FasilitasBuilder(
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
}

class FasilitasBuilder extends StatelessWidget {
  const FasilitasBuilder({
    super.key,
    required this.kosServices,
    required this.widget,
  });

  final KosServices kosServices;
  final OwnerKosDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: kosServices.fasilitas(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data?.docs;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items!.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot item = items[index];

              return ListTile(
                title: Text('${item['name']}'),
              );
            },
          );
        }

        return Container(
          child: Center(
            child: Text('Data kosong'),
          ),
        );
      },
    );
  }
}

class ListText extends StatelessWidget {
  const ListText({
    super.key,
    required this.label,
    required this.content,
  });

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
