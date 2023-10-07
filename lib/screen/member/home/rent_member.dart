// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class RentMemberScreen extends StatelessWidget {
  const RentMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://a0.muscache.com/im/pictures/miso/Hosting-742424658135898180/original/ef5464ea-5eb8-426a-a097-a4ed7a395610.jpeg?im_w=1200",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20),
        ListTile(
          dense: true,
          title: Text(
            'Kost',
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            'Pandawara Kost',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          dense: true,
          title: Text(
            'Pemilik',
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            'Jhon Wong',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          dense: true,
          title: Text(
            'Tanggal Masuk',
            style: TextStyle(fontSize: 14),
          ),
          subtitle: Text(
            '01-09-2023',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 30),
        ButtonAction(
          label: 'Pembayaran',
          onTap: () {},
          color: Colors.teal,
        ),
        SizedBox(height: 10),
        ButtonAction(
          label: 'Laporakan Kerusakan',
          onTap: () {},
          color: AppColor.primary,
        ),
        SizedBox(height: 10),
        ButtonAction(
          label: 'Keluar Kos',
          onTap: () {},
          color: Colors.red,
        ),
        SizedBox(height: 10),
      ],
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
