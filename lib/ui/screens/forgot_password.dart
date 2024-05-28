import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:page_transition/page_transition.dart';
import 'package:smart_home_system/constant.dart';
import 'package:smart_home_system/ui/screens/controllers/signup_controller.dart';
// ignore: unused_import
import 'package:smart_home_system/ui/screens/home_page.dart';
import 'package:smart_home_system/ui/screens/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool togglePassword = true;
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future resetPassword() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const LoginPage()
              );
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: controller.email.text.trim());
        const SnackBar(
          content: Text(
            'Email has been sent to rest password',
          ),
        );
        controller.email.clear();
      } on FirebaseAuthException catch (e) {
        SnackBar(
          content: Text('This ${e.message}'),
        );
        controller.email.clear();
      }
    }

    return Scaffold(
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              height: size.height * .5,
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
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
                            // contentPadding: EdgeInsets.only(left: 10),
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: resetPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(121, 30, 238, 1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Reset Password',
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
                              'Have an Account? ',
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
                                        const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
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
