import 'package:flutter/material.dart';

class OwnerKostSearchPage extends StatefulWidget {
  @override
  _KostSearchPageState createState() => _KostSearchPageState();
}

class _KostSearchPageState extends State<OwnerKostSearchPage> {
  String location = '';
  double maxPrice = 1000.0; // Harga maksimum
  bool hasAC = false; // Filter AC
  bool hasWifi = false; // Filter Wifi

  // Daftar semua kost yang tersedia (Anda bisa memasukkan data Anda sendiri)
  final List<KostData> allKosts = [
    KostData(
        name: 'Kost A',
        location: 'Jakarta',
        price: 800.0,
        hasAC: true,
        hasWifi: true),
    KostData(
        name: 'Kost B',
        location: 'Surabaya',
        price: 700.0,
        hasAC: false,
        hasWifi: true),
    // Tambahkan data kost lainnya di sini
  ];

  List<KostData> filteredKosts = [];

  @override
  void initState() {
    super.initState();
    filteredKosts = allKosts;
  }

  void applyFilters() {
    setState(() {
      filteredKosts = allKosts.where((kost) {
        final isLocationMatch = location.isEmpty ||
            kost.location.toLowerCase().contains(location.toLowerCase());
        final isPriceMatch = kost.price <= maxPrice;
        final isACMatch = !hasAC || kost.hasAC;
        final isWifiMatch = !hasWifi || kost.hasWifi;
        return isLocationMatch && isPriceMatch && isACMatch && isWifiMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Kos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Lokasi',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Harga Maksimum: \$${maxPrice.toStringAsFixed(0)}'),
                Slider(
                  value: maxPrice,
                  onChanged: (value) {
                    setState(() {
                      maxPrice = value;
                    });
                  },
                  min: 0,
                  max: 1000,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: hasAC,
                  onChanged: (value) {
                    setState(() {
                      hasAC = value!;
                    });
                  },
                ),
                Text('AC'),
                Checkbox(
                  value: hasWifi,
                  onChanged: (value) {
                    setState(() {
                      hasWifi = value!;
                    });
                  },
                ),
                Text('Wifi'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              applyFilters();
            },
            child: Text('Terapkan Filter'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredKosts.length,
              itemBuilder: (context, index) {
                final kost = filteredKosts[index];
                return ListTile(
                  title: Text(kost.name),
                  subtitle: Text(
                      '${kost.location} - \$${kost.price.toStringAsFixed(0)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KostData {
  final String name;
  final String location;
  final double price;
  final bool hasAC;
  final bool hasWifi;

  KostData({
    required this.name,
    required this.location,
    required this.price,
    required this.hasAC,
    required this.hasWifi,
  });
}
