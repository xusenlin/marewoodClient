import '../models/pagination.dart';
import '../utils/common.dart';
import '../utils/request.dart';

Future<PaginationData> fetchUserPagination({ int pageNum = 1,int pageSize = 10,Map<String,dynamic> ? params}) async {
  String paramsUrl = mapToUrlParams(params);
  String endpoint = "/v1/users?pageNum=$pageNum&pageSize=$pageSize&$paramsUrl";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }

  return PaginationData.fromJson(response.data);
}