import 'package:marewood_client/models/sysInfo.dart';
import 'package:marewood_client/utils/request.dart';

Future<SysInfo> fetchSysInfo() async {
  String endpoint = "/v1/sys";
  final response = await sendRequest(endpoint: endpoint, method: HttpMethod.get);
  if ( !response.status ){
    throw Exception(response.msg);
  }
  return SysInfo.fromJson(response.data);
}