import 'dart:io';
import 'package:compra/manager/auth_manager.dart';
import 'package:compra/manager/list_manager.dart';
import 'package:compra/models/purchase.dart';
import 'package:compra/ui/_common/default_button.dart';
import 'package:compra/ui/purchase/purchase_page.dart';
import 'package:compra/util/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});
  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  String userName = "Usuário";
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _isImageSelected = false;
  bool _isLoading = false;
  Purchase? purchase;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedFile;
      _isImageSelected = pickedFile != null;
    });
  }

  Future<void> _sendImage(String token) async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.compraai.tech/api/receipt/upload-receipt'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    final fileStream = http.ByteStream(_image!.openRead());
    final length = await _image!.length();
    request.files.add(
      http.MultipartFile(
        'receipt',
        fileStream,
        length,
        filename: _image!.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    try {
      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        purchase = Purchase.fromJson(jsonDecode(responseBody));
        Provider.of<ListManager>(context, listen: false).setPurchase(purchase!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PurchaseItemsPage()),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthManager authProvider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.orange,
          foregroundColor: AppColors.white,
          title: const Row(
            children: [
              Text(
                "Nota Fiscal",
                textAlign: TextAlign.left,
                style: TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _image == null
                  ? const SizedBox(
                      height: 350,
                      child: Center(
                        child: Text('Nenhuma imagem selecionada.'),
                      ),
                    )
                  : SizedBox(
                      height: 350,
                      child: Image.file(
                        File(_image!.path),
                      ),
                    ),
              const SizedBox(height: 20),
              DefaultButton(
                onPressed: () => _pickImage(ImageSource.camera),
                label: 'Tirar foto',
                color: AppColors.darkGreen,
              ),
              const SizedBox(height: 20),
              DefaultButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                label: 'Selecionar da galeria',
                color: AppColors.darkGreen,
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('A lista está sendo processada...'),
                  ],
                ),
              if (!_isLoading)
                DefaultButton(
                  onPressed: _isImageSelected
                      ? () => _sendImage(authProvider.accessToken)
                      : () {},
                  label: 'Enviar Foto',
                  color: AppColors.darkGreen,
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
