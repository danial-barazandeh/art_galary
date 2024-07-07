import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post(
      {required this.id,
      this.userId,
      this.title,
      this.description,
      this.engine,
      this.prompt,
      this.creationTime,
      this.image});

  dynamic id;
  dynamic userId;
  dynamic title;
  dynamic description;
  dynamic engine;
  dynamic prompt;
  dynamic creationTime;
  dynamic image;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      id: json["id"].toString(),
      userId: json["userId"].toString(),
      title: json["title"].toString(),
      description: json["description"].toString(),
      engine: json["engine"].toString(),
      prompt: json["prompt"].toString(),
      creationTime: json["creationTime"].toString(),
      image: json["image"].toString());

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "engine": engine,
        "prompt": prompt,
        "creationTime": creationTime,
        "image": image
      };
}
