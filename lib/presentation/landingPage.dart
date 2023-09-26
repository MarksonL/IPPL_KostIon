import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostion/presentation/admin/adminHomePage.dart';
import 'package:kostion/presentation/mainPage.dart';
import 'package:kostion/presentation/owner/ownerHomePage.dart';
import 'package:kostion/presentation/tenant/tenantHomePage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final uid = FirebaseAuth.instance.currentUser?.uid;

              return FutureBuilder<Object>(
                future: FirebaseFirestore.instance
                    .collection('data_user')
                    .doc(uid)
                    .get(),
                builder: (context, snapshot) {
                  var userType =
                      (snapshot.data as DocumentSnapshot)['usertype'];
                  if (userType == 'admin') {
                    return AdminHomePage();
                  } else if (userType == 'tenant') {
                    return TenantHomePage();
                  } else {
                    return OwnerHomePage();
                  }
                },
              );
            } else {
              return MainPage();
            }
          }),
    );
  }
}
