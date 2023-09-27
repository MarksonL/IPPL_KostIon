import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kostion/presentation/tenant/loginPageTenant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPageTenant();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class TenantRegistrationPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController cUser = TextEditingController();
  final TextEditingController cPass = TextEditingController();

  Future<void> signUp() async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: cUser.text, password: cPass.text);
      final User? user = userCredential.user;
      if (user != null) {
        print('berhasil mendaftar sebagai: ${user.email}');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user already exist") {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                controller: cUser,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String email = cUser.text;
                  await signUp(email);
                  // Tambahkan logika pendaftaran di sini
                },
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
