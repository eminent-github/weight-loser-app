import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weight_loss_app/common/api_urls.dart';

class ApiService {
  static const String baseUrl = ApiUrls.baseUrl;
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
  };
  final Map<String, String> _defaultFormDataHeaders = {
    'Accept': 'multipart/form-data',
  };
  Future<http.Response> get(String endpoint, {String? authToken}) async {
    final headers = _mergeHeaders(authToken: authToken);
    log(authToken!);
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
    return response;
  }

  Future<http.Response> post(String endpoint, dynamic data,
      {String? authToken}) async {
    final headers = _mergeHeaders(authToken: authToken);
    log("from api service class -----------$headers,and data is $data");
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: data,
    );
    return response;
  }

  Future<http.Response> postWithoutBody(String endpoint,
      {String? authToken}) async {
    final headers = _mergeHeaders(authToken: authToken);

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> formDataPost(String endpoint, dynamic data,
      {String? authToken}) async {
    final headers = _mergeFormDataHeaders(authToken: authToken);
    log("from api service class -----------$headers,and data is $data");
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: data,
    );
    return response;
  }

  Future<http.Response> formDataPatch(String endpoint, dynamic data,
      {String? authToken}) async {
    final headers = _mergeFormDataHeaders(authToken: authToken);
    log("from api service class -----------$headers,and data is $data");
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: data,
    );
    return response;
  }

  Future<http.Response> patch(String endpoint, dynamic data,
      {String? authToken}) async {
    final headers = _mergeHeaders(authToken: authToken);
    log("from api service class -----------$headers,and data is $data");
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: data,
    );
    return response;
  }

  Future<http.Response> put(String endpoint, dynamic data,
      {String? authToken}) async {
    final headers = _mergeHeaders(authToken: authToken);
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: data,
    );
    return response;
  }

  Future<http.Response> delete(String endpoint, {String? authToken}) async {
    final headers = _mergeHeaders(authToken: authToken);
    // print(headers);
    final response =
        await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
    return response;
  }

  Map<String, String> _mergeHeaders({String? authToken}) {
    final mergedHeaders = {..._defaultHeaders};
    if (authToken != null) {
      mergedHeaders['Authorization'] = 'Bearer $authToken';
    }
    return mergedHeaders;
  }

  Map<String, String> _mergeFormDataHeaders({String? authToken}) {
    final mergedHeaders = {..._defaultFormDataHeaders};
    if (authToken != null) {
      mergedHeaders['Authorization'] = 'Bearer $authToken';
    }
    return mergedHeaders;
  }
}
