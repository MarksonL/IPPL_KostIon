// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/auth.dart';
import 'package:kostlon/screen/member/home/payment_member.dart';
import 'package:kostlon/screen/member/home/profile_member.dart';
import 'package:kostlon/screen/member/home/search_member.dart';
import 'package:kostlon/screen/member/home/rent_member.dart';
import 'package:kostlon/utils/color_theme.dart';

class HomeMemberPage extends StatefulWidget {
  const HomeMemberPage({super.key});

  @override
  State<HomeMemberPage> createState() => _HomeMemberPageState();
}

class _HomeMemberPageState extends State<HomeMemberPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    SearchScreenMember(),
    RentMemberScreen(),
    PaymentMemberScreen(),
    ProfileMemberScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kostlon'),
        centerTitle: true,
        backgroundColor: AppColor.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Konfirmasi Keluar"),
                      content:
                          Text("Apakah anda yakin ingin keluar dari akun?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Batal"),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text("Ya"),
                        )
                      ],
                    );
                  });
            },
            icon: Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: SafeArea(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Kos Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: AppColor.light,
        onTap: _onItemTapped,
      ),
    );
  }
}
