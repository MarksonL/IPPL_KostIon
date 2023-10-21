import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/owner/kos/kos_detail.dart';
import 'package:kostlon/services/kos_services.dart';

class PeraturanBuilder extends StatelessWidget {
  const PeraturanBuilder({
    super.key,
    required this.kosServices,
    required this.widget,
  });

  final KosServices kosServices;
  final OwnerKosDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: kosServices.peraturan(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data?.docs;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items!.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot item = items[index];

              return ListTile(
                title: Text('${item['name']}'),
                trailing: IconButton(
                    onPressed: () {
                      kosServices.deletePeraturan(widget.id, item.id);
                    },
                    icon: Icon(Icons.delete)),
              );
            },
          );
        }

        return Container(
          child: Center(
            child: Text('Data kosong'),
          ),
        );
      },
    );
  }
}
