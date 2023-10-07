// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class ProfileOwnerScreen extends StatefulWidget {
  const ProfileOwnerScreen({super.key});

  @override
  State<ProfileOwnerScreen> createState() => _ProfileOwnerScreenState();
}

class _ProfileOwnerScreenState extends State<ProfileOwnerScreen> {
  // final user =
  final TextEditingController _nameInput = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _updateName(BuildContext context) {
    print("show update name");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update nama',
              style: TextStyle(fontSize: 18),
            ),
            content: TextField(
              controller: _nameInput,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () async {
                  try {
                    await user?.updateDisplayName(_nameInput.text);
                    _nameInput.clear();
                    setState(() {
                      Navigator.pop(context);
                      user = FirebaseAuth.instance.currentUser;
                    });
                  } catch (e) {}
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 30),
        CircleAvatar(
          backgroundColor: AppColor.secondary,
          child: Text(
            'AH',
            style: TextStyle(fontSize: 30),
          ),
          maxRadius: 50,
          minRadius: 50,
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(
            '${user?.displayName}',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () => _updateName(context),
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text(
            "${user?.email}",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }
}
