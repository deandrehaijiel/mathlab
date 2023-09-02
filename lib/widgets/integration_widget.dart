import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calculess/calculess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';

class IntegrationWidget extends StatefulWidget {
  const IntegrationWidget({super.key});

  @override
  State<IntegrationWidget> createState() => _IntegrationWidgetState();
}

class _IntegrationWidgetState extends State<IntegrationWidget> {
  final TextEditingController _integrationFunctionController =
      TextEditingController(text: 'x ^ 2');
  final TextEditingController _bController = TextEditingController(text: '2');
  final TextEditingController _aController = TextEditingController(text: '1');

  String? _integralResult;

  String stringPi = pi.toString();

  String? _calculateIntegral() {
    if (_integrationFunctionController.text.isEmpty ||
        _aController.text.isEmpty ||
        _bController.text.isEmpty) {
      return null;
    }

    try {
      final double lower =
          double.parse(_aController.text.replaceAll(stringPi, 'π'));
      final double upper =
          double.parse(_bController.text.replaceAll(stringPi, 'π'));
      const int numSubintervals = 100000;
      final Parser parser = Parser();
      final ContextModel context = ContextModel();
      Expression expression = parser.parse(
          _integrationFunctionController.text.replaceAll('pi', stringPi));
      function(num x) {
        context.bindVariable(Variable('x'), Number(x));
        return expression.evaluate(EvaluationType.REAL, context);
      }

      final double integral =
          Calc.integral(lower, upper, function, numSubintervals);
      return integral.toStringAsFixed(9);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Image.asset('assets/gif/integral.gif'),
        ),
        Row(
          children: [
            const Text(
              'y = ',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: TextField(
                controller: _integrationFunctionController,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                  ),
                  labelText:
                      _calculateIntegral() != null ? 'Enter function' : 'Error',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color:
                        _calculateIntegral() != null ? Colors.blue : Colors.red,
                  ),
                  hintText: 'x ^ 2',
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => setState(() {
                  _integralResult = null;
                }),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _bController,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    labelText: _calculateIntegral() != null
                        ? 'Enter upper bound'
                        : 'Error',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                    hintText: '2',
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _integralResult = null;
                  }),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _aController,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _calculateIntegral() != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    labelText: _calculateIntegral() != null
                        ? 'Enter lower bound'
                        : 'Error',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: _calculateIntegral() != null
                          ? Colors.blue
                          : Colors.red,
                    ),
                    hintText: '1',
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _integralResult = null;
                  }),
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            _integralResult = _calculateIntegral();
          }),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Calculate integral'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 120,
                child: Math.tex(
                  r'\int\limits_{a}^{b} f(x)\ dx = ',
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
              if (_integralResult != null)
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '$_integralResult',
                      textStyle: const TextStyle(fontSize: 18),
                      speed: const Duration(milliseconds: 21),
                    ),
                  ],
                  isRepeatingAnimation: false,
                  displayFullTextOnTap: true,
                )
              else
                const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
