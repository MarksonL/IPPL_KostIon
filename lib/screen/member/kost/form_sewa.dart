// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kostlon/services/member_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class RentalApplicationForm extends StatefulWidget {
  const RentalApplicationForm({
    super.key,
    required this.id,
  });

  final String id;
  @override
  _RentalApplicationFormState createState() => _RentalApplicationFormState();
}

class _RentalApplicationFormState extends State<RentalApplicationForm> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _jenisKelamin = 'Laki-laki';
  final _pekerjaanController = TextEditingController();
  DateTime? _tanggalMulaiNgekos;
  int _durasiSewa = 1;
  final MemberServices memberServices = MemberServices();

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != _tanggalMulaiNgekos) {
      setState(() {
        _tanggalMulaiNgekos = picked;
      });
    }
  }

  void submit(BuildContext context) async {
    User? member = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> body = {
      'name': _nameController.text,
      'member_id': member?.uid,
      'kos_id': '1',
      'nomor_hp': _phoneNumberController.text,
      'jenis_kelamin': _jenisKelamin,
      'pekerjaan': _pekerjaanController.text,
      'tanggal_sewa': _tanggalMulaiNgekos.toString(),
      'durasi': _durasiSewa.toString()
    };

    try {
      await memberServices.addData(body);
      // action setelah data berhasil di tambahkan
      reset();
      // navigasi ke halaman utama
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void reset() {
    setState(() {
      _nameController.clear();
      _phoneNumberController.clear();
      _jenisKelamin = 'Laki-laki';
      _pekerjaanController.clear();
      _durasiSewa = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Pengajuan Sewa'),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Penyewa',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primary)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama penyewa wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Nomor HP',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nomor HP wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _pekerjaanController,
                  decoration: InputDecoration(
                    labelText: 'Pekerjaan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pekerjaan wajib diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Jenis Kelamin',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                DropdownButtonFormField(
                  value: _jenisKelamin,
                  hint: Text('Jenis Kelamin'),
                  items: ['Laki-laki', 'Perempuan']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _jenisKelamin = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tanggal Mulai Ngekos:',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _pilihTanggal(context),
                          child: Text(_tanggalMulaiNgekos != null
                              ? "${_tanggalMulaiNgekos!.toLocal()}"
                                  .split(' ')[0]
                              : 'Pilih Tanggal'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Durasi Sewa/bulan',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_durasiSewa > 1) {
                              _durasiSewa--;
                            }
                          });
                        },
                      ),
                      Text(
                        '$_durasiSewa',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _durasiSewa++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                    ),
                    onPressed: () => submit(context),
                    child: Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
