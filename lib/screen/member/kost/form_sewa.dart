import 'package:flutter/material.dart';
import 'package:kostlon/services/member_services.dart';
import 'package:kostlon/utils/color_theme.dart';

class RentalApplicationForm extends StatefulWidget {
  @override
  _RentalApplicationFormState createState() => _RentalApplicationFormState();
}

class _RentalApplicationFormState extends State<RentalApplicationForm> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  late String _jenisKelamin;
  final _pekerjaanController = TextEditingController();
  late DateTime _tanggalMulaiNgekos;
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
    try {
      var resp = await memberServices.addData({
        'name': 'member 1',
        'member_id': '1',
        'kos': 'kos 1',
        'kos_id': '1'
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Pengajuan Sewa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Penyewa'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama penyewa wajib diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Nomor HP'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nomor HP wajib diisi';
                  }
                  return null;
                },
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
              TextFormField(
                controller: _pekerjaanController,
                decoration: InputDecoration(labelText: 'Pekerjaan'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Pekerjaan wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text('Tanggal Mulai Ngekos:'),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _pilihTanggal(context),
                    child: Text(_tanggalMulaiNgekos != null
                        ? "${_tanggalMulaiNgekos.toLocal()}".split(' ')[0]
                        : 'Pilih Tanggal'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => submit(context),
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
