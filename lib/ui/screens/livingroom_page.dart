// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_home_system/constant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_home_system/ui/screens/device_list.dart';
import 'package:smart_home_system/ui/screens/home_page.dart';

import 'package:http/http.dart' as http;

class LivingroomPage extends StatefulWidget {
  const LivingroomPage({super.key});

  @override
  State<LivingroomPage> createState() => _LivingroomPageState();
}

class _LivingroomPageState extends State<LivingroomPage> {
  List<Image> deviceImage = [
    Image.asset(
      'assets/icons/icons8-curtains-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-light-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-air-conditioner-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-tv-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-speaker-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-heater-100.png',
      width: 50,
    ),
  ];

  List<String> devices = [
    'Curtains',
    'Lights',
    'Air Conditioner',
    'TV',
    'Audio System',
    'Heater',
  ];

  List<bool> status = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Future<void> toggleLED(bool status) async {
    final url = Uri.parse('http://127.0.0.1:5000/devices/2');

    final response = await http.post(
      url,
      body: {'status': status ? 'on' : 'off'},
    );

    if (response.statusCode == 200) {
      print('LED ${status ? 'On' : 'Off'}');
    } else {
      print('Failed to toggle LED');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Living Room'),
        centerTitle: true,
        backgroundColor: Constants.headerColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 130,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromRGBO(143, 67, 155, 0.53),
                          Color.fromRGBO(132, 47, 239, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/icons8-living-room-96.png',
                                    width: 80,
                                  ),
                                  const Text(
                                    '6 devices',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                width: 10,
                                indent: 3,
                                endIndent: 3,
                                thickness: 1,
                                color: Color.fromRGBO(185, 179, 179, 1),
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 3,
                                    ),
                                    width: 150,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Active:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '0',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    width: 150,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Inactive:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '6',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        for (int i = 0; i < 6; i++) {
                                          status[i] = false;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Turn Off All Devices',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Constants.deviceColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                deviceImage[index],
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    devices[index],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FlutterSwitch(
                              showOnOff: true,
                              activeColor:
                                  const Color.fromRGBO(224, 64, 251, 1),
                              activeTextColor: Colors.black,
                              inactiveTextColor: Colors.black,
                              value: status[index],
                              onToggle: (val) {
                                setState(() {
                                  toggleLED(val);
                                  status[index] = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
                childCount: 6,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.headerColor,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const DeviceList(room: 'LivingRoom'),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
