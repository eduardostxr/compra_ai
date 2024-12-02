import 'package:compra/manager/auth_manager.dart';
import 'package:compra/models/user_model.dart';
import 'package:compra/service/queries/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/response_model.dart';

class UserManager with ChangeNotifier {
  UserModel? _logedUser;

  UserModel get logedUser => _logedUser!;

  void setLogedUser(UserModel logedUser) {
    _logedUser = logedUser;
    notifyListeners();
  }

  Future<ResponseModel?> getMe(BuildContext context) async {
    ResponseModel? response = await UserService.getMe(token: Provider.of<AuthManager>(context, listen: false).accessToken);
    
    if (response != null && response.statusCode == 200) {
      setLogedUser(UserModel.fromJson(response.value));
      debugPrint("User data retrieved successfully.");
    } else {
      debugPrint("Login failed. Message: ${response?.message}");
    }

    return response;
  }
}
