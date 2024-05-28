import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_system/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_home_system/ui/screens/bathroom_page.dart';
import 'package:smart_home_system/ui/screens/bedroom_page.dart';
import 'package:smart_home_system/ui/screens/controllers/profile_controller.dart';
import 'package:smart_home_system/ui/screens/diningroom_page.dart';
import 'package:smart_home_system/ui/screens/kitchen_page.dart';
import 'package:smart_home_system/ui/screens/laundryroom_page.dart';
import 'package:smart_home_system/ui/screens/livingroom_page.dart';
import 'package:smart_home_system/ui/screens/login.dart';
import 'package:smart_home_system/ui/screens/profile_page.dart';
import 'package:smart_home_system/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Image> pageIcon = [
    Image.asset('assets/icons/icons8-living-room-96.png'),
    Image.asset('assets/icons/icons8-bedroom-96.png'),
    Image.asset(
      'assets/icons/dining-table.png',
      width: 85,
    ),
    Image.asset('assets/icons/icons8-kitchen-96.png'),
    Image.asset('assets/icons/icons8-laundry-96.png'),
    Image.asset('assets/icons/icons8-bathroom-96.png'),
  ];

  List<Widget> pageWidget = [
    const LivingroomPage(),
    const BedroomPage(),
    const DiningroomPage(),
    const KitchenPage(),
    const LaundryroomPage(),
    const BathroomPage(),
  ];

  List<String> pageName = [
    'Living room',
    'Bedroom',
    'Dining Room',
    'Kitchen',
    'Laundry Room',
    'Bathroom',
  ];

  final user = FirebaseAuth.instance.currentUser;
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        margin: const EdgeInsets.only(
          bottom: 20,
          top: 50,
        ),
        child: FutureBuilder(
            future: profileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '24°C',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    PopupMenuButton(
                                      padding: const EdgeInsets.only(
                                          bottom: 0, top: 10),
                                      iconSize: 50,
                                      icon: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/default-profile.png'),
                                      ),
                                      itemBuilder: (content) {
                                        return [
                                          const PopupMenuItem(
                                            value: 0,
                                            padding: EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                ),
                                                Text(
                                                  'Profile',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 1,
                                            padding: EdgeInsets.only(left: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.logout,
                                                ),
                                                Text(
                                                  'Logout',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                      onSelected: (value) {
                                        if (value == 0) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: const ProfilePage(
                                                currentUserId: '',
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                            ),
                                          );
                                        } else if (value == 1) {
                                          FirebaseAuth.instance.signOut().then(
                                            (value) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Hi ',
                                          style: TextStyle(
                                            fontSize: 35.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(132, 47, 239, 1),
                                          ),
                                        ),
                                        ShaderMask(
                                          shaderCallback: (bounds) =>
                                              const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(132, 47, 239, 1),
                                              Color.fromRGBO(
                                                  143, 67, 155, 0.53),
                                            ],
                                          ).createShader(bounds),
                                          child: Text(
                                            '${userData.userName},',
                                            style: const TextStyle(
                                              fontSize: 35.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      'Welcome to your smart home',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 120,
                              margin: const EdgeInsets.symmetric(vertical: 20),
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/icons8-house-96.png',
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          width: 10,
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 1,
                                          color:
                                              Color.fromRGBO(185, 179, 179, 1),
                                        ),
                                        const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'All Devices',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              '22 devices',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
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
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: pageWidget[index],
                                    type: PageTransitionType.bottomToTop,
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Constants.deviceColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: index == 2
                                            ? Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 28,
                                                  ),
                                                  pageIcon[index],
                                                  const SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    pageName[index],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  pageIcon[index],
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    pageName[index],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: 6,
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '24°C',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    PopupMenuButton(
                                      padding: const EdgeInsets.only(
                                          bottom: 0, top: 10),
                                      iconSize: 50,
                                      icon: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/default-profile.png'),
                                      ),
                                      itemBuilder: (content) {
                                        return [
                                          const PopupMenuItem(
                                            value: 0,
                                            padding: EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                ),
                                                Text(
                                                  'Profile',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 1,
                                            padding: EdgeInsets.only(left: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.logout,
                                                ),
                                                Text(
                                                  'Logout',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                      onSelected: (value) {
                                        if (value == 0) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: const ProfilePage(
                                                currentUserId: '',
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                            ),
                                          );
                                        } else if (value == 1) {
                                          FirebaseAuth.instance.signOut().then(
                                            (value) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ),
                                              );
                                            },
                                          );
                                          Get.snackbar(
                                            'Logout',
                                            'You have been successfully logged out',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                Colors.red.withOpacity(0.1),
                                            colorText: Colors.red,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Hi',
                                          style: TextStyle(
                                            fontSize: 35.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(132, 47, 239, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Welcome to your smart home',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 120,
                              margin: const EdgeInsets.symmetric(vertical: 20),
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/icons8-house-96.png',
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          width: 10,
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 1,
                                          color:
                                              Color.fromRGBO(185, 179, 179, 1),
                                        ),
                                        const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'All Devices',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              '22 devices',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
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
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: pageWidget[index],
                                    type: PageTransitionType.bottomToTop,
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Constants.deviceColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: index == 2
                                            ? Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 28,
                                                  ),
                                                  pageIcon[index],
                                                  const SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    pageName[index],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  pageIcon[index],
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    pageName[index],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: 6,
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Constants.headerColor,
                  strokeWidth: 5,
                ),
              );
            }),
      ),
    );
  }
}
