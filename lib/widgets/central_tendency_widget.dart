// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

class CentralTendencyWidget extends StatefulWidget {
  const CentralTendencyWidget({Key? key}) : super(key: key);

  @override
  State<CentralTendencyWidget> createState() => _CentralTendencyWidgetState();
}

class _CentralTendencyWidgetState extends State<CentralTendencyWidget> {
  final TextEditingController _numbersController =
      TextEditingController(text: '8, 5, 3');
  final TextEditingController _weightsController =
      TextEditingController(text: '.25, .5, .25');
  final TextEditingController _generalizedController =
      TextEditingController(text: '2');

  String? arithmetic;
  String? geometric;
  String? harmonic;
  String? quadratic;
  String? generalized;
  String? mode;
  String? median;

  void calculateArithmetic() {
    Vector numbers = _parseNumbers(_numbersController.text);
    Vector weights = _parseNumbers(_weightsController.text);

    final c = CentralTendency(numbers);
    num result = c.arithmetic(weights: weights);

    setState(() {
      arithmetic = result.toString();
    });
  }

  void calculateGeometric() {
    Vector numbers = _parseNumbers(_numbersController.text);
    Vector weights = _parseNumbers(_weightsController.text);

    final c = CentralTendency(numbers);
    num result = c.geometric(weights: weights);

    setState(() {
      geometric = result.toString();
    });
  }

  void calculateHarmonic() {
    Vector numbers = _parseNumbers(_numbersController.text);
    Vector weights = _parseNumbers(_weightsController.text);

    final c = CentralTendency(numbers);
    num result = c.harmonic(weights: weights);

    setState(() {
      harmonic = result.toString();
    });
  }

  void calculateQuadratic() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = CentralTendency(numbers);
    num result = c.quadratic();

    setState(() {
      quadratic = result.toString();
    });
  }

  void calculateGeneralized() {
    Vector numbers = _parseNumbers(_numbersController.text);
    int generalizedValue = int.tryParse(_generalizedController.text) ?? 2;

    final c = CentralTendency(numbers);
    num result = c.generalized(generalizedValue);

    setState(() {
      generalized = result.toString();
    });
  }

  void calculateMode() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = CentralTendency(numbers);
    Set result = c.mode();

    setState(() {
      mode = result.toString();
    });
  }

  void calculateMedian() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = CentralTendency(numbers);
    num result = c.median();

    setState(() {
      median = result.toString();
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
              arithmetic = null;
              geometric = null;
              harmonic = null;
              quadratic = null;
              generalized = null;
              mode = null;
              median = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _weightsController,
              decoration: const InputDecoration(
                  labelText: 'Weights of numbers (comma-separated)'),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => setState(() {
                arithmetic = null;
                geometric = null;
                harmonic = null;
                quadratic = null;
                generalized = null;
                mode = null;
                median = null;
              }),
            ),
          ),
          TextField(
            controller: _generalizedController,
            decoration: const InputDecoration(labelText: 'Generalized'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              arithmetic = null;
              geometric = null;
              harmonic = null;
              quadratic = null;
              generalized = null;
              mode = null;
              median = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateArithmetic,
                  child: const Text('Arithmetic'),
                ),
                ElevatedButton(
                  onPressed: calculateGeometric,
                  child: const Text('Geometric'),
                ),
                ElevatedButton(
                  onPressed: calculateHarmonic,
                  child: const Text('Harmonic'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: calculateQuadratic,
                child: const Text('Quadratic'),
              ),
              ElevatedButton(
                onPressed: calculateGeneralized,
                child: const Text('Generalized'),
              ),
              ElevatedButton(
                onPressed: calculateMode,
                child: const Text('Mode'),
              ),
              ElevatedButton(
                onPressed: calculateMedian,
                child: const Text('Median'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Text(
                  'Arithmetic: ',
                  style: arithmetic !=
                          'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (arithmetic != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$arithmetic',
                          textStyle: arithmetic !=
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
                'Geometric: ',
                style:
                    geometric != 'Equation must contain at least one variable'
                        ? const TextStyle(fontSize: 18)
                        : const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
              ),
              if (geometric != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$geometric',
                        textStyle: geometric !=
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
                  'Harmonic: ',
                  style:
                      harmonic != 'Equation must contain at least one variable'
                          ? const TextStyle(fontSize: 18)
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                ),
                if (harmonic != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$harmonic',
                          textStyle: harmonic !=
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
                'Quadratic: ',
                style:
                    quadratic != 'Equation must contain at least one variable'
                        ? const TextStyle(fontSize: 18)
                        : const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
              ),
              if (quadratic != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$quadratic',
                        textStyle: quadratic !=
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
                  'Generalized: ',
                  style: generalized !=
                          'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (generalized != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$generalized',
                          textStyle: generalized !=
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
                'Mode: ',
                style: mode != 'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (mode != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$mode',
                        textStyle: mode !=
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
                  'Median: ',
                  style: median != 'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (median != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$median',
                          textStyle: median !=
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
