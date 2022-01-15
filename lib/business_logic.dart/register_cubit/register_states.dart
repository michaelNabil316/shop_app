import 'package:shop_app/presentation/models/register_user_model.dart';

abstract class RegisterStates {}

class ChangeSecureVisibilityState extends RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoadingData extends RegisterStates {}

class RegisterSuccessData extends RegisterStates {
  RegisterUser user;
  RegisterSuccessData({required this.user});
}

class RegisterChangedDataState extends RegisterStates {}

class RegisterError extends RegisterStates {
  String error;
  RegisterError({required this.error});
}
