// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/member/kost/rent_detail.dart';
import 'package:kostlon/services/member_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class RentMemberScreen extends StatefulWidget {
  const RentMemberScreen({super.key});

  @override
  State<RentMemberScreen> createState() => _RentMemberScreenState();
}

class _RentMemberScreenState extends State<RentMemberScreen> {
  MemberServices memberServices = MemberServices();
  User? user = FirebaseAuth.instance.currentUser;

  String _endDate(String start, String period) {
    DateTime from = DateTime.parse(start);
    int sum = (int.parse(period) * 30);
    return from.add(Duration(days: sum.toInt())).toString().split(" ")[0];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: memberServices.listKostRent(user!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var items = snapshot.data!.docs;
        print(items);
        if (items.length > 0) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return InkWell(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item['name']}",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${item['alamat']} - S/d ${_endDate(item['tanggal_mulai'], item['durasi_sewa'])}",
                            style: TextStyle(
                                fontSize: 16, color: AppColor.textPrimary),
                          ),
                        ],
                      ),
                      Text(
                        "${item['approved'] ? 'AKTIF' : 'PENDING'}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (item['approved']) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RentDetailPage(id: item.id),
                      ),
                    );
                  }
                },
              );
            },
          );
        } else {
          return Center(
            child: Text('Kos Kosong'),
          );
        }
      },
    );
  }
}

class ButtonAction extends StatelessWidget {
  const ButtonAction({
    super.key,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
