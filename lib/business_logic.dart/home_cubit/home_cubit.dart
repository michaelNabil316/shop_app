import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/dio_helper.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/models/catagories_model.dart';
import 'package:shop_app/presentation/models/favourites_get_model.dart';
import 'package:shop_app/presentation/models/home_data_model.dart';
import 'package:shop_app/presentation/models/favourite_change_response.dart';
import 'package:shop_app/presentation/screens/favorites_screen.dart';
import 'package:shop_app/presentation/screens/products_screen.dart';
import 'package:shop_app/presentation/screens/setting_screen.dart';
import 'home_states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitial());
  static HomeBloc get(context) => BlocProvider.of(context);

  String apiToken = '';
  HomeModel? homemodel;
  Catagories? catagoriesModel;
  Map<int, bool> favourites = {};
  FavoritesChangeModel? favoriteChangeModel;
  FavoritesGet? favoritesGet;

  void changeToken(newToken) {
    apiToken = newToken;
    emit(HomeChangeToken());
  }

  void getHomeData(String token) {
    emit(HomeLoadingData());
    DioHelper.getData(endpoint: 'home', token: token).then((value) {
      apiToken = token;
      homemodel = HomeModel.fromjson(value.data);
      for (var product in homemodel!.data.products) {
        favourites.addAll({
          product.id: product.inFavorites,
        });
      }
      emit(HomeSuccessData());
    }).catchError((err) {
      emit(HomeError(error: err.toString()));
    });
  }

  // get the catagories to show in catagories panner
  void getCatagoriesData() {
    emit(CatagoriesLoadingData());
    DioHelper.getData(endpoint: 'categories').then((value) {
      catagoriesModel = Catagories.fromJson(value.data);
      emit(CatagoriesSuccessData());
    }).catchError((err) {
      emit(CatagoriesError(error: err.toString()));
    });
  }

  //change product favourite
  void changeFavoutire(int productId) {
    if (favourites[productId] == false) {
      favourites[productId] = true;
    } else {
      favourites[productId] = false;
    }
    emit(ChangeFav());
    DioHelper.postData(
      data: {"product_id": productId},
      path: 'favorites',
      token: apiToken,
    ).then((value) {
      favoriteChangeModel = FavoritesChangeModel.fromJson(value.data);
      getFavData();
      if (favoriteChangeModel!.status == false) {
        if (favourites[productId] == false) {
          favourites[productId] = true;
        } else {
          favourites[productId] = false;
        }
      }
      emit(ChangeFavSuccess(changeModel: favoriteChangeModel!));
    }).onError(
      (error, stackTrace) {
        if (favourites[productId] == false) {
          favourites[productId] = true;
        } else {
          favourites[productId] = false;
        }
        emit(ChangeFavError(error: error.toString()));
      },
    );
  }

  //remove favorite item from favorites manually
  void removeFav(index) {
    favoritesGet!.data!.data!.removeAt(index);
    emit(FavRemovingState());
  }

  //get favorites data
  void getFavData() async {
    await SharedPrefHelper.init();
    final newtoken = SharedPrefHelper.getData('token');
    apiToken = newtoken;
    emit(FavLoadingData());
    DioHelper.getData(endpoint: 'favorites', token: newtoken).then((value) {
      favoritesGet = FavoritesGet.fromJson(value.data);
      emit(FavSuccessData());
    }).catchError((err) {
      emit(FavErrorState(error: err.toString()));
    });
  }

  //bottom navifateories
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_rounded), label: 'Catagories'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
  ];
  List screens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];
  void changeBtmNavBar(int index) {
    currentIndex = index;
    emit(HomeChangedScreenState());
  }
}
