import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class WebService {
  static final WebService _singleton = WebService._internal();
  factory WebService() => _singleton;
  WebService._internal();

  static final http.Client client = http.Client();
  static String baseUrl = "api.compraai.tech";

  static Uri _buildUri(String path) {
    return Uri.https(baseUrl, path);
  }

  static Future<http.Response> get(String path, String? token) async {
    try {
      final uri = _buildUri(path);
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      debugPrint("GET Request to: $uri");
      debugPrint("Headers: $headers");

      final response = await client.get(uri, headers: headers);
      return response;
    } catch (e) {
      debugPrint("Failed to GET $path: $e");
      rethrow;
    }
  }

  static Future<http.Response> post(String path, dynamic body,
      [String? token]) async {
    try {
      final uri = _buildUri(path);
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      debugPrint("POST Request to: $uri");
      debugPrint("Headers: $headers");
      debugPrint("Body: ${jsonEncode(body)}");

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      debugPrint("Failed to POST $path: $e");
      rethrow;
    }
  }

  static Future<http.Response> put(String path, Map<String, dynamic>? body,
      [String? token]) async {
    try {
      final uri = _buildUri(path);
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      debugPrint("PUT Request to: $uri");
      debugPrint("Headers: $headers");
      debugPrint("Body: ${jsonEncode(body)}");

      final response = await client.put(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      debugPrint("Response: ${response.body}");

      return response;
    } catch (e) {
      debugPrint("Failed to PUT $path: $e");
      rethrow;
    }
  }

static Future<http.Response> patch(String path, Map<String, dynamic>? body,
    [String? token]) async {
  try {
    final uri = _buildUri(path);
    final headers = {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };

    debugPrint("PATCH Request to: $uri");
    debugPrint("Headers: $headers");
    
    if (body != null) {
      debugPrint("Body: ${jsonEncode(body)}");
    } else {
      debugPrint("Body: null (não será enviado)");
    }
    final response = await client.patch(
      uri,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return response;
  } catch (e) {
    debugPrint("Failed to PATCH $path: $e");
    rethrow;
  }
}


  static Future<http.Response> delete(String path, [String? token]) async {
    try {
      final uri = _buildUri(path);
      final headers = {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      };

      debugPrint("DELETE Request to: $uri");
      debugPrint("Headers: $headers");

      final response = await client.delete(
        uri,
        headers: headers,
      );

      return response;
    } catch (e) {
      debugPrint("Failed to DELETE $path: $e");
      rethrow;
    }
  }
}
