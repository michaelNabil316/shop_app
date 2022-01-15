import 'package:shop_app/presentation/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel loginmodel;
  LoginSuccessState(this.loginmodel);
}

class LoginLoadingState extends LoginStates {}

class ChangeSecureVisibilityState extends LoginStates {}

class LoginErrorState extends LoginStates {
  String error;
  LoginErrorState(this.error);
}
