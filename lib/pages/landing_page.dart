import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Hero(
            tag: 'title',
            child: DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'Berlin',
                fontSize: 50,
                fontWeight: FontWeight.bold,
                letterSpacing: 10,
                color: Colors.black,
              ),
              child: Text(
                'MathLab',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Lottie.asset(
              'assets/lottie/mathlab.json',
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_circle_right_rounded,
                  size: 30,
                ),
                label: const Text(
                  'Enter',
                  style: TextStyle(
                    fontFamily: 'Berlin',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
