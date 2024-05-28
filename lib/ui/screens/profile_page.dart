import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_home_system/ui/screens/home_page.dart';
import 'package:smart_home_system/user_model.dart';

import '../../constant.dart';
import 'package:get/get.dart';

import 'controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final String currentUserId;

  const ProfilePage({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool togglePassword = true;
  final user = FirebaseAuth.instance.currentUser!;
  final controller = Get.put(ProfileController());

  XFile? imageFile;
  Future _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
      });
    }
  }

  Future _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = XFile(pickedFile!.path);
    });
  }

  Widget bottomSnackBar() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            'Choose Profile Photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _getFromCamera();
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.green,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
              ElevatedButton.icon(
                onPressed: () {
                  _getFromGallery();
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.blue,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column buildDisplayNameField(username) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Username:",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: username,
          obscureText: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
            hintText: 'Username',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your full name';
            } else if (value.length < 4) {
              return 'Too short fullname. Enter a longer name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Column buildEmailField(email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Email:",
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: email,
          obscureText: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email_outlined),
            hintText: 'Email Address',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.headerColor,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                size: 30.0,
              ));
        }),
        title: const Text(
          "Edit Profile",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {

              UserModel userData = snapshot.data as UserModel;
              final username = TextEditingController(text: userData.userName);
              final email = TextEditingController(text: userData.email);
              final oldpassword = TextEditingController(text: userData.password);
              final newpassword = TextEditingController();

              return ListView(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 20,
                          ),
                        ),
                        Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 140,
                                height: 140,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSnackBar()),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Constants.headerColor,
                                        width: 3.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: imageFile == null
                                          ? const AssetImage(
                                              'assets/images/default-profile.png')
                                          : FileImage(File(imageFile!.path))
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 220,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomSnackBar()),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Constants.headerColor,
                                    ),
                                    color:
                                        const Color.fromRGBO(132, 53, 235, 1),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDisplayNameField(username),
                              const SizedBox(
                                height: 10,
                              ),
                              buildEmailField(email),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Old Password:",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: oldpassword,
                                obscureText: obscurePassword,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  hintText: 'Old Password',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword = !obscurePassword;
                                      });
                                    },
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 8) {
                                    return 'Password must contain 8 or more characters';
                                  } else if (oldpassword.text !=
                                      userData.password) {
                                    return 'Password Mismatch';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "New Password:",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: newpassword,
                                obscureText: togglePassword,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  hintText: 'New Password',
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
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final user = UserModel(
                                    userName: username.text.trim(),
                                    email: email.text.trim(),
                                    password:
                                        newpassword.text.trim(),
                                    photoUrl: '',
                                  );
                                  ProfileController.instance
                                      .updateData(user)
                                      .then(
                                    (value) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const HomePage(),
                                            type:
                                                PageTransitionType.bottomToTop),
                                      );
                                      email.clear();
                                      oldpassword.clear();
                                      newpassword.clear();
                                      username.clear();

                                      Get.snackbar(
                                        'Success',
                                        'Your profile details have been updated.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Constants.headerColor
                                            .withOpacity(0.1),
                                        colorText: Constants.headerColor,
                                      );
                                    },
                                  );
                                } on FirebaseAuthException catch (error) {
                                  Get.snackbar(
                                    'Error',
                                    error.message!,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Colors.redAccent.withOpacity(0.1),
                                    colorText: Colors.red,
                                  );
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Constants.headerColor,
                                // Color.fromRGBO(121, 30, 238, 1),
                              ),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10,
                                ),
                              ),
                            ),
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return ListView(
                key: _formKey,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                      ),
                      Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 140,
                              height: 140,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomSnackBar()),
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      // color: Constants.headerColor
                                      //     .withOpacity(.5),
                                      width: 3.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: imageFile == null
                                        ? const AssetImage(
                                            'assets/icon/default-profile.png')
                                        : FileImage(File(imageFile!.path))
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 220,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSnackBar()),
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 3,
                                    // color: Constants.headerColor
                                    //     .withOpacity(0.5)
                                  ),
                                  color: Colors.blue,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            buildDisplayNameField(controller.email),
                            const SizedBox(
                              height: 10,
                            ),
                            buildEmailField(controller.username),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final user = UserModel(
                                  userName: controller.username.text.trim(),
                                  email: controller.email.text.trim(),
                                  password: controller.newpassword.text.trim(),
                                  photoUrl: '',
                                );
                                ProfileController.instance
                                    .updateData(user)
                                    .then(
                                  (value) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const HomePage(),
                                          type: PageTransitionType.bottomToTop),
                                    );
                                    controller.email.clear();
                                    controller.oldpassword.clear();
                                    controller.newpassword.clear();
                                    controller.username.clear();

                                    Get.snackbar(
                                      'Success',
                                      'Your profile details have been updated',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Constants.headerColor
                                          .withOpacity(0.1),
                                      colorText: Constants.headerColor,
                                    );
                                  },
                                );
                              } on FirebaseAuthException catch (error) {
                                Get.snackbar(
                                  'Error',
                                  error.message!,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.1),
                                  colorText: Colors.red,
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Constants.headerColor),
                            padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Update Profile",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Constants.headerColor,
                strokeWidth: 5,
              ),
            );
          }
        },
      ),
    );
  }
}
