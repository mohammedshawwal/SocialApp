abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccess extends RegisterStates {}

class RegisterError extends RegisterStates {
  final String error;
  RegisterError(this.error);
}

class CreateUserSuccess extends RegisterStates {}

class CreateUserError extends RegisterStates {
  final String error;
  CreateUserError(this.error);
}

