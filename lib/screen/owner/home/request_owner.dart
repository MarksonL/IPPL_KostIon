// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/owner_services.dart';
import 'package:kostlon/services/rule_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: ownerServices.list(user!.uid),
        builder: (context, snapshot) {
          print(user!.uid);
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Durasi ${item['durasi_sewa']} Bulan .",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Tgl ${item!['tanggal_mulai']} .",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              ownerServices.approve(items[index].id);
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.green[400],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ownerServices.reject(items[index].id);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      )
                    ],
                  ));
              // return ListTile(
              //   title: Text("Nama: ${item['user_email']}"),
              //   subtitle: Text(
              //       "Durasi : ${item['durasi_sewa']} Bulan | Tanggal : ${item['tanggal_mulai']}"),
              // );
            },
          );
        },
      ),
    );
  }
}
