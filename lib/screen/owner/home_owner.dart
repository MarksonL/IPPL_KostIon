// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/auth.dart';
import 'package:kostlon/screen/owner/home/home_owner.dart';
import 'package:kostlon/screen/owner/home/payment_owner.dart';
import 'package:kostlon/screen/owner/home/profile_owner.dart';
import 'package:kostlon/screen/owner/home/rules_owner.dart';
import 'package:kostlon/screen/owner/kos/kos_form.dart';
import 'package:kostlon/screen/owner/rule/rule_form.dart';
import 'package:kostlon/utils/color_theme.dart';

class HomeOwnerPage extends StatefulWidget {
  const HomeOwnerPage({super.key});

  @override
  State<HomeOwnerPage> createState() => _HomeOwnerPageState();
}

class _HomeOwnerPageState extends State<HomeOwnerPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeOwnerScreen(),
    PaymentOwnerScreen(),
    RulesOwnerScreen(),
    ProfileOwnerScreen()
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
        title: Text("Kostlon"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: SafeArea(
        child: _widgetOptions[_selectedIndex],
      ),
      floatingActionButton: _selectedIndex != 3
          ? FloatingActionButton(
              onPressed: () {
                switch (_selectedIndex) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OwnerKostFormPage()),
                    );
                  case 1:
                    print('pembayaran');
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OwnerRuleFormPage()),
                    );
                  default:
                }
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Kos Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Peraturan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: AppColor.light,
        onTap: _onItemTapped,
      ),
    );
  }
}
