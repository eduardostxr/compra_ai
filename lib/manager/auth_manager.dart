import "package:compra/service/queries/auth_service.dart";
import "package:flutter/material.dart";
import "../models/response_model.dart";

class AuthManager with ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;

  String get accessToken => _accessToken!;
  String get refreshToken => _refreshToken!;

  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    notifyListeners();
  }

  Future<ResponseModel?> login(BuildContext context, String email, String password) async {
    ResponseModel? response = await AuthService.login(email: email, password: password);
    if (response != null && response.statusCode == 200) {
      setAccessToken(response.value["accessToken"]);
      setRefreshToken(response.value["refreshToken"]);
    }
    debugPrint("Access Token: $_accessToken");
    debugPrint("Refresh Token: $_refreshToken");

    return response;
  }

  Future<ResponseModel?> signUp(BuildContext context, String name, String email, String password, String telephone, String pixKey) async {
    ResponseModel? response = await AuthService.signUp(email: email, name: name, password: password, telephone: telephone, pixKey: pixKey);
    return response;
  }
}
