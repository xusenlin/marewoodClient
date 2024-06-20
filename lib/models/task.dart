
class Task {
  int id;
  String name;
  String description;
  int status;
  String branch;
  String alias; // URL access directory after successful packaging
  int runTotal;
  int repositoryId;
  String buildDir; // Packaging directory, default is 'dist'
  String buildCommand; // Packaging command, can read package.json for selection
  int createdId; // ID of the user who created the task
  bool private; // Private task, only visible to the creator
  String tag;
  String commitHash; // Commit hash at the time of packaging
  String terminalInfo;

  Task({
    required this.id,
    required this.name,
    this.description = "",
    this.status = 0,
    required this.branch,
    required this.alias,
    this.runTotal = 0,
    required this.repositoryId,
    this.buildDir = 'dist',
    required this.buildCommand,
    this.createdId = 0,
    this.private = false,
    this.tag = '',
    this.commitHash = '',
    this.terminalInfo = '',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      branch: json['branch'],
      alias: json['alias'],
      runTotal: json['runTotal'],
      repositoryId: json['repositoryId'],
      buildDir: json['buildDir'],
      buildCommand: json['buildCommand'],
      createdId: json['createdId'],
      private: json['private'],
      tag: json['tag'],
      commitHash: json['commitHash'],
      terminalInfo: json['terminalInfo'],
    );
  }
}