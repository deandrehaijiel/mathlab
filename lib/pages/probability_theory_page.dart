import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ProbabilityTheoryPage extends StatefulWidget {
  const ProbabilityTheoryPage({super.key});

  @override
  State<ProbabilityTheoryPage> createState() => _ProbabilityTheoryPageState();
}

class _ProbabilityTheoryPageState extends State<ProbabilityTheoryPage> {
  void info() {
    showModal(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Take Note',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Text(
                '1. Density: In probability theory, the density function (or probability density function) represents the relative likelihood of a continuous random variable taking on a specific value within a given range. For the uniform distribution, the density function is a constant value within the support of the distribution and zero outside that range. It ensures that the total area under the density function is equal to 1, representing the probability of the variable falling within the specified range.\n\n2. Cumulative Distribution Function (CDF): The cumulative distribution function of a random variable gives the probability that the variable takes on a value less than or equal to a given value. For the uniform distribution, the CDF is a linear function that starts at 0 for values less than the lower limit of the distribution and increases linearly to 1 for values within the range of the distribution. It remains 1 for values greater than the upper limit of the distribution.\n\n3. Central Moment: In probability theory, a central moment is a statistical measure that provides information about the shape and distribution of a random variable. The central moment of order k for a continuous random variable X is defined as the expected value of (X - E[X])^k, where E[X] is the expected value (mean) of X. It quantifies the deviation of X from its mean value. For the uniform distribution, some central moments can be calculated analytically based on the range of the distribution.\n\n4. Moment: Moments are statistical measures that describe various properties of a probability distribution. The moment of order k for a continuous random variable X is defined as the expected value of X^k. Moments provide information about the shape, location, and spread of the distribution. In the context of the uniform distribution, specific moments can be calculated based on the range of the distribution.'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Probability Theory',
            style: TextStyle(
              fontFamily: 'Berlin',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.warning_rounded),
              onPressed: () => info(),
            )
          ],
        ),
        body: const UniformDistributionWidget());
  }
}
