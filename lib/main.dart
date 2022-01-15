import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/register_cubit/register_cubit.dart';
import 'package:shop_app/data/dio_helper.dart';
import 'package:shop_app/presentation/screens/home_screen.dart';
import 'package:shop_app/presentation/screens/login_screen.dart';
import 'business_logic.dart/home_cubit/home_cubit.dart';
import 'business_logic.dart/login_cubit/login_cubit.dart';
import 'business_logic.dart/user_info_cubit.dart/user_info_cubit.dart';
import 'data/shared_prefs.dart';
import 'presentation/screens/on_boarding.dart';
import 'presentation/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(400, 700));
  }

  DioHelper.init();
  await SharedPrefHelper.init();
  final logedBefore = SharedPrefHelper.getData('onBoarding');
  final token = SharedPrefHelper.getData('token');
  Widget widget = const OnBoarding();

  if (logedBefore != null) {
    if (token != null) {
      widget = HomePage(
        newtoken: token,
      );
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoarding();
  }

  runApp(MyApp(widget: widget, token: token ?? ''));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget widget;
  String token;
  MyApp({
    Key? key,
    required this.widget,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(
            create: (context) => HomeBloc()
              ..getHomeData(token)
              ..getCatagoriesData()
              ..getFavData()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => UserBloc()..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: customLightThemeData,
        home: widget,
      ),
    );
  }
}
