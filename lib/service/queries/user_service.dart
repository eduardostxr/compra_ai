import 'package:compra/models/response_model.dart';
import 'dart:convert';
import '../web_service.dart';
import 'package:flutter/material.dart';

class UserService {
  static Future<ResponseModel?> getMe({
  required String token,
  }) async {
    const String path = '/api/user/me';

    try {
      final response = await WebService.get(path, token);

      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Usuário recuperado com sucesso!",
          jsonDecode(response.body),
        );
        debugPrint('User successfully retrieved: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Falha buscar Usuário",
          jsonDecode(response.body),
        );
        debugPrint('Failed to retrieve user: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error to get logged user: $e');
      return responseModel;
    }
  }
}
