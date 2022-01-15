abstract class UserStates {}

class UserInitial extends UserStates {}

class UserLoadingData extends UserStates {}

class UserSuccessData extends UserStates {}

class UserChangedDataState extends UserStates {}

class UserError extends UserStates {
  String error;
  UserError({required this.error});
}

class UserChangeToken extends UserStates {}
