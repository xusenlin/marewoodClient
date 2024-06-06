import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


import '../models/pagination.dart';
import '../models/response.dart';
import '../models/task.dart';





Future<PaginationData> fetchTasksPagination(int page) async {
  // final response = await http.get(Uri.parse('http://10.10.59.42:3000/hello'));
  // if ( response.statusCode!= 200){
  //   throw Exception('响应错误');
  // }
  print(page);

  final String responseJson = await rootBundle.loadString('assets/mock/task.json');
  var resp = Response.fromJson(jsonDecode(responseJson));
  // final data = await json.decode(responseJson) as Response<PaginationData<Task>>;
  if ( !resp.status ){
    throw Exception('响应数据出错');
  }
  await Future.delayed(const Duration(seconds: 2));

  var p = PaginationData.fromJson(resp.data);

  return p;
}