import 'package:compra/models/user_model.dart';

class ListModel {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String name;
  final String emoji;
  final int? totalPrice;
  final int? maxSpend;
  final int ownerId;
  final List<UserModel> userLists;

  ListModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.emoji,
    required this.totalPrice,
    required this.maxSpend,
    required this.ownerId,
    required this.userLists,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] ?? 0,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      deletedAt: json['deletedAt'] ?? "",
      name: json['name'] ?? "",
      emoji: json['emoji'] ?? "",
      totalPrice: json['totalPrice'] ?? 0,
      maxSpend: json['maxSpend'] ?? 0,
      ownerId: json['ownerId'] ?? 0,
      userLists: json['userLists']
              .map<UserModel>((user) => UserModel.fromJson(user))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "emoji": emoji,
      "maxSpend": maxSpend,
    };
    return data;
  }
}
