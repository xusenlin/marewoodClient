import 'dart:io';

import 'package:marewood_client/models/task.dart';
import 'package:marewood_client/utils/request.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pagination.dart';
import '../utils/common.dart';


Future<PaginationData> fetchTasksPagination({ int pageNum = 1,int pageSize = 10,Map<String,dynamic> ? params}) async {
  String paramsUrl = mapToUrlParams(params);
  String endpoint = "/v1/tasks?pageNum=$pageNum&pageSize=$pageSize&$paramsUrl";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  // final String responseJson = await rootBundle.loadString('assets/mock/task.json');
  // var resp = Response.fromJson(jsonDecode(responseJson));
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return PaginationData.fromJson(response.data);
}

Future<void> updateTaskBranch(int id,String branch) async {
  String endpoint = "/v1/task/update_branch?id=${id.toString()}&branch=$branch";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return;
}

Future<String> runTask(int id) async {
  String endpoint = "/v1/task/run?id=${id.toString()}";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return response.msg;
}

Future<String> downloadArchive(Task task,int type) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/${task.tag}${task.name}(${task.commitHash}).${2 == type ?"zip":"tar"}';
  String endpoint = "/v1/task/archiver?id=${task.id.toString()}&type=${type.toString()}";
  final response = await request(endpoint: endpoint, method: HttpMethod.get);
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}


Future<String> deleteTask(int id) async {
  String endpoint = "/v1/task/${id.toString()}";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.delete);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return response.msg;
}