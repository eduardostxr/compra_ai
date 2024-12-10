
import 'package:compra/models/invited_by_model.dart';
import 'package:compra/models/list_model.dart';

class InviteModel {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? telephone;
  final String email;
  final int listId;
  final int invitedById;
  final int userId;
  final String status;
  final ListModel list;
  final InvitedByModel invitedBy;

  InviteModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.telephone,
    required this.email,
    required this.listId,
    required this.invitedById,
    required this.userId,
    required this.status,
    required this.list,
    required this.invitedBy,
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      telephone: json['telephone'],
      email: json['email'],
      listId: json['listId'],
      invitedById: json['invitedById'],
      userId: json['userId'],
      status: json['status'],
      list: ListModel.fromJson(json['list']),
      invitedBy: InvitedByModel.fromJson(json['invitedBy']),
    );
  }


}

