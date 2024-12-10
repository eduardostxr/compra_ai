import 'package:compra/models/item_model.dart';
import 'package:compra/models/user_model.dart';

class CompleteListModel {
  int id;
  DateTime createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String name;
  String emoji;
  bool isfinished;
  DateTime? purchaseDate;
  double? totalPrice;
  double maxSpend;
  int ownerId;
  List<UserModel> userLists;
  List<ItemModel> items;
  UserModel owner;

  CompleteListModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.emoji,
    this.totalPrice,
    this.purchaseDate,
    required this.isfinished,
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
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      name: json['name'],
      emoji: json['emoji'],
      totalPrice: json['totalPrice'] != null
          ? (json['totalPrice'] as num).toDouble()
          : null,
      isfinished: json['isFinished'],
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'])
          : null,
      maxSpend: (json['maxSpend'] as num).toDouble(),
      ownerId: json['ownerId'],
      userLists: (json['userLists'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList(),
      items: (json['items'] as List)
          .map((item) => ItemModel.fromJson(item))
          .toList(),
      owner: UserModel.fromJson(json['owner']),
    );
  }
}
