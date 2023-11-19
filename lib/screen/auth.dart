import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kostlon/screen/member/home_member.dart';
import 'package:kostlon/screen/owner/home_owner.dart';
import 'package:kostlon/screen/register.dart';
import 'package:kostlon/screen/resetpassword.dart';
import 'package:kostlon/utils/color_theme.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void submit(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      if (credential.user!.emailVerified) {
        checkRole(context);
        context.loaderOverlay.hide();
      } else {
        context.loaderOverlay.hide();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Akun anda belum terverifikasi"),
                content: Text(
                    "Silakan lakukan verifikasi akun melalui email yang telah dikirimkan"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Ok"))
                ],
              );
            });
      }
    } on FirebaseAuthException catch (e) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Akun tidak ditemukan"),
            content: Text(
                "Silakan periksa kembali alamat email dan kata sandi anda karena akun yang anda masukkan tidak valid"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
            ],
          );
        },
      );
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
      //redirect halaman owner
      else if (res['role'] == 'owner') {
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
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.black12,
        overlayWidget: const Center(
          child: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Kost.ion',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextInput(
                val: _email,
                label: 'Email',
                isPassword: false,
              ),
              const SizedBox(height: 10),
              TextInput(
                val: _password,
                isPassword: true,
                label: 'Password',
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0,
                    backgroundColor: AppColor.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0,
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.label,
    required TextEditingController val,
    required this.isPassword,
  })  : _val = val,
        super(key: key);

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
