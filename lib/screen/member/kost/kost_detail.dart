// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class MemberKostDetail extends StatefulWidget {
  const MemberKostDetail({super.key});

  @override
  State<MemberKostDetail> createState() => _MemberKostDetailState();
}

class _MemberKostDetailState extends State<MemberKostDetail> {
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
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://a0.muscache.com/im/pictures/miso/Hosting-742424658135898180/original/ef5464ea-5eb8-426a-a097-a4ed7a395610.jpeg?im_w=1200",
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
                              'Balikpapan Utara',
                              style: TextStyle(color: AppColor.textPrimary),
                            ),
                            Text(
                              'Kos pandawa',
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
                              'Jhon Wong',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pemilik',
                              style: TextStyle(color: AppColor.textPrimary),
                            ),
                            Text(
                              'Jhon Wong',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
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
                              'Rp 800.000',
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
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text("Ajukan Sewa"),
          backgroundColor: AppColor.primary,
        ),
      ),
    );
  }
}
