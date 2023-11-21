// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/components/card_toko.dart';
import 'package:kostlon/screen/owner/kos/kos_detail.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class HomeOwnerScreen extends StatefulWidget {
  const HomeOwnerScreen({super.key});

  @override
  State<HomeOwnerScreen> createState() => _HomeOwnerScreenState();
}

class _HomeOwnerScreenState extends State<HomeOwnerScreen> {
  final KosServices kosServices = KosServices();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: kosServices.getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var items = snapshot.data?.docs;
            var daftar =
                items?.where((kos) => kos['owner_id'] == user?.uid).toList();

            if (daftar!.isNotEmpty) {
              return ListView(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextInput(label: "Cari", val: _search),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3.5,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemCount: daftar.length,
                        itemBuilder: (context, index) {
                          return CardToko(
                            title: daftar[index]['name'],
                            image: daftar[index]['image'],
                            alamat: daftar[index]['alamat'],
                            harga: daftar[index]['price'].toString(),
                            onDetail: () {
                              final String id = daftar[index].id;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OwnerKosDetailPage(
                                    id: id,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        shrinkWrap: true,
                      )),
                ],
              );
            }
            return Center(
              child: Text('Data kos kosong, tambah data'),
            );
          }),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.label,
    required TextEditingController val,
  }) : _val = val;

  final String label;
  final TextEditingController _val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        controller: _val,
        decoration: InputDecoration(
          // labelText: "${label}",
          hintText: label,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: AppColor.secondary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColor.light),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
