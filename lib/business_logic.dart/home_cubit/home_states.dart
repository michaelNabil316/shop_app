import 'package:shop_app/presentation/models/favourite_change_response.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeChangeToken extends HomeStates {}

class HomeLoadingData extends HomeStates {}

class HomeSuccessData extends HomeStates {}

class HomeChangedScreenState extends HomeStates {}

class HomeError extends HomeStates {
  String error;
  HomeError({required this.error});
}

class CatagoriesLoadingData extends HomeStates {}

class CatagoriesSuccessData extends HomeStates {}

class CatagoriesError extends HomeStates {
  String error;
  CatagoriesError({required this.error});
}

//change favorite product
class ChangeFav extends HomeStates {}

class ChangeFavSuccess extends HomeStates {
  final FavoritesChangeModel changeModel;
  ChangeFavSuccess({required this.changeModel});
}

class ChangeFavError extends HomeStates {
  String error;
  ChangeFavError({required this.error});
}
//remove favorite from favorites list

class FavRemovingState extends HomeStates {}

//get favorites data
class FavLoadingData extends HomeStates {}

class FavSuccessData extends HomeStates {}

class FavErrorState extends HomeStates {
  String error;
  FavErrorState({required this.error});
}
