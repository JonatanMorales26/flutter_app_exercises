import 'dart:convert';

class DisplayName {
  final String text;
  final String languageCode;

  DisplayName({
    required this.text,
    required this.languageCode,
  });

  factory DisplayName.fromRawJson(String str) =>
      DisplayName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DisplayName.fromJson(Map<String, dynamic> json) => DisplayName(
        text: json["text"],
        languageCode: json["languageCode"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "languageCode": languageCode,
      };
}