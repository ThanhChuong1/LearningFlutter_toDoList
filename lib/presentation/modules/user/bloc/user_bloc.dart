import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoggedIn>((event, emit) {
      emit(UserLoaded(event.user));
    });

    on<UserLoggedOut>((event, emit) {
      emit(UserInitial());
    });
  }
}
