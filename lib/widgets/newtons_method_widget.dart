// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

class NewtonsMethodWidget extends StatefulWidget {
  const NewtonsMethodWidget({Key? key}) : super(key: key);

  @override
  State<NewtonsMethodWidget> createState() => _NewtonsMethodWidgetState();
}

class _NewtonsMethodWidgetState extends State<NewtonsMethodWidget> {
  final TextEditingController _coefficientsController =
      TextEditingController(text: '1, -18, -83');
  final TextEditingController _exponentsController =
      TextEditingController(text: '3, 1, 0');
  final TextEditingController _calculateFromController =
      TextEditingController(text: '10');

  String? result;
  String? upper;
  String? lower;
  String? signChange;

  void calculateNewtonsMethod() {
    List<num> coefficients = _parseCoefficients(_coefficientsController.text);
    List<int> exponents = _parseExponents(_exponentsController.text);
    num calculateFrom = num.tryParse(_calculateFromController.text) ?? 0;

    final n = NewtonsMethod(coefficients, exponents);
    num root = n.calculateFrom(calculateFrom);

    setState(() {
      result = root.toString();
    });
  }

  void upperLimit() {
    List<num> coefficients = _parseCoefficients(_coefficientsController.text);
    List<int> exponents = _parseExponents(_exponentsController.text);

    final n = NewtonsMethod(coefficients, exponents);
    num upperLimit = n.upperLimit();

    setState(() {
      upper = upperLimit.toString();
    });
  }

  void lowerLimit() {
    List<num> coefficients = _parseCoefficients(_coefficientsController.text);
    List<int> exponents = _parseExponents(_exponentsController.text);

    final n = NewtonsMethod(coefficients, exponents);
    num lowerLimit = n.lowerLimit();

    setState(() {
      lower = lowerLimit.toString();
    });
  }

  void findSignChange() {
    List<num> coefficients = _parseCoefficients(_coefficientsController.text);
    List<int> exponents = _parseExponents(_exponentsController.text);

    final n = NewtonsMethod(coefficients, exponents);
    List<num> findSignChange = n.findSignChange();

    setState(() {
      signChange = findSignChange.toString();
    });
  }

  List<num> _parseCoefficients(String input) {
    List<num> coefficients = [];

    List<String> coefficientStrings = input.split(',');
    for (String coefficientString in coefficientStrings) {
      num? coefficient = num.tryParse(coefficientString.trim());
      if (coefficient != null) {
        coefficients.add(coefficient);
      }
    }

    return coefficients;
  }

  List<int> _parseExponents(String input) {
    List<int> exponents = [];

    List<String> exponentStrings = input.split(',');
    for (String exponentString in exponentStrings) {
      int? exponent = int.tryParse(exponentString.trim());
      if (exponent != null) {
        exponents.add(exponent);
      }
    }

    return exponents;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _coefficientsController,
            decoration: const InputDecoration(
                labelText: 'Coefficients (comma-separated)'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              result = null;
              upper = null;
              lower = null;
              signChange = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _exponentsController,
              decoration: const InputDecoration(
                  labelText: 'Exponents (comma-separated)'),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => setState(() {
                result = null;
                upper = null;
                lower = null;
                signChange = null;
              }),
            ),
          ),
          TextField(
            controller: _calculateFromController,
            decoration: const InputDecoration(labelText: 'Calculate From'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              result = null;
              upper = null;
              lower = null;
              signChange = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: calculateNewtonsMethod,
              child: const Text('Calculate'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: upperLimit,
                child: const Text('Upper Limit'),
              ),
              ElevatedButton(
                onPressed: lowerLimit,
                child: const Text('Lower Limit'),
              ),
              ElevatedButton(
                onPressed: findSignChange,
                child: const Text('Find Sign Change'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Text(
                  'Result: ',
                  style: result != 'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (result != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$result',
                          textStyle: result !=
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
                'Upper Limit: ',
                style: upper != 'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (upper != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$upper',
                        textStyle: upper !=
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
                  'Lower Limit: ',
                  style: lower != 'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (lower != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$lower',
                          textStyle: lower !=
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
                'Sign Change: ',
                style:
                    signChange != 'Equation must contain at least one variable'
                        ? const TextStyle(fontSize: 18)
                        : const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
              ),
              if (signChange != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$signChange',
                        textStyle: signChange !=
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
