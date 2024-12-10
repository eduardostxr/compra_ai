import 'package:compra/manager/invite_manager.dart';
import 'package:compra/models/response_model.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/generic_page_header.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvitePage extends StatefulWidget {
  final int listId;
  const InvitePage({super.key, required this.listId});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  late final TextEditingController emailController;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailController.addListener(_validateInputs);
  }

  void _validateInputs() {
    final String email = emailController.text.trim();
    setState(() {
      _isButtonEnabled = email.isNotEmpty && email.contains('@');
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InviteManager>(
      builder: (context, inviteManager, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Convide um amigo"),
          foregroundColor: AppColors.offWhite,
          backgroundColor: AppColors.orange,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const GenericPageHeader(
                  title: "",
                  subtitle:
                      "Informe o e-mail do amigo que deseja adicionar à lista.",
                ),
                const SizedBox(height: 56),
                InputField(
                  hint: "Ex: amigo@exemplo.com",
                  label: "E-mail do amigo",
                  controller: emailController,
                  moreLines: false,
                ),
                const SizedBox(height: 56),
                DefaultButton(
                  color: _isButtonEnabled
                      ? AppColors.darkGreen
                      : AppColors.mediumGray,
                  label: "Adicionar",
                  onPressed: _isButtonEnabled
                      ? () async {
                          final response = await inviteManager.inviteUser(
                            context,
                            emailController.text.trim(),
                            widget.listId,
                          );
                          if (response != null &&
                              response.statusCode >= 200 &&
                              response.statusCode < 300) {
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Erro ao convidar amigo."),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          }
                        }
                      : () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
