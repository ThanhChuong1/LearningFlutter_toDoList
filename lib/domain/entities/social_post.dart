import 'package:json_annotation/json_annotation.dart';

part 'social_post.g.dart';

@JsonSerializable()
class SocialPost {
  final int userId;
  final int id;
  final String title;
  final String body;

  SocialPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body, 
  });

  factory SocialPost.fromJson(Map<String, dynamic> json) =>
      _$SocialPostFromJson(json);

  Map<String, dynamic> toJson() => _$SocialPostToJson(this);
}
