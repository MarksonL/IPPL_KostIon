import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kostlon/services/kos_services.dart';
import 'package:kostlon/services/member_services.dart';
import 'package:kostlon/utils/color_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kostlon/screen/member/kost/builder/member_fasilitas_builder.dart';

class MemberKostDetail extends StatefulWidget {
  const MemberKostDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<MemberKostDetail> createState() => _MemberKostDetailState();
}

class _MemberKostDetailState extends State<MemberKostDetail> {
  TextEditingController _durasi = TextEditingController();
  TextEditingController _tanggalContainer = TextEditingController();
  DateTime? _tanggal;
  Map<String, dynamic> kos = {};
  final KosServices kosServices = KosServices();
  final MemberServices memberServices = MemberServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Kost Detail"),
          centerTitle: true,
          backgroundColor: AppColor.primary,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: kosServices.getDetail(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading data'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text('Data not found'),
              );
            } else {
              DocumentSnapshot item = snapshot.data!;
              kos = {
                "name": item['name'],
                "alamat": item['alamat'],
                "owner": item['owner'],
                "owner_id": item['owner_id'],
                "price": item['price'].toString(),
              };

              return BodyDetail(
                id: item.id,
                name: item['name'],
                alamat: item['alamat'],
                owner: item['owner'],
                price: item['price'].toString(),
                image: item['image'],
                kosServices: KosServices(),
              );
            }
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () => ajukanSewa(context),
              label: Text("Ajukan Sewa"),
              backgroundColor: AppColor.primary,
            ),
            SizedBox(height: 15),
            FloatingActionButton.extended(
              onPressed: () => _openWhatsApp(),
              label: Text("Buka Whatsapp"),
              backgroundColor: AppColor.primary,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _openWhatsApp() async {
    final phoneNumber = await KosServices().getNomorWA(widget.id.toString());
    String url = "https://wa.me/$phoneNumber";

    launchUrlString(url);
  }

  Future ajukanSewa(BuildContext context) {
    setState(() {
      _durasi.text = 1.toString();
      _tanggal = null;
      _tanggalContainer.clear();
    });
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Ajukan Sewa',
            style: TextStyle(fontSize: 18),
          ),
          content: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Durasi Sewa / Bulan',
                  style: TextStyle(fontSize: 12, color: AppColor.textPrimary),
                ),
                TextFormField(
                  controller: _durasi,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "0") {
                      return "Input tidak boleh kosong atau 0";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Tanggal Sewa',
                  style: TextStyle(fontSize: 12, color: AppColor.textPrimary),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _tanggalContainer,
                        readOnly: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _pilihTanggal(context),
                      icon: Icon(Icons.calendar_month),
                    )
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Ajukan'),
              onPressed: () => _submitSewa(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _tanggal) {
      setState(() {
        _tanggal = picked;
        _tanggalContainer.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitSewa(BuildContext context) {
    if (_durasi.text.isEmpty || _tanggalContainer.text.isEmpty) {
      // Menampilkan pemberitahuan jika ada field yang kosong
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Mohon Isi Semua Field',
                style: TextStyle(fontSize: 15),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
              ),
            ],
          );
        },
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> body = {
      'user_id': user!.uid,
      'user_email': user.email,
      'kos_id': widget.id,
      ...kos,
      'durasi_sewa': _durasi.text,
      'tanggal_mulai': _tanggalContainer.text,
      'approved': false,
      'created_at': Timestamp.now(),
    };
    final res = memberServices.addData(body);

    if (res) {
      Navigator.pop(context);
      // Menampilkan pemberitahuan setelah sukses submit
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Pengajuan berhasil')),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Pengajuan tidak dapat dilanjutkan',
                style: TextStyle(fontSize: 12),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class BodyDetail extends StatelessWidget {
  const BodyDetail({
    Key? key,
    required this.id,
    this.name,
    this.alamat,
    this.owner,
    this.price,
    this.image,
    required this.kosServices,
  }) : super(key: key);

  final String id;
  final String? name;
  final String? alamat;
  final String? owner;
  final String? price;
  final String? image;
  final KosServices kosServices;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${image}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${alamat}',
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          '${name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Text(
                        'PUTRA',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pemilik',
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          '${owner}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Harga Sewa',
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          '${price}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            indicatorColor: AppColor.primary,
            padding: EdgeInsets.all(10),
            labelColor: Colors.black,
            tabs: [
              Tab(text: "Fasilitas"),
              Tab(text: "Peraturan"),
            ],
          ),
          Container(
            width: double.infinity,
            color: AppColor.bgLight,
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: MediaQuery.of(context).size.height / 2,
            ),
            child: TabBarView(
              children: [
                // fasilitas
                MemberFasilitasBuilder(kosServices: kosServices, id: id),
                StreamBuilder(
                  stream: kosServices.peraturan(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading data'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('Data not found'));
                    } else {
                      var items = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot item = items[index];
                          return ListTile(
                            title: Text(item['name']),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
