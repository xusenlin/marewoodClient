
class User {
  final int id;
  final int role;
  final int status;
  final String token;
  final String username;

  User({
    required this.id,
    required this.role,
    required this.status,
    required this.token,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json['role'],
      status: json['status'],
      token: json['token'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'status': status,
      'token': token,
      'username': username,
    };
  }
}



class UseUser {
  final int id;
  final int role;
  final int status;
  final String updatedAt;
  final String username;

  UseUser({
    required this.id,
    required this.role,
    required this.status,
    required this.updatedAt,
    required this.username,
  });

  factory UseUser.fromJson(Map<String, dynamic> json) {
    return UseUser(
      id: json['id'],
      role: json['role'],
      status: json['status'],
      updatedAt: json['updatedAt'],
      username: json['username'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'status': status,
      'username': username,
    };
  }
}