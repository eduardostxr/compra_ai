  class InvitedByModel {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String email;
  final String password;
  final String telephone;
  final String pixKey;

  InvitedByModel({
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

  
  factory InvitedByModel.fromJson(Map<String, dynamic> json) {
    return InvitedByModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      telephone: json['telephone'],
      pixKey: json['pixKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'name': name,
      'email': email,
      'password': password,
      'telephone': telephone,
      'pixKey': pixKey,
    };
  }
}