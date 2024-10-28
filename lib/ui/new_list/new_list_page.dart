import 'package:compra/ui/new_list/components/emoji_input_field.dart';
import 'package:flutter/material.dart';

class NewListPage extends StatelessWidget {
  const NewListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova lista"),
      ),
      body: const EmojiInputField(hint: "Ex: Amigos 123", label: "Nome"),
    );
  }
}
