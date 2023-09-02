// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

class DispersionWidget extends StatefulWidget {
  const DispersionWidget({Key? key}) : super(key: key);

  @override
  State<DispersionWidget> createState() => _DispersionWidgetState();
}

class _DispersionWidgetState extends State<DispersionWidget> {
  final TextEditingController _numbersController =
      TextEditingController(text: '8, 5, 3');

  String? expectedValue;
  String? interquartileRange;
  String? standardDeviation;
  String? standardDeviationSample;
  String? variance;
  String? varianceSample;

  void calculateExpectedValue() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Dispersion(numbers);
    num result = c.expectedValue();

    setState(() {
      expectedValue = result.toString();
    });
  }

  void calculateinterquartileRange() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Dispersion(numbers);
    num result = c.iqr();

    setState(() {
      interquartileRange = result.toString();
    });
  }

  void calculatestandardDeviation() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Dispersion(numbers);
    num result = c.std();

    setState(() {
      standardDeviation = result.toString();
    });
  }

  void calculatestandardDeviationSample() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Dispersion(numbers);
    num result = c.std(type: 'sample');

    setState(() {
      standardDeviationSample = result.toString();
    });
  }

  void calculateVariance() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Dispersion(numbers);
    num result = c.variance();

    setState(() {
      variance = result.toString();
    });
  }

  void calculateVarianceSample() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Dispersion(numbers);
    num result = c.variance(type: 'sample');

    setState(() {
      varianceSample = result.toString();
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
              expectedValue = null;
              interquartileRange = null;
              standardDeviation = null;
              standardDeviationSample = null;
              variance = null;
              varianceSample = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateExpectedValue,
                  child: const Text('Expected Value'),
                ),
                ElevatedButton(
                  onPressed: calculateinterquartileRange,
                  child: const Text('Interquartile Range'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: calculatestandardDeviation,
                child: const Text('Standard Deviation'),
              ),
              ElevatedButton(
                onPressed: calculatestandardDeviationSample,
                child: const Text('Sample Standard Deviation'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateVariance,
                  child: const Text('Variance'),
                ),
                ElevatedButton(
                  onPressed: calculateVarianceSample,
                  child: const Text('Sample Variance'),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Expected Value: ',
                style: expectedValue !=
                        'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (expectedValue != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$expectedValue',
                        textStyle: expectedValue !=
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
                  'Interquartile Range: ',
                  style: interquartileRange !=
                          'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (interquartileRange != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$interquartileRange',
                          textStyle: interquartileRange !=
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
                'Standard Deviation: ',
                style: standardDeviation !=
                        'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (standardDeviation != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$standardDeviation',
                        textStyle: standardDeviation !=
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
                  'Sample Standard Deviation: ',
                  style: standardDeviationSample !=
                          'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (standardDeviationSample != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$standardDeviationSample',
                          textStyle: standardDeviationSample !=
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
                'Variance: ',
                style: variance != 'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (variance != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$variance',
                        textStyle: variance !=
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
                  'Sample Variance: ',
                  style: varianceSample !=
                          'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (varianceSample != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$varianceSample',
                          textStyle: varianceSample !=
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
        ],
      ),
    );
  }
}
