import 'dart:convert';

class Blog {
  final String title;
  final String image;
  final String body;
  Blog({
    required this.title,
    required this.image,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'body': body,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) => Blog.fromMap(json.decode(source));
}
