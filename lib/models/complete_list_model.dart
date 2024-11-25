import 'package:compra/models/item_model.dart';
import 'package:compra/models/user_model.dart';

class CompleteListModel {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String emoji;
  final double? totalPrice;
  final double maxSpend;
  final int ownerId;
  final List<UserModel> userLists;
  final List<ItemModel> items;
  final UserModel owner;

  CompleteListModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.emoji,
    this.totalPrice,
    required this.maxSpend,
    required this.ownerId,
    required this.userLists,
    required this.items,
    required this.owner,
  });

  factory CompleteListModel.fromJson(Map<String, dynamic> json) {
    return CompleteListModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      name: json['name'],
      emoji: json['emoji'],
      totalPrice: json['totalPrice'] != null ? (json['totalPrice'] as num).toDouble() : null,
      maxSpend: (json['maxSpend'] as num).toDouble(),
      ownerId: json['ownerId'],
      userLists: (json['userLists'] as List).map((user) => UserModel.fromJson(user)).toList(),
      items: (json['items'] as List).map((item) => ItemModel.fromJson(item)).toList(),
      owner: UserModel.fromJson(json['owner']),
    );
  }
}
