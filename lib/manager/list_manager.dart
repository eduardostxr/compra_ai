import 'dart:io';
import 'dart:convert';

import 'package:compra/models/complete_list_model.dart';
import 'package:compra/models/invite_model.dart';
import 'package:compra/models/item_model.dart';
import 'package:compra/models/list_model.dart';
import 'package:compra/models/purchase.dart';
import 'package:compra/service/queries/list_service.dart';
import 'package:compra/service/web_service.dart';
import 'package:flutter/material.dart';
import '../models/response_model.dart';

class ListManager extends ChangeNotifier {
  CompleteListModel? completeList;
  List<ListModel> lists = [];
  List<InviteModel> invites = [];
  Purchase? purchase;

  void addPurchaseProduct(Product product) {
    purchase!.payload.produtos.add(product);
    notifyListeners();
  }

  void removePurchaseProduct(Product product) {
    purchase!.payload.produtos.remove(product);
    notifyListeners();
  }

  void updatePurchaseProduct(Product product, int index) {
    if (index != -1) {
      purchase!.payload.produtos[index] = product;
      notifyListeners();
    }
  }

  void setPurchase(Purchase purchase) {
    this.purchase = purchase;
    notifyListeners();
  }

  void setLists(List<ListModel> lists) {
    this.lists = lists;
    notifyListeners();
  }

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

Future<ResponseModel?> uploadReceipt({
    required String token,
    required int receiptId,
    required File image,
  }) async {
    const String path = '/api/receipt/upload';

    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      final response = await WebService.post(
        path,
        {
          'receiptId': receiptId,
          'imageBase64': base64Image,
        },
        token,
      );
      if (response.statusCode == 200) {
        debugPrint("Receipt uploaded successfully: ${response.body}");
        return ResponseModel.fromJson(
          response.statusCode,
          "Receipt uploaded successfully!",
          Purchase.fromJson(jsonDecode(response.body)),
        );
      } else {
        debugPrint("Failed to upload receipt: ${response.statusCode}");
        return ResponseModel.fromJson(
          response.statusCode,
          "Failed to upload receipt",
          jsonDecode(response.body),
        );
      }
    } catch (e) {
      debugPrint("Error uploading receipt: $e");
      return ResponseModel(
        statusCode: 500,
        message: "Error uploading receipt. Please try again.",
        value: null,
      );
    }
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
      CompleteListModel data =
          CompleteListModel.fromJson(response.value as Map<String, dynamic>);
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

    if (response?.statusCode == 201) {
      debugPrint("List successfully updated: ${response?.message}");
    } else {
      debugPrint("Failed to update list. Message: ${response?.message ?? "Unknown error"}");
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
