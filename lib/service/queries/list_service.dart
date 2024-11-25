import 'package:compra/models/response_model.dart';
import 'dart:convert';
import '../web_service.dart';
import 'package:flutter/material.dart';

class ListService {
  static Future<ResponseModel?> getLists({required String token}) async {
    const String path = '/api/list';

    try {
      final response = await WebService.get(path, token);

      if (response.statusCode == 200) {
        List<dynamic> listData = jsonDecode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Listas obtidas com sucesso!",
          listData,
        );
        debugPrint('Lists fetched successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Falha ao buscar listas",
          jsonDecode(response.body),
        );
        debugPrint('Failed to fetch lists: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during lists fetching: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> createList({
    required String token,
    required String name,
    String? emoji,
    int? maxSpend,
  }) async {
    const String path = '/api/list';

    try {
      final response = await WebService.post(path, {
        'name': name,
        'emoji': emoji,
        'maxSpend': maxSpend,
      }, token);

      if (response.statusCode == 201) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Lista criada com sucesso!",
          jsonDecode(response.body),
        );
        debugPrint('List created successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Falha ao criar a lista",
          jsonDecode(response.body),
        );
        debugPrint('Failed to create list: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during list creation: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> getListItems({
  required String token,
  required int listId,
}) async {
  final String path = '/api/list/items/$listId';

  try {
    final response = await WebService.get(path, token);

    if (response.statusCode == 200) {
      dynamic itemsData = jsonDecode(response.body);
      ResponseModel responseModel = ResponseModel.fromJson(
        response.statusCode,
        "Itens obtidos com sucesso!",
        itemsData,
      );
      debugPrint('Items fetched successfully: ${response.statusCode}');
      return responseModel;
    } else {
      ResponseModel responseModel = ResponseModel.fromJson(
        response.statusCode,
        "Falha ao buscar itens",
        jsonDecode(response.body),
      );
      debugPrint('Failed to fetch items: ${response.statusCode}');
      return responseModel;
    }
  } catch (e) {
    ResponseModel responseModel = ResponseModel.fromJson(
      500,
      "Erro de conexão. Tente novamente.",
      null,
    );
    debugPrint('Error during items fetching: $e');
    return responseModel;
  }
}
}
