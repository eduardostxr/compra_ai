class ResponseModel {
  dynamic value;
  int statusCode;
  String message;

  ResponseModel({required this.value, required this.message, required this.statusCode});

  factory ResponseModel.fromJson(int statusCode, String message, dynamic value) =>
      ResponseModel(value: value, message: message, statusCode: statusCode);
}
