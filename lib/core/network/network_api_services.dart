import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/browser_client.dart';
import 'package:ss_admin_dashboard/core/exceptions/app_exceptions.dart';
import 'package:ss_admin_dashboard/core/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  final BrowserClient _client = BrowserClient()..withCredentials = true;
  // Get API
  @override
  Future getApi(String url) async {
    dynamic responseJson;

    try {
      final response = await _client
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
      return responseJson;
    } on TimeoutException {
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      throw InternetException('No internet connection');
    }
  }

  // Post API
  @override
  Future postApi(String url, {dynamic data}) async {
    try {
      final response = await _client
          .post(
            Uri.parse(url),
            body: data != null ? jsonEncode(data) : null,
            headers: {"Content-Type": "application/json"},
          )
          .timeout(const Duration(seconds: 15));

      return returnResponse(response);
    } on TimeoutException {
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      throw InternetException('No internet connection');
    }
  }

  // Put API
  @override
  Future putApi(dynamic data, String url) async {
    try {
      final response = await _client
          .put(
            Uri.parse(url),
            body: jsonEncode(data),
            headers: {"Content-Type": "application/json"},
          )
          .timeout(const Duration(seconds: 10));

      dynamic responseJson = returnResponse(response);
      return responseJson;
    } on TimeoutException {
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      throw InternetException('No internet connection');
    }
  }

  // Patch API
  @override
  Future patchApi(dynamic data, String url) async {
    try {
      final response = await _client
          .patch(
            Uri.parse(url),
            body: jsonEncode(data),
            headers: {"Content-Type": "application/json"},
          )
          .timeout(const Duration(seconds: 10));

      dynamic responseJson = returnResponse(response);
      return responseJson;
    } on TimeoutException {
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      throw InternetException('No internet connection');
    }
  }

  // Delete API
  @override
  Future deleteApi(String url) async {
    try {
      final response = await _client
          .delete(Uri.parse(url), headers: {"Content-Type": "application/json"})
          .timeout(const Duration(seconds: 10));

      dynamic responseJson = returnResponse(response);
      return responseJson;
    } on TimeoutException {
      throw RequestTimeOut('Request timed out');
    } on SocketException {
      throw InternetException('No internet connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) {
          return null;
        }
        return jsonDecode(response.body);

      case 204:
        return null;

      case 400:
        throw BadRequestException(_getMessage(response));

      case 401:
        throw UnauthorizedException();

      case 403:
        throw FetchDataException(_getMessage(response));

      case 404:
        throw InvalidUrlException(_getMessage(response));

      case 500:
        throw ServerException(_getMessage(response));
      case 502:
      case 503:
        throw ServiceUnreachableException();

      default:
        throw FetchDataException(
          'Unexpected status code: ${response.statusCode}',
        );
    }
  }

  // -------------------------
  // Helper Function
  // -------------------------
  String _getMessage(http.Response response) {
    if (response.body.isEmpty) {
      return 'Request failed';
    }

    try {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return data['message']?.toString() ??
            data['error']?.toString() ??
            'Request failed';
      }

      return 'Request failed';
    } catch (_) {
      return 'Request failed';
    }
  }
}
