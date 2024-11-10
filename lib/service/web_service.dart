import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class WebService {
  static final WebService _singleton = WebService._internal();
  factory WebService() => _singleton;
  WebService._internal();

  static final http.Client client = http.Client();
  static String baseUrl = "192.168.8.76:3001";
  // static String baseUrl = "10.1.110.86:3001";

  static Uri _buildUri(String path) {
    return Uri.http(baseUrl, path);
  }

  static Future<http.Response> get(String path, String? token) async {
    try {
      final response = await client.get(
        _buildUri(path),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      debugPrint("Failed to GET $path: $e");
      rethrow;
    }
  }

  static Future<http.Response> post(String path, dynamic body,
      [String? token]) async {
    try {
      final response = await client.post(
        _buildUri(path),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      debugPrint("body: $body");
      return response;
    } catch (e) {
      debugPrint("Failed to POST $path: $e");
      rethrow;
    }
  }

  static Future<http.Response> put(String path, Map<String, dynamic>? body,
      [String? token]) async {
    try {
      final response = await client.put(
        _buildUri(path),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      debugPrint("Failed to PUT $path: $e");
      rethrow;
    }
  }

  static Future<http.Response> patch(String path, dynamic body,
      [String? token]) async {
    try {
      final response = await client.patch(
        _buildUri(path),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      debugPrint("Failed to PATCH $path: $e");
      rethrow;
    }
  }

  static Future<http.Response> delete(String path, [String? token]) async {
    try {
      final response = await client.delete(
        _buildUri(path),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      debugPrint("Failed to DELETE $path: $e");
      rethrow;
    }
  }
}
