// lib/models/user_profile.dart
class UserProfile {
  final String name;
  final int age;
  final String gender; // "M" / "F"
  final List<String> situations; // ["소개팅", "썸", ...]
  final List<String> styles; // ["부드러운 톤", ...]
  final String? imagePath; // 로컬 파일 경로 (nullable)

  UserProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.situations,
    required this.styles,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "gender": gender,
      "situations": situations,
      "styles": styles,
      "imagePath": imagePath,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json["name"] ?? "",
      age: json["age"] ?? 0,
      gender: json["gender"] ?? "",
      situations: (json["situations"] as List<dynamic>? ?? []).cast<String>(),
      styles: (json["styles"] as List<dynamic>? ?? []).cast<String>(),
      imagePath: json["imagePath"],
    );
  }
}
