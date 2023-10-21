// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/member/kost/form_sewa.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class MemberKostDetail extends StatefulWidget {
  const MemberKostDetail({
    super.key,
    required this.id,
  });

  // variable parameter
  final String id;
  @override
  State<MemberKostDetail> createState() => _MemberKostDetailState();
}

class _MemberKostDetailState extends State<MemberKostDetail> {
  final KosServices kosServices = KosServices();
  final List fasilitas = [];

  void getFasilitas() {
    var res = kosServices.fasilitas(widget.id);
    print(res);
  }

  @override
  void initState() {
    getFasilitas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kost Detail"),
          centerTitle: true,
          backgroundColor: AppColor.primary,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: kosServices.getDetail(widget.id),
          builder: (context, snapshot) {
            DocumentSnapshot? item = snapshot.data;
            return BodyDetail(
              name: item!['name'],
              alamat: item!['alamat'],
              owner: item!['owner'],
              price: item!['price'].toString(),
              image: item!['image'],
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PengajuanSewaForm()));
          },
          label: Text("Ajukan Sewa"),
          backgroundColor: AppColor.primary,
        ),
      ),
    );
  }
}

class BodyDetail extends StatelessWidget {
  const BodyDetail(
      {super.key, this.name, this.alamat, this.owner, this.price, this.image});

  final String? name;
  final String? alamat;
  final String? owner;
  final String? price;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "${image}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${alamat}',
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          '${name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Text(
                        'PUTRA',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pemilik',
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          '${owner}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Harga Sewa',
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          '${price}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            indicatorColor: AppColor.primary,
            padding: EdgeInsets.all(10),
            labelColor: Colors.black,
            tabs: [
              Tab(text: "Fasilitas"),
              Tab(text: "Peraturan"),
            ],
          ),
          Container(
            width: double.infinity,
            color: AppColor.bgLight,
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: MediaQuery.of(context).size.height / 2,
            ),
            child: TabBarView(
              children: [
                ListView(
                  itemExtent: 40,
                  children: [
                    ListTile(
                      title: Text('TV'),
                      // subtitle: Text('Ukuran 24 inch'),
                    ),
                    ListTile(
                      title: Text('Kasur'),
                      // subtitle: Text('King size'),
                    )
                  ],
                ),
                ListView(
                  itemExtent: 60,
                  children: [
                    ListTile(
                      title: Text('Kunjungan Tamu'),
                      subtitle: Text('Batas akhir kunjungan jam 10 malam '),
                    ),
                    ListTile(
                      title: Text('Parkir'),
                      subtitle: Text('Parkir sesuai dengan nomer kamar'),
                    ),
                    ListTile(
                      title: Text('Tamu'),
                      subtitle: Text('Tamu menginap maksimal 2X24 jam'),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
