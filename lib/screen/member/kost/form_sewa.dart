import 'package:flutter/material.dart';
import 'package:kostlon/utils/color_theme.dart';

class PengajuanSewaForm extends StatefulWidget {
  @override
  _PengajuanSewaFormState createState() => _PengajuanSewaFormState();
}

class _PengajuanSewaFormState extends State<PengajuanSewaForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController profesiController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        startDateController.text = picked.toString();
      });
    }
  }

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
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: AppColor.primary),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    controller: profesiController,
                    decoration: InputDecoration(labelText: "Profesi anda"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mohon masukkan profesi anda";
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
                  TextFormField(
                    controller: startDateController,
                    decoration: InputDecoration(labelText: "Tanggal Awal Sewa"),
                    onTap: () {
                      _selectDate(
                          context); // Memanggil fungsi _selectDate saat bidang tanggal diklik
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mohon pilih tanggal awal sewa";
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
