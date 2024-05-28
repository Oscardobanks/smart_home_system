import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_system/repository/authentication_repository.dart';

import '../../../repository/user_repository.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();

  
  final username = TextEditingController();
  final email = TextEditingController();
  final oldpassword = TextEditingController();
  final newpassword = TextEditingController();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }

  updateData(user) {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.updateUserDetails(email, user);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }
}