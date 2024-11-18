import 'package:compra/models/item_model.dart';
import 'package:compra/models/owner_model.dart';

class ListItemModel {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String name;
  final String emoji;
  final double? totalPrice;
  final double maxSpend;
  final int ownerId;
  final List<dynamic> userLists;
  final List<ItemModel> items;
  final OwnerModel owner;

  ListItemModel({
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

  factory ListItemModel.fromJson(Map<String, dynamic> json) {
    return ListItemModel(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      name: json['name'],
      emoji: json['emoji'],
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      maxSpend: (json['maxSpend'] as num).toDouble(),
      ownerId: json['ownerId'],
      userLists: json['userLists'] ?? [],
      items: (json['items'] as List<dynamic>)
          .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      owner: OwnerModel.fromJson(json['owner'] as Map<String, dynamic>),
    );
  }
}
