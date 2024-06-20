import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/data/servises_auth.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../login_screen.dart/login_screen.dart';

class Register extends ConsumerStatefulWidget {
  Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  // ignore: unused_field
  late String _error;
  final _formKey1 = GlobalKey<FormState>();
  bool? isRegister;
  String? errorMessage;
  bool Showpass = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _error = 'Oops';

    super.initState();
  }

  Future<void> register() async {
    try {
      await AuthServise().signUpWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      setState(() {
        isRegister = true;
      });

      debugPrint(_passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;

        isRegister = false;
      });
      _error = e.message.toString();
    }
  }

  // final themeModelLight = ThemeData.light();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(top: 101.rh, left: 21.rw, right: 20.rw),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Flexify.go(Theme(
                              data: ThemeData.dark(), child: build(context)));
                        },
                        child: Icon(
                          Icons.dark_mode,
                          color: Colors.black,
                          size: 20.rs,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Flexify.go(Theme(
                              data: ThemeData.light(), child: build(context)));
                        },
                        child: Icon(
                          Icons.light_mode,
                          color: Colors.lightBlue,
                          size: 20.rs,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Create an account',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 24.rt,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  15.verticalSpace,
                  Text(
                    'Welcome friend, enter your details so lets\nget started in ordering a movie',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 14.rt,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  50.verticalSpace,
                  Text(
                    'Email adress',
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 12.rt,
                        fontWeight: FontWeight.w400),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Empty or Wrong Email';
                      }
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Please enter only alphabetical characters and spaces.';
                      }

                      return null;
                    },
                    text: 'Enter  Email',
                    textInputAction: TextInputAction.next,
                  ),
                  20.verticalSpace,
                  Text(
                    'Password',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 12.rt,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    obsureText: Showpass ? false : true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            !Showpass;
                          });
                        },
                        icon: Icon(Showpass
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      } else if (value.length < 6) {
                        return "Password must be longer than 6 characters";
                      }
                      return null;
                    },
                    text: 'Enter  password',
                    textInputAction: TextInputAction.next,
                  ),
                  20.verticalSpace,
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 12.rt,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    obsureText: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            !Showpass;
                          });
                        },
                        icon: Icon(Showpass
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'not a same passwords';
                      }
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      } else if (value.length < 6) {
                        return "Password must be longer than 6 characters";
                      }
                      return null;
                    },
                    text: 'Confirm password',
                    textInputAction: TextInputAction.done,
                  ),
                  84.verticalSpace,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 66.rw),
                    width: 204.rw,
                    height: 50.rh,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/google.png'),
                        Text(
                          'Sign-In with Google',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: const Color(0xFF000000),
                            fontSize: 14.rt,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: () async {
                      await register();

                      if (isRegister == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 320.rw,
                      height: 51.rh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF810CA8), Color(0xFFE5B8F4)],
                        ),
                      ),
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 14.rt,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D033B),
                        ),
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 90.rw),
                    child: InkWell(
                      onTap: () {
                        Flexify.go(LoginScreen());
                      },
                      child: const Text(
                        'Login to my account',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.rh,
                    width: 200.rw,
                    child: errorMessage != null ? Text(errorMessage!) : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}