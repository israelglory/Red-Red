// To parse this JSON data, do
//
//     final createUser = createUserFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

CreateUser createUserFromJson(String str) =>
    CreateUser.fromJson(json.decode(str));

String createUserToJson(CreateUser data) => json.encode(data.toJson());

class CreateUser {
  CreateUser({
    required this.name,
    required this.job,
    required this.id,
    required this.createdAt,
  });

  String name;
  String job;
  String id;
  DateTime createdAt;

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}

Future<CreateUser> createUser(String name, String job) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"name": name, "job": job}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return CreateUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
