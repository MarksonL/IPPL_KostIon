// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/owner_services.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  OwnerServices ownerServices = OwnerServices();
  User? user = FirebaseAuth.instance.currentUser;

  String _endDate(String start, String period) {
    DateTime from = DateTime.parse(start);
    int sum = (int.parse(period) * 30);
    return from.add(Duration(days: sum.toInt())).toString().split(" ")[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member'),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: ownerServices.member(user!.uid),
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
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item['user_email']}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                            "${item['tanggal_mulai']} s/d ${_endDate(item['tanggal_mulai'], item['durasi_sewa'])}"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => ownerServices.rejectMasuk(item.id),
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
