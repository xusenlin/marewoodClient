import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marewood_client/stores/user.dart';

import '../models/response.dart';
import '../stores/system.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete,
}

Future<Response> sendRequest({
  required String endpoint,
  required HttpMethod method, // 使用枚举类型
  Map<String, String>? headers,
  dynamic  body,
}) async {

  var address = await SystemStore.getAddress();
  if (address == null || !address.contains("http")) {
    throw Exception("baseUrl error");
  }
  var token = await UserStore.getToken();
  headers ??= {};
  if (token != null) {
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    headers['Authorization'] = token;
  }

  var url = Uri.parse('$address$endpoint');
  http.Response response;

  switch (method) {
    case HttpMethod.post:
      response = await http.post(url, headers: headers, body: jsonEncode(body));
      break;
    case HttpMethod.get:
      response = await http.get(url, headers: headers);
      break;
    case HttpMethod.put:
      response = await http.put(url, headers: headers, body: jsonEncode(body));
      break;
    case HttpMethod.delete:
      response = await http.delete(url, headers: headers);
      break;
    default:
      throw Exception('Unsupported HTTP method: $method');
  }
  if (response.statusCode != 200) {
    throw Exception('Error: ${response.statusCode}, ${response.body}');
  }
  Utf8Decoder utf8decoder = const Utf8Decoder();
  String responseString = utf8decoder.convert(response.bodyBytes);

  var decodedResponse = jsonDecode(responseString);
  return Response.fromJson(decodedResponse);
}


Future<http.Response> request({
  required String endpoint,
  required HttpMethod method,
  Map<String, String>? headers,
  dynamic  body,
}) async {

  var address = await SystemStore.getAddress();
  if (address == null || !address.contains("http")) {
    throw Exception("baseUrl error");
  }
  var token = await UserStore.getToken();
  headers ??= {};
  if (token != null) {
    headers['Authorization'] = token;
  }

  var url = Uri.parse('$address$endpoint');
  http.Response response;

  switch (method) {
    case HttpMethod.post:
      response = await http.post(url, headers: headers, body: jsonEncode(body));
      break;
    case HttpMethod.get:
      response = await http.get(url, headers: headers);
      break;
    case HttpMethod.put:
      response = await http.put(url, headers: headers, body: jsonEncode(body));
      break;
    case HttpMethod.delete:
      response = await http.delete(url, headers: headers);
      break;
    default:
      throw Exception('Unsupported HTTP method: $method');
  }
  if (response.statusCode != 200) {
    throw Exception('Error: ${response.statusCode}, ${response.body}');
  }
  return response;
}
