import 'package:flutter/material.dart';
import 'package:smart_home_system/constant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_home_system/ui/screens/home_page.dart';

class KitchenPage extends StatefulWidget {
  const KitchenPage({super.key});

  @override
  State<KitchenPage> createState() => _KitchenPageState();
}

class _KitchenPageState extends State<KitchenPage> {
  List<Image> deviceImage = [
    Image.asset(
      'assets/icons/icons8-light-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-fridge-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-microwave-100.png',
      width: 50,
    ),
    Image.asset(
      'assets/icons/icons8-boiler-100.png',
      width: 50,
    ),
  ];

  List<String> devices = [
    'Lights',
    'Fridge/Refrigerator',
    'Microwave',
    'Boiler',
  ];

  List<bool> status = [
    false,
    false,
    false,
    false,
  ];

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
        title: const Text('Bedroom'),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/icons/icons8-kitchen-96.png',
                                    width: 75,
                                  ),
                                  const Text(
                                    '4 devices',
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
                                          '4',
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
                                        for (int i = 0; i < 4; i++) {
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
                childCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}