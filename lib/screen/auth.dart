// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/screen/member/home_member.dart';
import 'package:kostlon/screen/owner/home_owner.dart';
import 'package:kostlon/utils/color_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void submit(context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      checkRole(context);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Kredensial tidak ditemukan"),
            );
          });
    }
  }

  void checkRole(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    await db.collection("users").doc(user?.uid).get().then((value) {
      Map<String, dynamic> res = value.data() as dynamic;
      if (res['role'] == 'member') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeMemberPage()),
        );
      }
      // redirect halaman owner
      if (res['role'] == 'owner') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeOwnerPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      checkRole(context);
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'KostIon',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextInput(
              val: _email,
              label: 'Email',
              isPassword: false,
            ),
            SizedBox(height: 10),
            TextInput(
              val: _password,
              isPassword: true,
              label: 'Password',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => submit(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.label,
      required TextEditingController val,
      required this.isPassword})
      : _val = val;

  final String label;
  final TextEditingController _val;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: TextField(
        controller: _val,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: "${label}",
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: AppColor.secondary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
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
