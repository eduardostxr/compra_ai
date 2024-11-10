import "package:compra/models/response_model.dart";
import "package:flutter/material.dart";
import "dart:convert";
import "../web_service.dart";

class AuthService {
  static Future<ResponseModel?> login({
    required String email,
    required String password,
  }) async {
    const String path = '/api/auth/login';

    try {
      final response = await WebService.post(path, {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.statusCode, "Login bem-sucedido!", jsonDecode(response.body));
        debugPrint('Login successful: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(response.statusCode, "Falha ao fazer login", jsonDecode(response.body));
        debugPrint('Failed to login: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(500, "Verifique sua conexão com a internet", null);
      debugPrint('Error during login: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> signUp({
    required String name,
    required String email,
    required String password,
    required String telephone,
    String? pixKey,
  }) async {
    const String path = '/api/auth/signup';

    try {
      final response = await WebService.post(path, {
        "name": name,
        "email": email,
        "password": password,
        "pixKey": pixKey,
        "telephone": telephone,
      });

      if (response.statusCode == 201) {
        ResponseModel responseModel = ResponseModel.fromJson(response.statusCode, "Bem-vindo!", jsonDecode(response.body));
        debugPrint('Sign up successful: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(response.statusCode, "Falha ao criar conta", jsonDecode(response.body));
        debugPrint('Failed to sign up: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(500, "Verifique sua conexão com a internet", null);
      debugPrint('Error during sign up: $e');
      return responseModel;
    }
  }
}
