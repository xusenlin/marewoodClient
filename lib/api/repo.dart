import '../utils/request.dart';

Future<List<dynamic>> fetchRepositoryBranch(int id) async {
  String endpoint = "/v1/repository/branch/$id";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return response.data;
}


