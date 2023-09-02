// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extended_math/extended_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class QuadraticEquationWidget extends StatefulWidget {
  const QuadraticEquationWidget({super.key});

  @override
  State<QuadraticEquationWidget> createState() =>
      _QuadraticEquationWidgetState();
}

class _QuadraticEquationWidgetState extends State<QuadraticEquationWidget> {
  final TextEditingController _aController = TextEditingController(text: '1');
  final TextEditingController _bController = TextEditingController(text: '2');
  final TextEditingController _cController = TextEditingController(text: '4');

  num? discriminant;
  Map<String, Complex>? valuesOfX;

  void calculate() {
    QuadraticEquation q = QuadraticEquation(
      a: num.tryParse(_aController.text) ?? 1,
      b: num.tryParse(_bController.text) ?? 0,
      c: num.tryParse(_cController.text) ?? 0,
    );

    discriminant = q.discriminant();
    valuesOfX = q.calculate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 5,
          ),
          child: Math.tex(
            r'ax^2 + bx + c = 0',
            textStyle: const TextStyle(fontSize: 30),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _aController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: '1',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => setState(() {
                  discriminant = null;
                  valuesOfX = null;
                }),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'x^2',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'+',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _bController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: '2',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => setState(() {
                  discriminant = null;
                  valuesOfX = null;
                }),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'x',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'+',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _cController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: '4',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => setState(() {
                  discriminant = null;
                  valuesOfX = null;
                }),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'= 0',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              const Text(
                'Discriminant: ',
                style: TextStyle(fontSize: 18),
              ),
              if (discriminant != null)
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '$discriminant',
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
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              const Text(
                'Values of x: ',
                style: TextStyle(fontSize: 18),
              ),
              if (valuesOfX != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$valuesOfX',
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
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () => setState(() {
                calculate();
              }),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Calculate',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
