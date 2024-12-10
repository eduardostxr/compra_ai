import 'dart:collection';

import 'package:compra/models/complete_list_model.dart';
import 'package:compra/models/invite_model.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/models/list_model.dart';
import 'package:compra/models/purchase.dart';
import 'package:compra/service/queries/list_service.dart';
import 'package:flutter/material.dart';
import '../models/response_model.dart';

class ListManager extends ChangeNotifier {
  CompleteListModel? completeList;
  List<ListModel> lists = [];
  List<InviteModel> invites = [];
  Purchase? purchase;

  UnmodifiableListView<ListModel> get allLists => UnmodifiableListView(lists);

  UnmodifiableListView<InviteModel> get allInvites =>
      UnmodifiableListView(invites);

  UnmodifiableListView<ItemModel> get allItems => UnmodifiableListView(
        completeList?.items ?? [],
      );

  void addNewItem(ItemModel item) {
    completeList!.items.add(item);
    notifyListeners();
  }

  void updateItem(ItemModel item) {
    final index = completeList!.items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      completeList!.items[index] = item;
      notifyListeners();
    }
  }

  void addPurchaseProduct(Product product) {
    purchase!.payload.produtos.add(product);
    notifyListeners();
  }

  void removePurchaseProduct(Product product) {
    purchase!.payload.produtos.remove(product);
    notifyListeners();
  }

  void updateMyList(ListModel list) {
    final index = lists.indexWhere((l) => l.id == list.id);
    if (index != -1) {
      lists[index] = list;
      notifyListeners();
    }
  }

  void updatePurchaseProduct(Product product, int index) {
    if (index != -1) {
      purchase!.payload.produtos[index] = product;
      notifyListeners();
    }
  }

  void removeFromList(ItemModel item) {
    completeList!.items.remove(item);
    notifyListeners();
  }

  void addToList(ItemModel item) {
    completeList!.items.add(item);
    notifyListeners();
  }

  void removeList(int listId) {
    lists.removeWhere((list) => list.id == listId);
    notifyListeners();
  }

  void setPurchase(Purchase purchase) {
    this.purchase = purchase;
    notifyListeners();
  }

  // void setLists(List<ListModel> lists) {
  //   this.lists = lists;
  //   notifyListeners();
  // }

  void setCompleteList(CompleteListModel completeList) {
    this.completeList = completeList;
    notifyListeners();
  }

  void setInvites(List<InviteModel> invites) {
    this.invites = invites;
    notifyListeners();
  }

  void updateItemStatus(ItemModel updatedItem) {
    final index =
        completeList!.items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      completeList!.items[index] = updatedItem;
      notifyListeners();
    }
  }

  void setLists(List<ListModel> newLists) {
    lists = newLists;
    notifyListeners();
  }

  Future<ResponseModel?> finishList(
      String token, int listId, Purchase purchase) async {
    final requestBody = {
      "listTotalPrice": purchase.payload.listTotalPrice,
      "purchaseDate": purchase.payload.purchaseDate,
      "receiptItems": purchase.payload.produtos.map((product) {
        return {
          "name": product.name,
          "quantity": product.quantity,
          "price": product.price,
          "unitPrice": product.unitPrice,
          "measurementUnit": product.measurementUnit,
        };
      }).toList(),
    };

    ResponseModel? response =
        await ListService.finishList(token, listId, requestBody);

    if (response != null && response.statusCode == 200) {
      debugPrint("List successfully finished.");
      getLists(token);
    } else {
      debugPrint("Failed to finish list. Message: ${response?.message}");
    }

    return response;
  }

  void createList(
      String token, String name, String emoji, double? maxSpend) async {
    ResponseModel? response = await ListService.createList(
      token: token,
      name: name,
      emoji: emoji,
      maxSpend: maxSpend,
    );

    if (response != null && response.statusCode == 201) {
      debugPrint("List successfully created.");
    } else {
      debugPrint("Failed to create list. Message: ${response?.message}");
    }
  }

  Future<bool> deleteList(String token, int listId) async {
    ResponseModel? response =
        await ListService.deleteList(token: token, listId: listId);

    if (response != null && response.statusCode == 204) {
      debugPrint("List successfully deleted.");
      completeList = null;
      return true;
    } else {
      debugPrint("Failed to delete list. Message: ${response?.message}");
      return false;
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
      CompleteListModel data = CompleteListModel.fromJson(response.value);
      setCompleteList(data);
      debugPrint("List items successfully fetched and updated.");
    } else {
      debugPrint("Failed to fetch list items. Message: ${response?.message}");
    }
    return response;
  }

  Future<ResponseModel?> updateList(
    String token,
    int listId,
    String name,
    String emoji,
    double? maxSpend,
  ) async {
    try {
      final response = await ListService.updateList(
        token: token,
        listId: listId,
        name: name,
        emoji: emoji,
        maxSpend: maxSpend,
      );

      if (response != null &&
          response.statusCode >= 201 &&
          response.statusCode < 300) {
        response.message = "Lista atualizada com sucesso!";
        response.statusCode = 201;
        response.value = null;
        debugPrint("List successfully updated: ${response.message}");
      } else {
        debugPrint(
            "Failed to update list. Message: ${response?.message ?? "Unknown error"}");
      }

      return response;
    } catch (e) {
      debugPrint("Error while updating list: $e");
      return ResponseModel(
        statusCode: 500,
        message: "Erro ao atualizar a lista. Tente novamente.",
        value: null,
      );
    }
  }

  Future<List<InviteModel>> getInvites(String token) async {
    ResponseModel? response = await ListService.getInvites(token);

    if (response != null && response.statusCode == 200) {
      debugPrint("Invites successfully fetched.");

      List<InviteModel> invites = (response.value as List)
          .map((inviteJson) =>
              InviteModel.fromJson(inviteJson as Map<String, dynamic>))
          .toList();

      setInvites(invites);

      return invites;
    } else {
      debugPrint("Failed to fetch invites. Message: ${response?.message}");
      return [];
    }
  }

  Future<ResponseModel?> acceptInvite(String token, int inviteId) async {
    ResponseModel? response = await ListService.acceptInvite(token, inviteId);

    if (response != null && response.statusCode == 200) {
      debugPrint("Invite successfully accepted.");
      getLists(token);
    } else {
      debugPrint("Failed to accept invite. Message: ${response?.message}");
    }

    return response;
  }

  Future<ResponseModel?> declineInvite(String token, int inviteId) async {
    ResponseModel? response = await ListService.declineInvite(token, inviteId);

    if (response != null && response.statusCode == 204) {
      debugPrint("Invite successfully declined.");
    } else {
      debugPrint("Failed to decline invite. Message: ${response?.message}");
    }

    return response;
  }
}
