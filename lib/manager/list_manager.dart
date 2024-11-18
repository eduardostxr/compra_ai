import 'package:compra/manager/auth_manager.dart';
import 'package:compra/service/queries/list_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/response_model.dart';

class ListManager {
  final BuildContext context;

  ListManager(this.context) {
    authManager = Provider.of<AuthManager>(context, listen: false);
    token = authManager.accessToken;
  }

  late final AuthManager authManager;
  late final String token;

  Future<ResponseModel?> createList({
    required String name,
    required String emoji,
    required String token,
    int? maxSpend,
  }) async {
    return await ListService.createList(
      name: name,
      emoji: emoji,
      maxSpend: maxSpend,
      token: token,
    );
  }

  Future<ResponseModel?> getLists() async {
    return await ListService.getLists(token: token);
  }

  Future<ResponseModel?> getItems(int listId) async {
    return await ListService.getItems(token: token, listId: listId);
  }
  
}
