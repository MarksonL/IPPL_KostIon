// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kostlon/components/card_toko.dart';
import 'package:kostlon/data/dummy_kost.dart';
import 'package:kostlon/utils/color_theme.dart';

class SearchScreenMember extends StatefulWidget {
  const SearchScreenMember({
    super.key,
  });

  @override
  State<SearchScreenMember> createState() => _SearchScreenMemberState();
}

class _SearchScreenMemberState extends State<SearchScreenMember> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        TextInput(label: 'Cari kost', val: _search),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rekomendasi'),
              InkWell(
                onTap: () {},
                child: Text('Lihat Semua'),
              )
            ],
          ),
        ),
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
        obscureText: false,
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
