// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/components/card_toko.dart';
import 'package:kostlon/data/dummy_kost.dart';
import 'package:kostlon/utils/color_theme.dart';

class HomeOwnerScreen extends StatefulWidget {
  const HomeOwnerScreen({super.key});

  @override
  State<HomeOwnerScreen> createState() => _HomeOwnerScreenState();
}

class _HomeOwnerScreenState extends State<HomeOwnerScreen> {
  final db = FirebaseFirestore.instance;
  final TextEditingController _search = TextEditingController();

  void getData() async {
    try {
      // List<>
      final query = await db.collection('kos').get();
      var data = query.docs;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        TextInput(label: "Cari kos", val: _search),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 3.5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            itemCount: listKost.length,
            itemBuilder: (context, index) {
              return CardToko(
                title: listKost[index]['title'],
                image: listKost[index]['image'],
                alamat: listKost[index]['alamat'],
                harga: listKost[index]['harga'],
                onDetail: (context) {
                  print("object");
                },
              );
            },
            shrinkWrap: true,
          ),
        ),
      ],
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
