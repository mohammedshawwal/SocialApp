abstract class LoginStates{

}
class LoginInitialState extends LoginStates{}

class LoginSuccess extends LoginStates{}

class LoginError extends LoginStates{
  final String error;
  LoginError(this.error);
}
