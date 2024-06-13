
class SysInfo {
  final String appName;
  final String appRepository;
  final String clientDir;
  final String dbDns;
  final Map<String,dynamic> dependTools;
  final String ginMode;
  final String httpPort;
  final String repositoryDir;
  final String version;
  final String webRootDir;

  SysInfo({
    required this.appName,
    required this.appRepository,
    required this.clientDir,
    required this.dbDns,
    required this.dependTools,
    required this.ginMode,
    required this.httpPort,
    required this.repositoryDir,
    required this.version,
    required this.webRootDir,
  });

  factory SysInfo.fromJson(Map<String, dynamic> json) {
    return SysInfo(
      appName:json["appName"],
      appRepository:json["appRepository"],
      clientDir:json["clientDir"],
      dbDns:json["dbDns"],
      dependTools:json["dependTools"],
      ginMode:json["ginMode"],
      httpPort:json["httpPort"],
      repositoryDir:json["repositoryDir"],
      version:json["version"],
      webRootDir:json["webRootDir"],
    );
  }

}