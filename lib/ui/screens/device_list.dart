import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_system/constant.dart';
import 'package:smart_home_system/ui/screens/controllers/device_controller.dart';
import 'package:smart_home_system/ui/screens/livingroom_page.dart';
import 'package:smart_home_system/user_model.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({super.key, required this.room});
  final String room;

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  // List<String> device = [
  //   'Curtains',
  //   'Lights',
  //   'Air Conditioner',
  //   'TV',
  //   'Audio System',
  //   'Fridge/Refrigerator',
  //   'Heater',
  //   'Boiler',
  //   'Microwave',
  //   'Washing Machine',
  //   'Dryer',
  //   'Showers',
  // ];

  final controller = Get.put(DeviceController());
  List<Devices> selectedDevices = [];
  
  // late String room;
  

  // List<bool> isCheckedList = List.filled(12, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
        centerTitle: true,
        backgroundColor: Constants.headerColor,
      ),
      body: ListView.builder(
        itemCount: deviceList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(deviceList[index].name),
            trailing: Checkbox(
              value: deviceList[index].isChecked,
              onChanged: (bool? value) {
                // setState(() {
                //   isCheckedList[index] = value!;
                // });
                setState(() {
                  deviceList[index].isChecked = value!;
                  if (value) {
                    selectedDevices.add(deviceList[index]);
                  } else {
                    selectedDevices.remove(deviceList[index]);
                  }
                });
              },
            ),
          );
        },
      ),
      //     ListView.builder(
      //   itemCount: devices.length,
      //   itemBuilder: (context, index) {
      //     return CheckboxListTile(
      //       title: Text(devices[index].name),
      //       value: devices[index].isChecked,
      //       onChanged: (bool? value) {
      //         setState(() {
      //           devices[index].isChecked = value!;
      //         });
      //       },
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.headerColor,
        onPressed: () {
          // 
          // for (int i = 0; i < isCheckedList.length; i++) {
          //   if (isCheckedList[i]) {
          //     deviceList[i].isChecked == isCheckedList[i];
          //   }
          // }
          DeviceController().createDeviceData(selectedDevices, widget.room);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LivingroomPage(),
            ),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
