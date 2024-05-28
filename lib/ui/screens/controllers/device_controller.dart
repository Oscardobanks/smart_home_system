import 'package:get/get.dart';
import 'package:smart_home_system/repository/authentication_repository.dart';

import '../../../repository/user_repository.dart';

class DeviceController extends GetxController{
  // static DeviceController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.getDevices(email, '');
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }

  createDeviceData(device, room) {
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.createDevices(email, device, room);
    } else {
      Get.snackbar('Error', 'Login to continue');
    }
  }
}