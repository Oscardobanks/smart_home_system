import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  late UserModel user;
  late Devices device;

  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson());
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('Users').where('Email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  updateUserDetails(String email, UserModel user) async {
    QuerySnapshot querySnapshot =
        await _db.collection('Users').where('Email', isEqualTo: email).get();
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.update(user.toJson());
    }
  }

  createDevices(String email, List<Devices> devices, String room) async {
    QuerySnapshot querySnapshot =
        await _db.collection('Users').where('Email', isEqualTo: email).get();
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      final roomPage = docSnapshot.reference.collection(room).doc('Devices');
      for (var device in devices) {
        await roomPage.collection('Devices').add(device.toJson());
      }
    }
  }

  getDeviceDetails(String email, String room) async {
    final snapshot =
        await _db.collection('Users').where('Email', isEqualTo: email).get();
    for (DocumentSnapshot docSnapshot in snapshot.docs) {
      QuerySnapshot roomPage = docSnapshot.reference.collection(room).get()
          as QuerySnapshot<Object?>;
      final deviceData = roomPage.docs
          .map((e) =>
              Devices.fromSnapshot(e as DocumentSnapshot<Map<String, dynamic>>))
          .single;
      return deviceData;
    }
  }

  Future<List<Devices>> getDevices(String email, String room) async {
    QuerySnapshot querySnapshot =
        await _db.collection('Users').where('Email', isEqualTo: email).get();

    List<Devices> devices = [];

    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      QuerySnapshot roomSnapshot = await docSnapshot.reference
          .collection(room)
          .doc('Devices')
          .collection('Devices')
          .get();

      for (var deviceSnapshot in roomSnapshot.docs) {
        devices.add(Devices.fromJson(deviceSnapshot.data() as Map<String, dynamic>));
      }
    }
    return devices;
  }
}
