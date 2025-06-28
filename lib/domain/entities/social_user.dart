// domain/entities/social_user.dart
import 'package:json_annotation/json_annotation.dart';

part 'social_user.g.dart';

@JsonSerializable()
class SocialUser {
  final int id;
  final String name;
  final String username;
  final String email;

  SocialUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory SocialUser.fromJson(Map<String, dynamic> json) =>
      _$SocialUserFromJson(json);

  Map<String, dynamic> toJson() => _$SocialUserToJson(this);
}
