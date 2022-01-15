import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/dio_helper.dart';
import 'package:shop_app/presentation/models/login_model.dart';
import 'login_states.dart';

class LoginBloc extends Cubit<LoginStates> {
  LoginBloc() : super(LoginInitialState());
  static LoginBloc get(context) => BlocProvider.of(context);

  LoginModel loginmodel = LoginModel.fromJson(
      {'message': 'empty', 'data': null, 'status': 'false'});
  bool secureVisibility = true;
  String loginToken = '';

  void changeSecureVisibility() {
    secureVisibility = !secureVisibility;
    emit(ChangeSecureVisibilityState());
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        path: 'login',
        data: {'email': email, 'password': password}).then((value) {
      loginmodel = LoginModel.fromJson(value.data);
      loginToken = loginmodel.data!.token ?? '';
      emit(LoginSuccessState(loginmodel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
