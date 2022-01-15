import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/dio_helper.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/models/register_user_model.dart';
import 'register_states.dart';

class RegisterBloc extends Cubit<RegisterStates> {
  RegisterBloc() : super(RegisterInitial());
  static RegisterBloc get(context) => BlocProvider.of(context);

  bool secureVisibility = true;
  RegisterUser? user;
  void changeSecureVisibility() {
    secureVisibility = !secureVisibility;
    emit(ChangeSecureVisibilityState());
  }

//
  void registerNewUser(
      String name, String email, String password, String phone) async {
    emit(RegisterLoadingData());
    await SharedPrefHelper.init();
    DioHelper.postData(
      path: 'register',
      data: {
        'name': name.trim(),
        'email': email.trim(),
        'password': password.trim(),
        'phone': phone.trim(),
      },
    ).then((value) {
      user = RegisterUser.fromJson(value.data);
      if (user!.statues == false) {
        emit(RegisterError(error: user!.message.toString()));
      } else {
        emit(RegisterSuccessData(user: user!));
      }
    }).catchError((error) {
      emit(RegisterError(error: error.toString()));
    });
  }
}
