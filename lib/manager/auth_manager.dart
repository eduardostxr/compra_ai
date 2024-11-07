import "package:compra/service/queries/auth_service.dart";
import "package:flutter/material.dart";
import "../models/response_model.dart";
import 'dart:convert';

class AuthManager with ChangeNotifier {
  String? _accessToken;
  // String? _refreshToken;
  int? _userId;

  String get accessToken => _accessToken!;
  int get userId => _userId!;

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  // void setRefreshToken(String refreshToken) {
  //   _refreshToken = refreshToken;
  //   notifyListeners();
  // }

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    final payload = parts[1];
    final paddedPayload = _padBase64(payload);
    final decoded = utf8.decode(base64Url.decode(paddedPayload));
    
    return jsonDecode(decoded);
  }

  String _padBase64(String base64) {
    switch (base64.length % 4) {
      case 2:
        return "$base64==";
      case 3:
        return "$base64=";
      default:
        return base64;
    }
  }

  Future<ResponseModel?> login(BuildContext context, String email, String password) async {
    ResponseModel? response = await AuthService.login(email: email, password: password);

    if (response != null && response.statusCode == 200) {
      setAccessToken(response.value["accessToken"]);
      // setRefreshToken(response.value["refreshToken"]);
      
      String accessToken = response.value["accessToken"];
      Map<String, dynamic> userData = decodeJwt(accessToken);

      debugPrint('Decoded JWT Payload: ${jsonEncode(userData)}');

      int userId = userData['userId'];
      setUserId(userId);
    }

    return response;
  }

  Future<ResponseModel?> signUp(BuildContext context, String name, String email, String password, String telephone) async {
    ResponseModel? response = await AuthService.signUp(email: email, name: name, password: password, telephone: telephone);
    return response;
  }
}
