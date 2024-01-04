class Profile {
  int id;
  String username;
  String nama;
  String alamat;
  String kota;
  String telp;

  Profile({
    required this.id,
    required this.username,
    required this.nama,
    required this.alamat,
    required this.kota,
    required this.telp,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      username: map['username'],
      nama: map['nama'],
      alamat: map['alamat'],
      kota: map['kota'],
      telp: map['telp'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['username'] = this.username;
    map['nama'] = this.nama;
    map['alamat'] = this.alamat;
    map['kota'] = this.kota;
    map['telp'] = this.telp;
    return map;
  }
}
