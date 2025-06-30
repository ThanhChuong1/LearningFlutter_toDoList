import 'package:todolist/domain/entities/User.dart';
import 'package:todolist/domain/entities/social_user.dart';

SocialUser toSocialUser(User user) {
  return SocialUser(
    id: user.id,
    name: user.name,
    username: "user${user.id}",
    email: user.email,
  );
}
