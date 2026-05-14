import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiService {
  static Map<String, String> get _authHeaders {
    return {
      ...ApiConfig.defaultHeaders,
      if (ApiConfig.authToken != null) 'Authorization': 'Bearer ${ApiConfig.authToken}',
    };
  }

  static Future<http.Response> get(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: _authHeaders,
    );
  }

  static Future<http.Response> post(String url, dynamic body) async {
    return await http.post(
      Uri.parse(url),
      headers: _authHeaders,
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> put(String url, dynamic body) async {
    return await http.put(
      Uri.parse(url),
      headers: _authHeaders,
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> delete(String url) async {
    return await http.delete(
      Uri.parse(url),
      headers: _authHeaders,
    );
  }
}
