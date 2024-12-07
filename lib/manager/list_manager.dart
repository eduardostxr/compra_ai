import 'package:compra/models/complete_list_model.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/models/list_model.dart';
import 'package:compra/service/queries/list_service.dart';
import 'package:flutter/material.dart';
import '../models/response_model.dart';

class ListManager extends ChangeNotifier {
  CompleteListModel? completeList;
  List<ListModel> lists = [];

  void setLists(List<ListModel> lists) {
    this.lists = lists;
    notifyListeners();
  }

  void setCompleteList(CompleteListModel completeList) {
    this.completeList = completeList;
    notifyListeners();
  }

  void updateItemStatus(ItemModel updatedItem) {
    final index = completeList!.items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      completeList!.items[index] = updatedItem;
      notifyListeners();
    }
  }

  void createList(String token, String name, String emoji, double? maxSpend) async {
    ResponseModel? response = await ListService.createList(
      token: token,
      name: name,
      emoji: emoji,
      maxSpend: maxSpend,
    );

    if (response != null && response.statusCode == 201) {
      debugPrint("List successfully created.");
      getLists(token);
    } else {
      debugPrint("Failed to create list. Message: ${response?.message}");
    }
  }


  Future<ResponseModel?> getLists(String token) async {
    ResponseModel? response = await ListService.getLists(token: token);

    if (response != null && response.statusCode == 200) {
      List<ListModel> data = (response.value as List)
          .map((item) => ListModel.fromJson(item as Map<String, dynamic>))
          .toList();
      setLists(data);
      debugPrint("Lists successfully fetched and updated.");
    } else {
      debugPrint("Failed to fetch lists. Message: ${response?.message}");
    }

    return response;
  }

  Future<ResponseModel?> getListItems(String token, int listId) async {
    ResponseModel? response =
        await ListService.getListItems(token: token, listId: listId);
    if (response != null && response.statusCode == 200) {
      CompleteListModel data =
          CompleteListModel.fromJson(response.value as Map<String, dynamic>);
      setCompleteList(data);
      debugPrint("List items successfully fetched and updated.");
    } else {
      debugPrint("Failed to fetch list items. Message: ${response?.message}");
    }
    return response;
  }
}
