class Kost {
  final String name;
  final String location;
  final String type; // Jenis kost (pria, wanita, campuran)
  final String description; // Deskripsi kost
  bool isBlocked;

  Kost({
    required this.name,
    required this.location,
    required this.type,
    required this.description,
    this.isBlocked = false,
  });
}
