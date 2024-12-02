import 'package:compra/manager/auth_manager.dart';
import 'package:compra/service/queries/item_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/response_model.dart';

class ItemManager {
  final BuildContext context;

  ItemManager(this.context) {
    authManager = Provider.of<AuthManager>(context, listen: false);
    token = authManager.accessToken;
  }

  late final AuthManager authManager;
  late final String token;

  Future<ResponseModel?> checkItem({
    required int itemId,
  }) async {
      return await ItemService.checkItem(token: token, id: itemId);
  }

  Future<ResponseModel?> deleteItem({
    required int itemId,
  }) async {
      return await ItemService.deleteItem(token: token, id: itemId);
  }

  Future<ResponseModel?> createItem({
    required int listId,
    required String name,
    required double quantity,
    double? price,
    String? description,
  }) async {
      return await ItemService.createItem(token: token, listId: listId, name: name, quantity: quantity, price: price, description: description);
  }

  Future<ResponseModel?> updateItem({
    required int itemId,
    required String name,
    required double quantity,
    double? price,
    String? description,
  }) async {
      return await ItemService.updateItem(token: token, itemId: itemId, name: name, quantity: quantity, price: price, description: description);
  }
}
