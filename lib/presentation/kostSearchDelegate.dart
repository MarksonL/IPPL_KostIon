import 'package:flutter/material.dart';

class Kost {
  final String name;
  final String location;
  final String type; // Jenis kost (pria, wanita, campuran)
  final String description; // Deskripsi kost

  Kost({
    required this.name,
    required this.location,
    required this.type,
    required this.description,
  });
}

List<Kost> availableKosts = [
  Kost(name: 'Kost A', location: 'Jalan A', type: 'laki', description: 'keren'),
  Kost(
      name: 'Kost B',
      location: 'Jalan B',
      type: 'perempuan',
      description: 'keren juga'),
  // Tambahkan daftar kost yang tersedia di sini
];

class KostSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementasi hasil pencarian
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = availableKosts.where((kost) {
      final kostNameLower = kost.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return kostNameLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final kost = suggestionList[index];
        return ListTile(
          title: Text(kost.name),
          onTap: () {
            close(context, kost.name);
          },
        );
      },
    );
  }
}
