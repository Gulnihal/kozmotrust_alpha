import 'dart:convert';

class User {
  final String token;
  final String id;
  final String username;
  final String email;
  final String password;
  final String allergies;
  final String type;
  final List<dynamic> favorites;

  User({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.allergies,
    required this.type,
    required this.favorites,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'allergies': allergies,
      'type': type,
      'favorites': favorites,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['accessToken'] ?? '',
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      allergies: map['allergies'] ?? '',
      type: map['type'] ?? '',
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
    String? token,
    String? id,
    String? name,
    String? email,
    String? password,
    String? allergies,
    String? type,
    List<dynamic>? favorites,
  }) {
    return User(
      token: token ?? this.token,
      id: id ?? this.id,
      username: username,
      email: email ?? this.email,
      password: password ?? this.password,
      allergies: allergies ?? this.allergies,
      type: type ?? this.type,
      favorites: favorites ?? this.favorites,
    );
  }
}
