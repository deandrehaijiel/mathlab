// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

class QuartilesWidget extends StatefulWidget {
  const QuartilesWidget({Key? key}) : super(key: key);

  @override
  State<QuartilesWidget> createState() => _QuartilesWidgetState();
}

class _QuartilesWidgetState extends State<QuartilesWidget> {
  final TextEditingController _numbersController = TextEditingController(
      text: '7, 7, 21, 25, 31, 31, 47, 75, 87, 115, 116, 119, 119, 155, 177');
  final TextEditingController _percentileController =
      TextEditingController(text: '33');

  String? quartileAll;
  String? quartileFirst;
  String? quartileSecond;
  String? quartileThird;

  String? ordinalRank;
  String? value;

  void calculateQuartileAll() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Quartile(numbers).all;
    List<num> result = c.toList();

    setState(() {
      quartileAll = result.toString();
    });
  }

  void calculateQuartileFirst() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Quartile(numbers).first;
    num result = c;

    setState(() {
      quartileFirst = result.toString();
    });
  }

  void calculateQuartileSecond() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Quartile(numbers, method: 'two').all;
    List<num> result = c.toList();

    setState(() {
      quartileSecond = result.toString();
    });
  }

  void calculateQuartileThird() {
    Vector numbers = _parseNumbers(_numbersController.text);

    final c = Quartile(numbers, method: 'three').all;
    List<num> result = c.toList();

    setState(() {
      quartileThird = result.toString();
    });
  }

  void calculateOrdinalRank() {
    Vector numbers = _parseNumbers(_numbersController.text);
    int percentile = _parsePercentile(_percentileController.text);

    final c = Percentile(numbers, percentile);
    int result = c.ordinalRank();

    setState(() {
      ordinalRank = result.toString();
    });
  }

  void calculateValue() {
    Vector numbers = _parseNumbers(_numbersController.text);
    int percentile = _parsePercentile(_percentileController.text);

    final c = Percentile(numbers, percentile);
    num result = c.value();

    setState(() {
      value = result.toString();
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

  int _parsePercentile(String input) {
    int number = int.parse(input);

    return number;
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
            onChanged: (val) => setState(() {
              quartileAll = null;
              quartileFirst = null;
              quartileSecond = null;
              quartileThird = null;

              ordinalRank = null;
              value = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _percentileController,
              decoration: const InputDecoration(labelText: 'Percentile Value'),
              style: const TextStyle(fontSize: 18),
              onChanged: (val) => setState(() {
                quartileAll = null;
                quartileFirst = null;
                quartileSecond = null;
                quartileThird = null;

                ordinalRank = null;
                value = null;
              }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: calculateQuartileAll,
                child: const Text('All Quartile'),
              ),
              ElevatedButton(
                onPressed: calculateQuartileFirst,
                child: const Text('First Quartile'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: calculateQuartileSecond,
                  child: const Text('Second Quartile'),
                ),
                ElevatedButton(
                  onPressed: calculateQuartileThird,
                  child: const Text('Third Quartile'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: calculateOrdinalRank,
                child: const Text('Ordinal Rank'),
              ),
              ElevatedButton(
                onPressed: calculateValue,
                child: const Text('Value'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Text(
                  'All Quartile: ',
                  style:
                      quartileAll != 'Discrete set of numbers cannot be empty'
                          ? const TextStyle(fontSize: 18)
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                ),
                if (quartileAll != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$quartileAll',
                          textStyle: quartileAll !=
                                  'Discrete set of numbers cannot be empty'
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
                'First Quartile: ',
                style: quartileFirst != 'Discrete set of numbers cannot be empty'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (quartileFirst != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$quartileFirst',
                        textStyle: quartileFirst !=
                                'Discrete set of numbers cannot be empty'
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
                  'Second Quartile: ',
                  style:
                      quartileSecond != 'Discrete set of numbers cannot be empty'
                          ? const TextStyle(fontSize: 18)
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                ),
                if (quartileSecond != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$quartileSecond',
                          textStyle: quartileSecond !=
                                  'Discrete set of numbers cannot be empty'
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
                'Third Quartile: ',
                style: quartileThird != 'Discrete set of numbers cannot be empty'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (quartileThird != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$quartileThird',
                        textStyle: quartileThird !=
                                'Discrete set of numbers cannot be empty'
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
                  'Ordinal Rank: ',
                  style:
                      ordinalRank != 'Discrete set of numbers cannot be empty'
                          ? const TextStyle(fontSize: 18)
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                ),
                if (ordinalRank != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$ordinalRank',
                          textStyle: ordinalRank !=
                                  'Discrete set of numbers cannot be empty'
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
                'Value: ',
                style: value != 'Discrete set of numbers cannot be empty'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (value != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$value',
                        textStyle: value !=
                                'Discrete set of numbers cannot be empty'
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
