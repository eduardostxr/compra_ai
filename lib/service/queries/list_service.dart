import 'package:compra/models/response_model.dart';
import 'dart:convert';
import '../web_service.dart';
import 'package:flutter/material.dart';

class ListService {
  static Future<ResponseModel?> createList({
    required String name,
    String? emoji,
    double? maxSpend,
  }) async {
    const String path = '/api/lists';

    try {
      final response = await WebService.post(path, {
        'name': name,
        'emoji': emoji,
        'maxSpend': maxSpend,
      });

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
}
