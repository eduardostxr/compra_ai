class UserModel {
  String? id;
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
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      telephone: json['telephone'] ?? '',
      pixKey: json['pixKey'] ?? '',
    );
  }



Map<String, dynamic> toJson() {
  final data = {
    "email": email,
    "name": name,
    "telephone": telephone,
    "pixKey": pixKey,
  };
  if (id != null) {
    data["id"] = id!;
  }
  return data;
}

}
