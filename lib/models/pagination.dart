
class PaginationData {
  final List<dynamic> list;
  final int total;
  final int pageNum;
  final int pageSize;
  final int totalPage;

  PaginationData({
    required this.list,
    required this.total,
    required this.pageNum,
    required this.pageSize,
    required this.totalPage,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      list: json['list'],
      total: json['total'],
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      totalPage: json['totalPage'],
    );
  }
}