import 'package:compra/manager/auth_manager.dart';
import 'package:provider/provider.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/service/queries/item_service.dart';
import 'package:flutter/material.dart';
import '../models/response_model.dart';

class ItemManager extends ChangeNotifier {
  Future<void> checkItem({
    required int itemId,
    required String token,
    required ListManager listManager,
  }) async {
    final response = await ItemService.checkItem(token: token, id: itemId);

    if (response != null && response.statusCode == 200) {
      ItemModel item =
          ItemModel.fromJson(response.value as Map<String, dynamic>);
      debugPrint(item.checked.toString());
      listManager.updateItemStatus(item);
    }
  }

  Future<ResponseModel?> deleteItem({
    required int itemId,
    required String token,
  }) async {
    final response = await ItemService.deleteItem(token: token, id: itemId);

    if (response != null && response.statusCode == 200) {
      return response;
    }
    return response;
  }

  Future<ResponseModel?> createItem({
    required BuildContext context,
    required int listId,
    required String name,
    required double quantity,
    double? price,
    String? description,
  }) async {
    final response = await ItemService.createItem(
      token: Provider.of<AuthManager>(context, listen: false).accessToken,
      listId: listId,
      name: name,
      quantity: quantity,
      price: price,
      description: description,
    );
    print(response);
    return response;
  }

  Future<ResponseModel?> updateItem({
    required int itemId,
    required String name,
    required double quantity,
    double? price,
    String? description,
    required String token,
    required ListManager listManager,
  }) async {
    final response = await ItemService.updateItem(
      token: token,
      itemId: itemId,
      name: name,
      quantity: quantity,
      price: price,
      description: description,
    );

    if (response != null && response.statusCode == 200) {
      listManager.getListItems(token, listManager.completeList!.id);
    }
    return response;
  }
}
