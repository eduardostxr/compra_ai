import 'package:compra/models/user_model.dart';
import 'package:compra/models/item_model.dart'; // Ensure you import the ItemModel

class ListModel {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String name;
  final String emoji;
  final double? totalPrice;
  final double? maxSpend;
  final int ownerId;
  final List<UserModel> userLists;
  List<ItemModel> items; // Add this line for the 'items' property

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
    required this.items, // Include this in the constructor
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['id'] ?? 0,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      deletedAt: json['deletedAt'] ?? "",
      name: json['name'] ?? "",
      emoji: json['emoji'] ?? "",
      totalPrice: (json['totalPrice'] != null)
          ? (json['totalPrice'] as num).toDouble()
          : null,
      maxSpend: (json['maxSpend'] != null)
          ? (json['maxSpend'] as num).toDouble()
          : null,
      ownerId: json['ownerId'] ?? 0,
      userLists: json['userLists'] != null
          ? (json['userLists'] as List<dynamic>)
              .map<UserModel>((user) => UserModel.fromJson(user))
              .toList()
          : [],
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map<ItemModel>((item) => ItemModel.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "emoji": emoji,
      "maxSpend": maxSpend,
      "items": items.map((item) => item.toJson()), 
    };
    return data;
  }
}
