import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/response_model.dart';
import '../web_service.dart';

class InviteService {
  static Future<ResponseModel?> inviteUser({
    required String token,
    required String email,
    required int listId,
  }) async {
    final String path = '/api/list/invite/$listId';

    try {
      final response = await WebService.post(
        path,
        {"email": email},
        token,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromJson(
          response.statusCode,
          "Convite enviado!",
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

  static Future<ResponseModel?> getInvitesPending({
    required String token,
  }) async {
    const String path = '/api/list/invites/pending';

    try {
      final response = await WebService.get(path, null);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromJson(
          response.statusCode,
          "Convites carregados!",
          jsonDecode(response.body),
        );
      } else {
        return ResponseModel.fromJson(
          response.statusCode,
          "Erro ao carregar convites.",
          jsonDecode(response.body),
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return ResponseModel.fromJson(500, "Erro não esperado", null);
    }
  }

  static Future<ResponseModel?> acceptInvite({
    required String token,
    required int inviteId,
    required bool choice,
  }) async {
    const String path = '/api/list/invite/accept';

    try {
      final response = await WebService.post(
        path,
        {"inviteId": inviteId, "accepted": choice},
        token,
      );

      // Se o corpo da resposta estiver vazio, usa um valor padrão
      dynamic responseBody = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : {}; // Usa um objeto vazio se o corpo for vazio

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ResponseModel.fromJson(
          response.statusCode,
          "Convite aceito!",
          responseBody,
        );
      } else {
        return ResponseModel.fromJson(
          response.statusCode,
          "Erro ao aceitar convite.",
          responseBody,
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return ResponseModel.fromJson(500, "Erro não esperado", null);
    }
  }
}
