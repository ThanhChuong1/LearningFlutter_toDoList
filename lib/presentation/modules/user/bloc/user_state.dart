import 'package:todolist/domain/entities/social_user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final SocialUser user;
  UserLoaded(this.user);
}
