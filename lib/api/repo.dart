import '../utils/request.dart';

Future<List<dynamic>> fetchRepositoryBranch(int id) async {
  String endpoint = "/v1/repository/branch/$id";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return response.data;
}

Future<void> updateRepositoryBranch(int id,String branch) async {
  String endpoint = "/v1/task/update_branch?id=${id.toString()}&branch=$branch";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return;
}
