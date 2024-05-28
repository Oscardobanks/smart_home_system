import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_system/constant.dart';
import 'dart:math' as math;
import 'login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 150),
            painter: CurvePainter(),
          ),
          Positioned(
            top: 120,
            left: 50,
            right: 50,
            child: Column(
              children: [
                Image.asset('assets/images/smart-home-2769215_1280.png'),
                const SizedBox(
                  height: 25,
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color.fromRGBO(121, 30, 238, 1),
                      Color.fromRGBO(143, 67, 155, 0.5),
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'SMART HOME',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    'Unlock the potential of your home with our intuitive smart home app.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => const LoginPage(),
                      transition: Transition.circularReveal,
                      duration: const Duration(seconds: 3),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 169, 52, 211),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          const RotatedBox(
            quarterTurns: 2,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: WaveAnimation(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Constants.headerColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.4,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.8, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0, end: math.pi).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return ClipPath(
          clipper: BottomWaveClipper(_animation.value),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Constants.headerColor,
                  const Color.fromARGB(255, 142, 61, 156),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  final double angle;

  BottomWaveClipper(this.angle);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    for (var i = 0; i < size.width.toInt(); i++) {
      final x = i.toDouble();
      final y = math.sin(angle + i / size.width * math.pi * 2) * 15 +
          size.height -
          20;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(BottomWaveClipper oldClipper) => angle != oldClipper.angle;
}
