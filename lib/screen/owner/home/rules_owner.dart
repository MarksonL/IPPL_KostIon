// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/rule_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RulesOwnerScreen extends StatefulWidget {
  const RulesOwnerScreen({super.key});

  @override
  State<RulesOwnerScreen> createState() => _RulesOwnerScreenState();
}

class _RulesOwnerScreenState extends State<RulesOwnerScreen> {
  final RulesServices rulesServices = RulesServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: rulesServices.getData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var items = snapshot.data?.docs;

        if (items == null) {
          return Center(
            child: Text('Data kos kosong'),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            DocumentSnapshot item = items[index];
            String docId = items[index].id;
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: BorderDirectional(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['rule']),
                  IconButton(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      try {
                        await rulesServices.deleteData(docId);
                        context.loaderOverlay.hide();
                      } catch (e) {
                        context.loaderOverlay.hide();
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
