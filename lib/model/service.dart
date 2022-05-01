import 'dart:convert';
import 'package:http/http.dart' as http;

AddUser addUserFromJson(String str) => AddUser.fromJson(json.decode(str));

String addUserToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  AddUser({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Datum> data;
  Support support;

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        support: Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class Support {
  Support({
    required this.url,
    required this.text,
  });

  String url;
  String text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
      };
}

class UserRepository {
  final String _baseUrl = "https://reqres.in/api/users?page=2";

  Future<AddUser> getUser() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return addUserFromJson(response.body);
    } else {
      throw Exception("Failed to load User");
    }
  }
}
