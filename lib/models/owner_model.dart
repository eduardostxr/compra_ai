class OwnerModel {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String name;
  final String email;
  final String password;
  final String telephone;
  final String pixKey;

  OwnerModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.email,
    required this.password,
    required this.telephone,
    required this.pixKey,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      telephone: json['telephone'],
      pixKey: json['pixKey'],
    );
  }
}