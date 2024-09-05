class UserModel {
  final String id;
  final String email;
  final String name;
  final String avatar;
  final String? accessToken;
  final String? refreshToken;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '', 
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
