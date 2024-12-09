import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/user_model.dart';
import 'package:compra/service/queries/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/queries/auth_service.dart';
import '../models/response_model.dart';

class AuthManager with ChangeNotifier {
  UserModel? _logedUser;
  UserModel get logedUser => _logedUser!;

  void setLogedUser(UserModel logedUser) {
    _logedUser = logedUser;
    notifyListeners();
  }

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

  Future<ResponseModel?> login(
      BuildContext context, String email, String password) async {
    ResponseModel? response = await AuthService.login(
      email: email,
      password: password,
    );

    if (response != null && response.statusCode == 200) {
      setAccessToken(response.value["accessToken"]);
      setRefreshToken(response.value["refreshToken"]);
      debugPrint("Login successful. Tokens set.");
      if (context.mounted) {
        ResponseModel? userResponse = await getMe(context);
        if (context.mounted) {
          context.read<ListManager>().getLists(response.value["accessToken"]);
        }
        if (userResponse == null || userResponse.statusCode != 200) {
          debugPrint("Failed to fetch logged user data after login.");
        }
      }
    } else {
      debugPrint("Login failed. Message: ${response?.message}");
    }

    return response;
  }

  Future<ResponseModel?> getMe(BuildContext context) async {
    String token = Provider.of<AuthManager>(context, listen: false).accessToken;

    ResponseModel? response = await UserService.getMe(token: token);

    if (response != null && response.statusCode == 200) {
      setLogedUser(UserModel.fromJson(response.value));
      debugPrint("User data retrieved successfully.");
    } else {
      debugPrint("Failed to retrieve user data. Message: ${response?.message}");
    }

    return response;
  }

  Future<ResponseModel?> signUp(BuildContext context, String name, String email,
      String password, String telephone, String pixKey) async {
    ResponseModel? response = await AuthService.signUp(
      name: name,
      email: email,
      password: password,
      telephone: telephone,
      pixKey: pixKey,
    );

    if (response != null && response.statusCode == 201) {
      debugPrint("Sign-up successful. Welcome!");
    } else {
      debugPrint("Sign-up failed. Message: ${response?.message}");
    }

    return response;
  }

  //   Future<ResponseModel?> getMe(BuildContext context) async {
  //   ResponseModel? response = await UserService.getMe(token: Provider.of<AuthManager>(context, listen: false).accessToken);

  //   if (response != null && response.statusCode == 200) {
  //     setLogedUser(UserModel.fromJson(response.value));
  //     debugPrint("User data retrieved successfully.");
  //   } else {
  //     debugPrint("Login failed. Message: ${response?.message}");
  //   }

  //   return response;
  // }
}
