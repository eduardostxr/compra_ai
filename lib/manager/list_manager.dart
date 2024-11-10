import 'package:compra/service/queries/list_service.dart';
import '../models/response_model.dart';

class ListManager {
  Future<ResponseModel?> createList({
    required String name,
    required String emoji,
    double? maxSpend,
  }) async {
    return await ListService.createList(
      name: name,
      emoji: emoji,
      maxSpend: maxSpend,
    );
  }
}
