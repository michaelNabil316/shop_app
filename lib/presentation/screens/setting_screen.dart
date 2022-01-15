import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/business_logic.dart/user_info_cubit.dart/user_info_cubit.dart';
import 'package:shop_app/business_logic.dart/user_info_cubit.dart/user_info_states.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/components/button_widget.dart';
import 'package:shop_app/presentation/components/flutter_toast.dart';
import '../style.dart';
import 'login_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    String profileImg = '';
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final loginformKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final userBloc = UserBloc.get(context);
    final myMedia = MediaQuery.of(context).size;

    return BlocConsumer<UserBloc, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (userBloc.userData != null) {
          nameController.text = userBloc.userData!.data!.name!;
          emailController.text = userBloc.userData!.data!.email!;
          phoneController.text = userBloc.userData!.data!.phone!;
          profileImg = userBloc.userData!.data!.image!;
          return Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: loginformKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(profileImg),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: nameController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: emailController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      }
                      if (!emailRegExp.hasMatch(value)) {
                        return 'email not valid ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: phoneController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your phone',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your phone';
                      }
                      return null;
                    },
                  ),
                  //update info button
                  const SizedBox(height: 20.0),
                  ButtonWidget(Colors.blue, 'update info', Colors.white, () {},
                      myMedia.height * 0.08, myMedia.width * 0.5),
                  //log out button
                  const SizedBox(height: 1.0),
                  ButtonWidget(Colors.blue, 'Log out', Colors.white, () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    SharedPrefHelper.removeData('token').then((value) {
                      if (value) {
                        showToast(fToast, 'loged out', Colors.amber);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      } else {
                        showToast(
                            fToast, 'error while logging out', Colors.red);
                      }
                    });
                  }, myMedia.height * 0.08, myMedia.width * 0.5),
                ],
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
