import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/dio_helper.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/models/login_model.dart';
import 'user_info_states.dart';

class UserBloc extends Cubit<UserStates> {
  UserBloc() : super(UserInitial());
  static UserBloc get(context) => BlocProvider.of(context);

  String apiToken = '';
  LoginModel? userData;

  void getUserData() async {
    await SharedPrefHelper.init();
    final newtoken = SharedPrefHelper.getData('token');
    apiToken = newtoken;
    emit(UserLoadingData());
    DioHelper.getData(endpoint: 'profile', token: newtoken).then((value) {
      // apiToken = token;
      userData = LoginModel.fromJson(value.data);
      emit(UserSuccessData());
    }).catchError((err) {
      emit(UserError(error: err.toString()));
    });
  }
}
