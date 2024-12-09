import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/response_model.dart';
import '../web_service.dart';

class AuthService {
  static Future<ResponseModel?> login({
    required String email,
    required String password,
  }) async {
    const String path = '/api/auth/login';

    try {
      final response = await WebService.post(path, {
        'email': email.trim(),
        'password': password.trim(),
        
      }, null);

      debugPrint('Login response status: ${response.statusCode}');
      debugPrint('Login response body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromJson(
          response.statusCode,
          "Login bem-sucedido!",
          jsonDecode(response.body),
        );
      } else {
        return ResponseModel.fromJson(
          response.statusCode,
          jsonDecode(response.body)["error"],
          jsonDecode(response.body),
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return ResponseModel.fromJson(500, "Erro não esperado", null);
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
        "name": name.trim(),
        "email": email.trim(),
        "password": password.trim(),
        "pixKey": pixKey,
        "telephone": telephone.trim(),
      }, null);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromJson(
          response.statusCode,
          "Bem-vindo!",
          jsonDecode(response.body),
        );
      } else {
        return ResponseModel.fromJson(
          response.statusCode,
          jsonDecode(response.body)["error"],
          jsonDecode(response.body),
        );
      }
    } catch (e) {
      debugPrint('SignUp error: $e');
      return ResponseModel.fromJson(500, "Erro de conexão", null);
    }
  }
}
