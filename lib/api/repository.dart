
import '../models/pagination.dart';
import '../utils/request.dart';

Future<PaginationData> fetchRepoPagination({ int pageNum = 1,int pageSize = 10,String name = "",String tags = "",String id = ""}) async {
  String endpoint = "/v1/repositories?pageNum=$pageNum&pageSize=$pageSize&name=$name&tags=$tags&id=$id";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }

  return PaginationData.fromJson(response.data);
}