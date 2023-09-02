import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:math_expressions/math_expressions.dart';

class DifferentiationWidget extends StatefulWidget {
  const DifferentiationWidget({super.key});

  @override
  State<DifferentiationWidget> createState() => _DifferentiationWidgetState();
}

class _DifferentiationWidgetState extends State<DifferentiationWidget> {
  final TextEditingController _differentiationFunctionController =
      TextEditingController(text: 'x ^ 2');
  final TextEditingController _valueOfXController =
      TextEditingController(text: '2');
  final ScrollController _scrollController = ScrollController();

  String? _derivativeResult;
  double? _solvedValueOfX;

  String stringPi = pi.toString();

  String? _calculateDerivative() {
    String? function =
        _differentiationFunctionController.text.replaceAll('pi', stringPi);
    if (function.isEmpty) {
      return null;
    }
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(function);
      Expression derivative = exp.derive('x').simplify();
      //print(derivative);
      return derivative.toString().replaceAll(stringPi, 'π');
    } catch (e) {
      return null;
    }
  }

  double? _solveForX() {
    String? derivative = _calculateDerivative();
    String? valueOfX = _valueOfXController.text.replaceAll('pi', stringPi);
    if (derivative == null || derivative.isEmpty || valueOfX.isEmpty) {
      return null;
    }
    try {
      Parser parser = Parser();
      ContextModel contextModel = ContextModel();
      contextModel.bindVariable(Variable('x'), Number(double.parse(valueOfX)));
      Expression exp = parser.parse(derivative.replaceAll('π', stringPi));
      double result = exp.evaluate(EvaluationType.REAL, contextModel);
      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadingEdgeScrollView.fromSingleChildScrollView(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 52),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/gif/derivative.gif'),
              ),
              Row(
                children: [
                  const Text(
                    'y = ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _differentiationFunctionController,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _calculateDerivative() != null
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _calculateDerivative() != null
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _calculateDerivative() != null
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _calculateDerivative() != null
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _calculateDerivative() != null
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _calculateDerivative() != null
                                ? Colors.blue
                                : Colors.red,
                          ),
                        ),
                        labelText: _calculateDerivative() != null
                            ? 'Enter function'
                            : 'Error',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: _calculateDerivative() != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                        hintText: 'x ^ 2',
                        hintStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) => setState(() {
                        _derivativeResult = null;
                      }),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _derivativeResult = _calculateDerivative();
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Calculate derivative'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Math.tex(
                        r'\frac{d}{dx}\ f(x) = ',
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                    if (_derivativeResult != null)
                      Flexible(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '$_derivativeResult',
                              textStyle: const TextStyle(fontSize: 18),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    const Text(
                      'x = ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _valueOfXController,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _solveForX() != null
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _solveForX() != null
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _solveForX() != null
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _solveForX() != null
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _solveForX() != null
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _solveForX() != null
                                  ? Colors.blue
                                  : Colors.red,
                            ),
                          ),
                          labelText: _solveForX() != null ? null : 'Error',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color:
                                _solveForX() != null ? Colors.blue : Colors.red,
                          ),
                          hintText: '2',
                          hintStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (value) => setState(() {
                          _solvedValueOfX = null;
                        }),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _solvedValueOfX = _solveForX();
                  }),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Solve for x'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Math.tex(
                        r'\frac{d}{dx}\ f(x) = ',
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                    if (_solvedValueOfX != null && _derivativeResult != null)
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '$_solvedValueOfX',
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
          ),
        ),
      ),
    );
  }
}
