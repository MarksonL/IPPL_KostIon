import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kostlon/services/owner_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kostlon/utils/color_theme.dart';

class RequestOwnerScreen extends StatefulWidget {
  const RequestOwnerScreen({super.key});

  @override
  State<RequestOwnerScreen> createState() => _RequestOwnerScreenState();
}

class _RequestOwnerScreenState extends State<RequestOwnerScreen> {
  final OwnerServices ownerServices = OwnerServices();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: const Text('Permintaan Kost'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Masuk'),
              Tab(text: 'Keluar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab view untuk permintaan masuk
            buildRequestList(user!.uid, 'masuk'),

            // Tab view untuk permintaan keluar
            buildRequestList(user!.uid, 'keluar'),
          ],
        ),
      ),
    );
  }

  Widget buildRequestList(String ownerId, String type) {
    Stream<QuerySnapshot> requestStream = type == 'masuk'
        ? ownerServices.list(ownerId)
        : ownerServices.member(ownerId);

    return SingleChildScrollView(
      child: StreamBuilder(
        stream: requestStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var items = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];

              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item['user_email']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "${item['name']}",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Durasi ${item['durasi_sewa']} Bulan",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Tgl ${item!['tanggal_mulai']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Periksa jenis permintaan
                        if (type == 'masuk') // Jika permintaan masuk
                          IconButton(
                            onPressed: () {
                              ownerServices.approveMasuk(item.id);
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.green[400],
                            ),
                          ),
                        if (type == 'masuk') // Jika permintaan masuk
                          IconButton(
                            onPressed: () {
                              ownerServices.rejectMasuk(item.id);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.grey[400],
                            ),
                          ),
                        if (type == 'keluar') // Jika permintaan keluar
                          IconButton(
                            onPressed: () {
                              ownerServices.approveKeluar(item.id);
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.green[400],
                            ),
                          ),
                        if (type == "keluar")
                          IconButton(
                            onPressed: () {
                              ownerServices.approveMasuk(item.id);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.grey[400],
                            ),
                          )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
