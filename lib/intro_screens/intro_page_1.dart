import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({super.key});

  @override
  _IntroPage1State createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Use CurvedAnimation for easing
    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(curvedAnimation);
    _opacityAnimation = Tween<double>(begin: 0.50, end: 1.0).animate(curvedAnimation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 400.0),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Text(
                      "BlinkList",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(
              "Turning To-Dos into Ta-Das!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Lottie.network(
            'https://lottie.host/0f3304ea-5393-479e-b920-af3967db1363/hsgcmkLP29.json', // Replace with the path to your Lottie animation
            height: 120, // Adjust the height as needed
            width: 120, // Adjust the width as needed
          ),
        ],
      ),
    );
  }
}
