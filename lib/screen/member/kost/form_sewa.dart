import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class PengajuanSewaForm extends StatefulWidget {
  @override
  _PengajuanSewaFormState createState() => _PengajuanSewaFormState();
}

class _PengajuanSewaFormState extends State<PengajuanSewaForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajukan Sewa"),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: Theme(
        data: ThemeData(
          primaryColor: AppColor.primary,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppColor.primary), // Set accent color
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center the form vertically
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Nama anda"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mohon masukkan nama anda";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mohon masukkan email anda";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(labelText: "Nomor Telepon"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mohon masukkan nomor telepon anda";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Ajukan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
