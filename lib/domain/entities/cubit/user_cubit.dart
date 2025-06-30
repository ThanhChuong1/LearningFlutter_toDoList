import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/domain/entities/social_user.dart';

class UserCubit extends Cubit<SocialUser?> {
  UserCubit() : super(null);

  void setUser(SocialUser user) => emit(user);

  void clearUser() => emit(null);
}
