import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/_common/input_field.dart';
import 'package:compra/ui/new_list/components/emoji_input_field.dart';
import 'package:compra/util/colors_config.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({super.key});

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController maxSpendController = TextEditingController();
  final GlobalKey<EmojiInputFieldState> emojiFieldKey = GlobalKey();

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

  Future<void> _createList() async {
    String name = nameController.text.trim();
    String? emoji = emojiFieldKey.currentState?.selectedEmoji;
    int? maxSpend = maxSpendController.text.isNotEmpty
        ? int.tryParse(maxSpendController.text)
        : null;

    if (name.isEmpty || (emoji == null || emoji.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O nome e o emoji são obrigatórios!")),
      );
      return;
    }


    String token = Provider.of<AuthManager>(context, listen: false).accessToken;
    final response = await ListManager(context).createList(
      token: token,
      name: name,
      emoji: emoji,
      maxSpend: maxSpend,
    );

    if (response != null && response.statusCode == 201) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response?.message ?? "Erro ao criar a lista")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova lista"),
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
              label: "Criar Lista",
              onPressed: _createList,
            ),
          ],
        ),
      ),
    );
  }
}
