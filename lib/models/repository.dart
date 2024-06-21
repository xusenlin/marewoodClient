class Repository {
  int id;
  String name;
  String description;
  String url;
  String userName;
  String password;
  int status;
  int taskStatus;
  String dependTools;
  String defaultBranch;
  String terminalInfo;

  Repository({
    required this.id,
    required this.name,
    this.description = "",
    required this.url,
    this.userName ="",
    this.password ="",
    this.status = 0,
    this.taskStatus = 0,
    required this.dependTools,
    required this.defaultBranch,
    this.terminalInfo = '',
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      userName: json['userName'],
      password: json['password'],
      status: json['status'],
      taskStatus: json['taskStatus'],
      dependTools: json['dependTools'],
      defaultBranch: json['defaultBranch'],
      terminalInfo: json['terminalInfo'],
    );
  }
}