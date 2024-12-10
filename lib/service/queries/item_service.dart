import 'package:compra/models/response_model.dart';
import 'dart:convert';
import '../web_service.dart';
import 'package:flutter/material.dart';

class ItemService {
  static Future<ResponseModel?> checkItem({
    required String token,
    required int id,
  }) async {
    final String path = '/api/item/$id';

    try {
      final response = await WebService.patch(path, null, token);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Item checked com sucesso!",
          jsonDecode(response.body),
        );
        debugPrint('Item checked successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          jsonDecode(response.body)["error"],
          jsonDecode(response.body),
        );
        debugPrint('Failed to check item: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro não esperado. Tente novamente.",
        null,
      );
      debugPrint('Error during item check: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> createItem({
    required String name,
    required double quantity,
    double? price,
    String? description,
    required String token,
    required int listId,
  }) async {
    final String path = '/api/item/$listId';

    final Map<String, dynamic> data = {
      "name": name,
      "quantity": quantity,
      "price": price,
      "description": description,
    };

    try {
      final response = await WebService.post(path, data, token);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Item criado com sucesso!",
          jsonDecode(response.body),
        );
        debugPrint('Item created successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          jsonDecode(response.body)["error"],
          jsonDecode(response.body),
        );
        debugPrint(
            'Failed to create item: ${responseModel.statusCode} - ${responseModel.message}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro inesperado. Tente novamente.",
        null,
      );
      debugPrint('Error during item creation: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> updateItem({
    required String name,
    required double quantity,
    double? price,
    String? description,
    required String token,
    required int itemId,
  }) async {
    final String path = '/api/item/$itemId';

    final Map<String, dynamic> data = {
      "name": name,
      "quantity": quantity,
      "price": price,
      "description": description,
    };

    try {
      final response = await WebService.put(path, data, token);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Item atualizado com sucesso!",
          jsonDecode(response.body),
        );
        debugPrint('Item updated successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          jsonDecode(response.body)["error"],
          jsonDecode(response.body),
        );
        debugPrint('Failed to update item: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro inesperado. Tente novamente.",
        null,
      );
      debugPrint('Error during item update: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> deleteItem({
    required String token,
    required int id,
  }) async {
    final String path = '/api/item/$id';

    try {
      final response = await WebService.delete(path, token);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromJson(
          response.statusCode,
          "Item deleted successfully!",
          null,
        );
      } else {
        final message = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : "Unexpected error during deletion.";
        return ResponseModel.fromJson(
          response.statusCode,
          jsonDecode(response.body)["error"],
          message,
        );
      }
    } catch (e) {
      debugPrint('Error during item deletion: $e');
      return ResponseModel.fromJson(
        500,
        "Erro inesperado. Tente novamente.",
        null,
      );
    }
  }
}
