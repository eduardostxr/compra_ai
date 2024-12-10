import 'package:compra/manager/auth_manager.dart';
import 'package:compra/models/invite_model.dart';
import 'package:compra/service/queries/invite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/response_model.dart';

class InviteManager with ChangeNotifier {
  List<InviteModel>? invites;

  void setInvites(List<InviteModel> invites) {
    this.invites = invites;
    notifyListeners();
  }

  Future<void> getInvites(BuildContext context) async {
    final ResponseModel? response = await InviteService.getInvitesPending(
        token: context.read<AuthManager>().accessToken);
    if (response!.statusCode >= 200 && response.statusCode < 300) {
      invites =
          (response.value as List).map((e) => InviteModel.fromJson(e)).toList();
      setInvites(invites!);
      notifyListeners();
    }
  }

  Future<ResponseModel?> inviteUser(
      BuildContext context, String email, int listId) async {
    final ResponseModel? response = await InviteService.inviteUser(
      token: context.read<AuthManager>().accessToken,
      email: email,
      listId: listId,
    );
    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      debugPrint("Invite sent successfully.");
      getInvites(context);
    } else {
      debugPrint("Failed to send invite. Message: ${response?.message}");
    }
    return response;
  }

  Future<ResponseModel?> acceptInvite(
      BuildContext context, int inviteId, bool choice) async {
    final ResponseModel? response = await InviteService.acceptInvite(
      token: context.read<AuthManager>().accessToken,
      inviteId: inviteId,
      choice: choice,
    );
    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      debugPrint("Invite accepted successfully.");
      getInvites(context);
    } else {
      debugPrint("Failed to accept invite. Message: ${response?.message}");
    }
    return response;
  }
}
