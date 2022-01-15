import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/business_logic.dart/login_cubit/login_cubit.dart';
import 'package:shop_app/business_logic.dart/login_cubit/login_states.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/components/button_widget.dart';
import 'package:shop_app/presentation/components/flutter_toast.dart';
import '../style.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String imageName = 'assets/images/logo.png';
  var emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final loginformKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final myMedia = MediaQuery.of(context).size;
    final loginbloc = LoginBloc.get(context);

    //gender no used yet
    return BlocConsumer<LoginBloc, LoginStates>(listener: (context, state) {
      if (state is LoginSuccessState) {
        //if the status is true and login successfuly
        if (state.loginmodel.status) {
          showToast(fToast, '${state.loginmodel.message}', Colors.green);
          SharedPrefHelper.saveData(
                  key: 'token', value: state.loginmodel.data!.token)
              .then((v) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage(newtoken: state.loginmodel.data!.token!)),
                (route) => false);
          });
          //if the status is false and error in login
        } else {
          showToast(fToast, '${state.loginmodel.message}', Colors.red);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Sign in'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: loginformKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(imageName),
                    ),
                  ),
                  const SizedBox(height: 50.0),
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
                  const SizedBox(height: 10.0),
                  BlocBuilder<LoginBloc, LoginStates>(
                      builder: (context, state) {
                    return TextFormField(
                      controller: passController,
                      obscureText: loginbloc.secureVisibility,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () => loginbloc.changeSecureVisibility(),
                          icon: Icon(
                            loginbloc.secureVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                        if (value.length < 6) {
                          return 'password can\'t be less than 6 digit';
                        }
                        return null;
                      },
                      onFieldSubmitted: (v) {
                        if (loginformKey.currentState!.validate()) {
                          loginbloc.userLogin(
                              email: emailController.text,
                              password: passController.text);
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 24.0),
                  (state is LoginLoadingState)
                      ? const Center(child: CircularProgressIndicator())
                      : ButtonWidget(Colors.blue, 'Log In', Colors.white, () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (loginformKey.currentState!.validate()) {
                            loginbloc.userLogin(
                                email: emailController.text,
                                password: passController.text);
                          }
                        }, myMedia.height * 0.08, myMedia.width * 0.5),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have am account? '),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text('Register now'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
