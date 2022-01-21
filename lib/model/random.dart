import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.arab,
    required this.translation,
  });

  String arab;
  String translation;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        arab: json["arab"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "translation": translation,
      };
}
