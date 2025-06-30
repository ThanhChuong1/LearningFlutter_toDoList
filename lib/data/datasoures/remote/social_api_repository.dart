import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todolist/domain/entities/social_comment.dart';
import 'package:todolist/domain/entities/social_user.dart';

import '../../../domain/entities/social_post.dart';


part 'social_api_repository.g.dart';

@RestApi(baseUrl: "http://jsonplaceholder.typicode.com")
abstract class SocialApiRepository {
  factory SocialApiRepository(Dio dio, {String baseUrl}) = _SocialApiRepository;


  @GET("/posts")
  Future<List<SocialPost>> getPosts();

  @GET("/users")
  Future<List<SocialUser>> getUsers();

   @GET("/comments")
  Future<List<SocialComment>> getCommentsByPostId(@Query("postId") int postId);
  
}
