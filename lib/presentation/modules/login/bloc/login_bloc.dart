import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:todolist/data/data_source/data_repository.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final DataRepository repository;

  LoginBloc(this.repository): super(LoginInitial()){
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter emit) async{
    emit(LoginLoading());
    try{
      final user = await repository.fetchUsers();

      final matchedUser = user.firstWhere(
        (user) => user.email.toLowerCase() == event.email.toLowerCase(),
        orElse: () => throw Exception("Email not found"),
      );
      emit(LoginSuccess(matchedUser.name));
    }catch (e){
      emit(LoginFailure("Login failed: ${e.toString()}"));
    }
  }
}
