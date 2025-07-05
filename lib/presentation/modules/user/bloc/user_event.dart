import 'package:todolist/domain/entities/social_user.dart';

abstract class UserEvent {}

class UserLoggedIn extends UserEvent {
  final SocialUser user;
  UserLoggedIn(this.user);
}

class UserLoggedOut extends UserEvent {}
