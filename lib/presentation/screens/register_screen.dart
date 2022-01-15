import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/business_logic.dart/register_cubit/register_cubit.dart';
import 'package:shop_app/business_logic.dart/register_cubit/register_states.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/components/button_widget.dart';
import 'package:shop_app/presentation/components/flutter_toast.dart';
import '../style.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String imageName = 'assets/images/register.png';
  var emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final loginformKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
    final registerbloc = RegisterBloc.get(context);
    return BlocConsumer<RegisterBloc, RegisterStates>(
        listener: (context, state) {
      if (state is RegisterError) {
        showToast(fToast, state.error, Colors.amber);
      }
      if (state is RegisterSuccessData) {
        showToast(fToast, 'welcome ${state.user.data!.name}', Colors.green);
        SharedPrefHelper.saveData(key: 'token', value: state.user.data!.token)
            .then((v) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(newtoken: state.user.data!.token!)),
              (route) => false);
        });
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Rigistering'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: loginformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    Image(
                      image: AssetImage(imageName),
                      height: myMedia.height * 0.25,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 50.0),
                    TextFormField(
                      controller: nameController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'full name',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z/" "]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your name';
                        }
                        if (value.length < 3) {
                          return 'name too short ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: emailController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'email',
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
                    TextFormField(
                      controller: phoneController,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'phone',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your phone';
                        }
                        if (value.length < 11) {
                          return 'phone must be less 11 numbers';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: passController,
                      obscureText: registerbloc.secureVisibility,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'password',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              registerbloc.changeSecureVisibility(),
                          icon: Icon(
                            registerbloc.secureVisibility
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
                    ),
                    const SizedBox(height: 24.0),
                    (state is RegisterLoadingData)
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonWidget(Colors.blue, 'Sing up', Colors.white,
                            () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (loginformKey.currentState!.validate()) {
                              registerbloc.registerNewUser(
                                  nameController.text,
                                  emailController.text,
                                  passController.text,
                                  phoneController.text);
                            }
                          }, myMedia.height * 0.08, myMedia.width * 0.5),
                    // BlocBuilder<RegisterBloc, RegisterStates>(
                    //     builder: (context, state) {
                    //
                    //   return Column(
                    //     children: [

                    //     ],
                    //   );
                    // }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
