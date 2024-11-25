class UserModel {
  int? id;
  final String email;
  final String name;
  final String telephone;
  final String pixKey;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.telephone,
    required this.pixKey,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      telephone: json['telephone'] ?? '',
      pixKey: json['pixKey'] ?? '',
    );
  }




}
