import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marewood_client/models/user.dart';
import 'package:marewood_client/stores/system.dart';
import 'package:marewood_client/utils/request.dart';


import '../models/pagination.dart';
import '../models/response.dart';
import '../models/task.dart';

Future<User> fetchLoginUser(String userName,password) async {
  final resp = await sendRequest(
    endpoint: "/v1/login",
    method: HttpMethod.post,
    body: <String, String>{
      'username': userName,
      'password': password,
    }
  );

  if ( !resp.status ){
    throw Exception(resp.msg);
  }
  return User.fromJson(resp.data);
}