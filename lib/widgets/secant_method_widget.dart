// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart' as em;
import 'package:math_expressions/math_expressions.dart';

class SecantMethodWidget extends StatefulWidget {
  const SecantMethodWidget({Key? key}) : super(key: key);

  @override
  State<SecantMethodWidget> createState() => _SecantMethodWidgetState();
}

class _SecantMethodWidgetState extends State<SecantMethodWidget> {
  final TextEditingController _equationController =
      TextEditingController(text: 'x ^ 3 - 18 * x - 83');
  final TextEditingController _initialGuessController =
      TextEditingController(text: '2');
  final TextEditingController _closePointController =
      TextEditingController(text: '10');
  final TextEditingController _toleranceController =
      TextEditingController(text: '0.001');

  String? result;

  void calculateSecantMethod() {
    String equation = _equationController.text.trim();
    num initialGuess = num.tryParse(_initialGuessController.text) ?? 0;
    num closePoint = num.tryParse(_closePointController.text) ?? 0;
    num tolerance = num.tryParse(_toleranceController.text) ?? 0;

    bool hasVariable = RegExp(r'[a-df-zA-DF-Z]').hasMatch(equation);
    if (!hasVariable) {
      setState(() {
        result = 'Equation must contain at least one variable';
      });
      return;
    }

    num? equationFn(num x) {
      try {
        Parser parser = Parser();
        Expression expression = parser.parse(equation);
        ContextModel contextModel = ContextModel();
        contextModel.bindVariable(Variable('x'), Number(x));
        return expression.evaluate(EvaluationType.REAL, contextModel) as num;
      } catch (e) {
        return null;
      }
    }

    final p = em.SecantMethod(equationFn, initialGuess, closePoint, tolerance);

    setState(() {
      result = p.result()?.toString() ?? 'No root found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _equationController,
            decoration: const InputDecoration(labelText: 'Equation'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              result = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _initialGuessController,
              decoration: const InputDecoration(labelText: 'Initial Guess'),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => setState(() {
                result = null;
              }),
            ),
          ),
          TextField(
            controller: _closePointController,
            decoration: const InputDecoration(labelText: 'Close Point'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              result = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _toleranceController,
              decoration: const InputDecoration(labelText: 'Tolerance'),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => setState(() {
                result = null;
              }),
            ),
          ),
          ElevatedButton(
            onPressed: calculateSecantMethod,
            child: const Text('Calculate'),
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
        ],
      ),
    );
  }
}
