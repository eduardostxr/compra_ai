import 'package:compra/models/purchase.dart';
import 'package:compra/models/response_model.dart';
import 'dart:convert';
import '../web_service.dart';
import 'package:flutter/material.dart';

class ListService {

  static Future<ResponseModel?> finishList(String token, int listId, Purchase purchase) {
    final String path = '/api/list/finish/$listId';

    try {
      return WebService.post(path, purchase.payload, token).then((response) {
        if (response.statusCode == 200) {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Lista finalizada com sucesso!",
            jsonDecode(response.body),
          );
          debugPrint('List finished successfully: ${response.statusCode}');
          return responseModel;
        } else {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Falha ao finalizar lista",
            jsonDecode(response.body),
          );
          debugPrint('Failed to finish list: ${response.statusCode}');
          return responseModel;
        }
      });
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during list finishing: $e');
      return Future.value(responseModel);
    }
  }

  static Future<ResponseModel?> acceptInvite(String token, int inviteId) {
    String path = '/api/invite/accept';

    try {
      return WebService.post(path, null, token).then((response) {
        if (response.statusCode == 200) {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Convite aceito com sucesso!",
            jsonDecode(response.body),
          );
          debugPrint('Invite accepted successfully: ${response.statusCode}');
          return responseModel;
        } else {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Falha ao aceitar convite",
            jsonDecode(response.body),
          );
          debugPrint('Failed to accept invite: ${response.statusCode}');
          return responseModel;
        }
      });
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during invite acceptance: $e');
      return Future.value(responseModel);
    }
  }

  static Future<ResponseModel?> declineInvite(String token, int inviteId) {
    String path = '/api/invite/decline';

    try {
      return WebService.post(path, null, token).then((response) {
        if (response.statusCode == 200) {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Convite recusado com sucesso!",
            jsonDecode(response.body),
          );
          debugPrint('Invite declined successfully: ${response.statusCode}');
          return responseModel;
        } else {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Falha ao recusar convite",
            jsonDecode(response.body),
          );
          debugPrint('Failed to decline invite: ${response.statusCode}');
          return responseModel;
        }
      });
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during invite decline: $e');
      return Future.value(responseModel);
    }
  }

  static Future<ResponseModel?> getInvites(String token) {
    const String path = '/api/list/invites/pending';

    try {
      return WebService.get(path, token).then((response) {
        if (response.statusCode == 200) {
          List<dynamic> invitesData = jsonDecode(response.body);
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Convites obtidos com sucesso!",
            invitesData,
          );
          debugPrint('Invites fetched successfully: ${response.statusCode}');
          return responseModel;
        } else {
          ResponseModel responseModel = ResponseModel.fromJson(
            response.statusCode,
            "Falha ao buscar convites",
            jsonDecode(response.body),
          );
          debugPrint('Failed to fetch invites: ${response.statusCode}');
          return responseModel;
        }
      });
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during invites fetching: $e');
      return Future.value(responseModel);
    }
  }

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

  static Future<ResponseModel?> updateList({
    required String token,
    required int listId,
    required String name,
    String? emoji,
    double? maxSpend,
  }) async {
    final String path = '/api/list/$listId';

    try {
      final response = await WebService.put(
          path,
          {
            'name': name,
            'emoji': emoji,
            'maxSpend': maxSpend,
          },
          token);

      if (response.statusCode == 201) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Lista atualizada com sucesso!",
          jsonDecode(response.body),
        );
        debugPrint('List updated successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Falha ao atualizar a lista",
          jsonDecode(response.body),
        );
        debugPrint('Failed to update list: ${response.statusCode}');
        debugPrint('Failed to update list: ${response.body}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during list update: $e');
      return responseModel;
    }
  }

  static Future<ResponseModel?> createList({
    required String token,
    required String name,
    String? emoji,
    double? maxSpend,
  }) async {
    const String path = '/api/list';

    try {
      final response = await WebService.post(
        path,
        {
          'name': name,
          'emoji': emoji,
          'maxSpend': maxSpend,
        },
        token,
      );

      debugPrint('Response Status: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        // Check if body is not empty before parsing
        final dynamic data =
            response.body.isNotEmpty ? jsonDecode(response.body) : null;

        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Lista criada com sucesso!",
          data,
        );
        return responseModel;
      } else {
        final dynamic errorData =
            response.body.isNotEmpty ? jsonDecode(response.body) : null;

        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Falha ao criar a lista",
          errorData,
        );
        return responseModel;
      }
    } catch (e) {
      debugPrint('Error during list creation: $e');

      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
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

  static Future<ResponseModel?> deleteList({
    required String token,
    required int listId,
  }) async {
    final String path = '/api/list/$listId';

    try {
      final response = await WebService.delete(path, token);

      if (response.statusCode == 204) {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Lista deletada com sucesso!",
          null,
        );
        debugPrint('List deleted successfully: ${response.statusCode}');
        return responseModel;
      } else {
        ResponseModel responseModel = ResponseModel.fromJson(
          response.statusCode,
          "Falha ao deletar a lista",
          jsonDecode(response.body),
        );
        debugPrint('Failed to delete list: ${response.statusCode}');
        return responseModel;
      }
    } catch (e) {
      ResponseModel responseModel = ResponseModel.fromJson(
        500,
        "Erro de conexão. Tente novamente.",
        null,
      );
      debugPrint('Error during list deletion: $e');
      return responseModel;
    }
  }
}
