// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_home_system/constant.dart';
import 'package:smart_home_system/ui/screens/forgot_password.dart';
import 'package:smart_home_system/ui/screens/home_page.dart';
import 'package:smart_home_system/ui/screens/signup.dart';

import 'controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool togglePassword = true;
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/person-using-smartphone-his-automated-home.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromRGBO(56, 37, 87, 0.6),
                  BlendMode.srcOver,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Text(
                        'SMART',
                        style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      child: Text(
                        'HOME',
                        style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      child: Text(
                        'SYSTEM',
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              height: size.height * .48,
              width: size.width,
              decoration: BoxDecoration(
                // color: Color.fromRGBO(152, 85, 207, 1),
                color: Constants.headerColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      'Get connected to your devices',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.email,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(227, 212, 254, 1),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);

                            if (value.isEmpty) {
                              return "Enter Email";
                            } else if (!emailValid) {
                              return "Enter Valid Email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.password,
                          obscureText: togglePassword,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.only(left: 10),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              fontSize: 18,
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(227, 212, 254, 1),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  togglePassword = !togglePassword;
                                });
                              },
                              icon: Icon(
                                togglePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(87, 32, 156, 1),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Password must contain 8 or more characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ForgotPassword(),
                          ),
                        );
                        controller.email.clear();
                        controller.password.clear();
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromRGBO(80, 5, 177, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: controller.email.text,
                                password: controller.password.text,
                              )
                                  .then(
                                (value) {
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: const HomePage(),
                                      type: PageTransitionType.bottomToTop,
                                    ),
                                  );
                                },
                              );
                              controller.email.clear();
                              controller.password.clear();
                              Get.snackbar(
                                'Welcome Back',
                                'Connect and Control your home',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:
                                    Constants.headerColor.withOpacity(0.1),
                                colorText: Constants.headerColor,
                              );
                            } on FirebaseAuthException catch (error) {
                              Get.snackbar(
                                'Error',
                                error.message!,
                                snackPosition: SnackPosition.TOP,
                                backgroundColor:
                                    Colors.redAccent.withOpacity(0.1),
                                colorText: Colors.red,
                              );
                              controller.email.clear();
                              controller.password.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(121, 30, 238, 1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an acount? ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SignupPage(),
                                  ),
                                );
                                controller.email.clear();
                                controller.password.clear();
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Color.fromRGBO(80, 5, 177, 1),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
