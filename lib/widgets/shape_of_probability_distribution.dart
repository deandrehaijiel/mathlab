// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

class ShapeOfProbabilityDistributionWidget extends StatefulWidget {
  const ShapeOfProbabilityDistributionWidget({Key? key}) : super(key: key);

  @override
  State<ShapeOfProbabilityDistributionWidget> createState() =>
      _ShapeOfProbabilityDistributionWidgetState();
}

class _ShapeOfProbabilityDistributionWidgetState
    extends State<ShapeOfProbabilityDistributionWidget> {
  final TextEditingController _numbersController =
      TextEditingController(text: '8, 5, 3');
  final TextEditingController _momentController =
      TextEditingController(text: '2');

  String? moment;
  String? skewness;
  String? kurtosis;
  String? kurtosisExcessTrue;

  void calculateMoment() {
    Vector numbers = _parseNumbers(_numbersController.text);
    int momentValue = int.tryParse(_momentController.text) ?? 2;

    final c = ShapeOfProbabilityDistribution(numbers);
    num result = c.moment(momentValue);

    setState(() {
      moment = result.toString();
    });
  }

  void calculateSkewness() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = ShapeOfProbabilityDistribution(numbers);
    num result = c.skewness();

    setState(() {
      skewness = result.toString();
    });
  }

  void calculateKurtosis() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = ShapeOfProbabilityDistribution(numbers);
    num result = c.kurtosis();

    setState(() {
      kurtosis = result.toString();
    });
  }

  void calculateKurtosisExcessTrue() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = ShapeOfProbabilityDistribution(numbers);
    num result = c.kurtosis(excess: true);

    setState(() {
      kurtosisExcessTrue = result.toString();
    });
  }

  Vector _parseNumbers(String input) {
    List<num> numbers = [];

    List<String> numbersStrings = input.split(',');
    for (String numbersString in numbersStrings) {
      num? number = num.tryParse(numbersString.trim());
      if (number != null) {
        numbers.add(number);
      }
    }

    return Vector(numbers);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _numbersController,
            decoration: const InputDecoration(
                labelText: 'Discrete set of numbers (comma-separated)'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              moment = null;
              skewness = null;
              kurtosis = null;
              kurtosisExcessTrue = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateMoment,
                  child: const Text('Moment'),
                ),
                ElevatedButton(
                  onPressed: calculateSkewness,
                  child: const Text('Skewness'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: calculateKurtosis,
                child: const Text('Kurtosis'),
              ),
              ElevatedButton(
                onPressed: calculateKurtosisExcessTrue,
                child: const Text('Kurtosis (Excess)'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Text(
                  'Moment: ',
                  style: moment != 'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (moment != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$moment',
                          textStyle: moment !=
                                  'Equation must contain at least one variable'
                              ? const TextStyle(fontSize: 18)
                              : const TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                          speed: const Duration(milliseconds: 21),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                    ),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Skewness: ',
                style: skewness != 'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (skewness != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$skewness',
                        textStyle: skewness !=
                                'Equation must contain at least one variable'
                            ? const TextStyle(fontSize: 18)
                            : const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                        speed: const Duration(milliseconds: 21),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Text(
                  'Kurtosis: ',
                  style:
                      kurtosis != 'Equation must contain at least one variable'
                          ? const TextStyle(fontSize: 18)
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                ),
                if (kurtosis != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$kurtosis',
                          textStyle: kurtosis !=
                                  'Equation must contain at least one variable'
                              ? const TextStyle(fontSize: 18)
                              : const TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                          speed: const Duration(milliseconds: 21),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                    ),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Kurtosis (Excess): ',
                style: kurtosisExcessTrue !=
                        'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (kurtosisExcessTrue != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$kurtosisExcessTrue',
                        textStyle: kurtosisExcessTrue !=
                                'Equation must contain at least one variable'
                            ? const TextStyle(fontSize: 18)
                            : const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                        speed: const Duration(milliseconds: 21),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
