
import '../models/pagination.dart';
import '../utils/common.dart';
import '../utils/request.dart';

Future<PaginationData> fetchRepoPagination({ int pageNum = 1,int pageSize = 10,Map<String,dynamic> ? params}) async {
  String paramsUrl = mapToUrlParams(params);
  String endpoint = "/v1/repositories?pageNum=$pageNum&pageSize=$pageSize&$paramsUrl";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }

  return PaginationData.fromJson(response.data);
}


Future<List<dynamic>> fetchRepoBranch(int id) async {
  String endpoint = "/v1/repository/branch/$id";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return response.data;
}


Future<String> execGitPull(int id) async {
  String endpoint = "/v1/repository/git_pull/${id.toString()}";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  var out = response.data;
  return removeTrailingNewline(response.data);
}


Future<String> execGitCheckoutDot(int id) async {
  String endpoint = "/v1/repository/git_checkout_dot/${id.toString()}";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return removeTrailingNewline(response.data);
}

Future<String> deleteRepo(int id) async {
  String endpoint = "/v1/repository/${id.toString()}";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.delete);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return response.msg;
}