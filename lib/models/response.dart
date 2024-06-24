
class Response{
  final dynamic data;
  final String msg;
  final bool status;
  Response({
    required this.data,
    required this.msg,
    required this.status,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      data: json['data'],
      msg: json['msg'],
      status: json['status'],
    );
  }
}
