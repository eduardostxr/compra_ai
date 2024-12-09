import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/complete_list_model.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/ui/new_list/components/emoji_input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateListPage extends StatefulWidget {
  const UpdateListPage({super.key, required this.list});

  final CompleteListModel list;

  @override
  State<UpdateListPage> createState() => _UpdateListPageState();
}

class _UpdateListPageState extends State<UpdateListPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController maxSpendController = TextEditingController();
  final GlobalKey<EmojiInputFieldState> emojiFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.list.name;
    maxSpendController.text = widget.list.maxSpend.toString();
    Future.delayed(Duration.zero, () {
      emojiFieldKey.currentState?.updateEmoji(widget.list.emoji);
    });
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EmojiPicker(
          onEmojiSelected: (category, emoji) {
            emojiFieldKey.currentState?.updateEmoji(emoji.emoji);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ListManager, AuthManager>(
      builder: (context, listManager, authManager, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Editar lista"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              EmojiInputField(
                key: emojiFieldKey,
                hint: "Ex: Amigos 123",
                label: "Nome",
                controller: nameController,
                onEmojiPressed: _showEmojiPicker,
              ),
              const SizedBox(height: 16),
              InputField(
                hint: "Ex: 100.50",
                label: "Gasto Máximo (opcional)",
                controller: maxSpendController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              DefaultButton(
                color: AppColors.darkGreen,
                label: "Editar Lista",
                onPressed: () {
                  listManager.updateList(
                    context.read<AuthManager>().accessToken,
                    widget.list.id,
                    nameController.text,
                    emojiFieldKey.currentState?.selectedEmoji ?? '',
                    maxSpendController.text.isNotEmpty
                        ? double.tryParse(maxSpendController.text)
                        : null,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
