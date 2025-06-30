import 'package:json_annotation/json_annotation.dart';

part 'social_comment.g.dart';

@JsonSerializable()
class SocialComment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  SocialComment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory SocialComment.fromJson(Map<String, dynamic> json) =>
      _$SocialCommentFromJson(json);

  Map<String, dynamic> toJson() => _$SocialCommentToJson(this);
}
