class Koperasi {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String photo;
  final String createdAt;
  final String updatedAt;
  final String? tokenType;
  final String? accessToken;
  final String? role;
  final String? photoUrl;

  Koperasi({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    this.tokenType,
    this.accessToken,
    this.role,
    this.photoUrl,
  });

  factory Koperasi.fromJsonLogin(Map<String, dynamic> json) {
    return Koperasi(
      id: json['user']['id'],
      name: json['user']['nama'],
      email: json['user']['email'],
      address: json['user']['alamat'],
      phoneNumber: json['user']['no_hp'],
      photo: json['user']['foto'],
      createdAt: json['user']['created_at'],
      updatedAt: json['user']['updated_at'],
      tokenType: json['token_type'],
      accessToken: json['access_token'],
    );
  }

  factory Koperasi.fromJson(Map<String, dynamic> json) {
    return Koperasi(
      id: json['id'],
      name: json['nama'],
      email: json['email'],
      address: json['alamat'],
      phoneNumber: json['no_hp'],
      photo: json['foto'],
      photoUrl: json['foto_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      role: json['role'],
    );
  }
}
