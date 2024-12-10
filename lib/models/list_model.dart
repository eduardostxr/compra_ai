import 'package:compra/models/user_model.dart';
import 'package:compra/models/item_model.dart'; // Ensure you import the ItemModel

class ListModel {
  final int id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String name;
  String emoji;
  double? totalPrice;
  double? maxSpend;
  int? ownerId;
  List<UserModel>? userLists;
  List<ItemModel>? items; 

  ListModel({
    required this.id,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
    required this.name,
    required this.emoji,
    this.totalPrice,
    this.maxSpend,
    this.ownerId,
    this.userLists,
    this.items,
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

}
