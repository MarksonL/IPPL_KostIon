// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/components/card_toko.dart';
import 'package:kostlon/data/dummy_kost.dart';
import 'package:kostlon/screen/member/kost/kost_detail.dart';
import 'package:kostlon/services/kos_services.dart';
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
  KosServices _kosServices = KosServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _kosServices.getData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3.5,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot item = items[index];

                  String id = item.id;
                  // return Container(child: Text("${item['image']}"));
                  return CardToko(
                    title: item['name'],
                    image: item['image'],
                    alamat: item['alamat'],
                    harga: item['price'].toString(),
                    onDetail: (context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MemberKostDetail(id: id)),
                      );
                    },
                  );
                },
                shrinkWrap: true,
              ),
            );
          }

          return Container();
        });
  }
}

// ListView(
//       children: [
//         SizedBox(height: 20),
//         TextInput(label: 'Cari kost', val: _search),
//         SizedBox(height: 5),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Rekomendasi'),
//               InkWell(
//                 onTap: () {},
//                 child: Text('Lihat Semua'),
//               )
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: GridView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200,
//                 childAspectRatio: 3 / 3.5,
//                 crossAxisSpacing: 0,
//                 mainAxisSpacing: 0),
//             itemCount: listKost.length,
//             itemBuilder: (context, index) {
//               return CardToko(
//                 title: listKost[index]['title'],
//                 image: listKost[index]['image'],
//                 alamat: listKost[index]['alamat'],
//                 harga: listKost[index]['harga'],
//                 onDetail: (context) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MemberKostDetail()),
//                   );
//                 },
//               );
//             },
//             shrinkWrap: true,
//           ),
//         ),
//       ],
//     );

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
