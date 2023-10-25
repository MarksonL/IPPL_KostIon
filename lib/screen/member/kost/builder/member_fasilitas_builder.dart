import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/kos_services.dart';

class MemberFasilitasBuilder extends StatelessWidget {
  const MemberFasilitasBuilder({
    super.key,
    required this.kosServices,
    required this.id,
  });

  final KosServices kosServices;
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: kosServices.fasilitas(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot item = items[index];
              return ListTile(
                title: Text(item['name']),
              );
            },
          );
        } else {
          return Center(
            child: Text('Fasilitas kosong'),
          );
        }
      },
    );
  }
}
