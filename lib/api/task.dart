import 'package:marewood_client/utils/request.dart';
import '../models/pagination.dart';


Future<PaginationData> fetchTasksPagination({ int pageNum = 1,int pageSize = 10,String ? name,String ? tags}) async {
  String endpoint = "/v1/tasks?pageNum=$pageNum&pageSize=$pageSize&name=$name&tags=$tags";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);

  // final String responseJson = await rootBundle.loadString('assets/mock/task.json');
  // var resp = Response.fromJson(jsonDecode(responseJson));
  if ( !response.status ){
    throw Exception(response.msg);
  }

  var p = PaginationData.fromJson(response.data);
  return p;
}

Future<void> updateTaskBranch(int id,String branch) async {
  String endpoint = "/v1/task/update_branch?id=${id.toString()}&branch=$branch";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return;
}