abstract class LoginEvent{} 

class LoginSubmitted extends LoginEvent{
  final String email;
  LoginSubmitted(this.email);
}