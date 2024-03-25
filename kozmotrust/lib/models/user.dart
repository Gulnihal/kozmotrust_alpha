import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String allergies;
  final String type;
  final String token;
  final List<dynamic> favorites;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.allergies,
    required this.type,
    required this.token,
    required this.favorites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'allergies': allergies,
      'type': type,
      'token': token,
      'favorites': favorites,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      allergies: map['allergies'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      favorites: List<Map<String, dynamic>>.from(
        map['favorites']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? allergies,
    String? type,
    String? token,
    List<dynamic>? favorites,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      allergies: allergies ?? this.allergies,
      type: type ?? this.type,
      token: token ?? this.token,
      favorites: favorites ?? this.favorites,
    );
  }
}
