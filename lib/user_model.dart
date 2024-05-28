import 'package:cloud_firestore/cloud_firestore.dart';

class Devices {
  final int? id;
  final String name;
  bool isChecked;

  Devices({
    this.id,
    required this.name,
    required this.isChecked,
  });

  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json['Id'],
      name: json['Name'],
      isChecked: json['isChecked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "isChecked": isChecked,
    };
  }

  factory Devices.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Devices(
      id: data['ID'],
      name: data['Name'],
      isChecked: data['Ischecked'],
    );
  }

  static List<Devices> addDevices() {
    List<Devices> selectedDevices = deviceList;
    return selectedDevices
        .where((element) => element.isChecked == true)
        .toList();
  }
}

List<Devices> deviceList = [
  Devices(id: 1, name: 'Curtains', isChecked: false),
  Devices(id: 2, name: 'Lights', isChecked: false),
  Devices(id: 3, name: 'Air Conditioner', isChecked: false),
  Devices(id: 4, name: 'Audio System', isChecked: false),
  Devices(id: 5, name: 'TV', isChecked: false),
  Devices(id: 6, name: 'Fridge/Refrigerator', isChecked: false),
  Devices(id: 7, name: 'Heater', isChecked: false),
  Devices(id: 8, name: 'Boiler', isChecked: false),
  Devices(id: 9, name: 'Microwave', isChecked: false),
  Devices(id: 10, name: 'Washing Machine', isChecked: false),
  Devices(id: 11, name: 'Dryer', isChecked: false),
  Devices(id: 12, name: 'Showers', isChecked: false),
];

class UserModel {
  final String? id;
  final String userName;
  final String email;
  final String password;
  final String photoUrl;

  UserModel({
    this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.photoUrl,
  });

  toJson() {
    return {
      'Id': id,
      'UserName': userName,
      'Email': email,
      'Password': password,
      'PhotoUrl': photoUrl,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      userName: data['UserName'],
      email: data['Email'],
      password: data['Password'],
      photoUrl: data['PhotoUrl'],
    );
  }
}
