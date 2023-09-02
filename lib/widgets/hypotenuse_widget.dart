// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extended_math/extended_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class HypotenuseWidget extends StatefulWidget {
  const HypotenuseWidget({super.key});

  @override
  State<HypotenuseWidget> createState() => _HypotenuseWidgetState();
}

class _HypotenuseWidgetState extends State<HypotenuseWidget> {
  final TextEditingController _aController = TextEditingController(text: '3');
  final TextEditingController _bController = TextEditingController(text: '4');

  num? hypothenuse;

  void calculate() {
    num q = hypot(
      int.tryParse(_aController.text) ?? 0,
      int.tryParse(_bController.text) ?? 0,
    );

    hypothenuse = q;
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
            r'c^2 = a^2 + b^2',
            textStyle: const TextStyle(fontSize: 30),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Math.tex(
                r'c^2',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'=',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _aController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: '3',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => setState(() {
                  hypothenuse = null;
                }),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'^2',
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
                  hintText: '4',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => setState(() {
                  hypothenuse = null;
                }),
              ),
            ),
            Expanded(
              child: Math.tex(
                r'^2',
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
                'Values of x: ',
                style: TextStyle(fontSize: 18),
              ),
              if (hypothenuse != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$hypothenuse',
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
              child: const Text('Calculate'),
            ),
          ),
        ),
      ],
    );
  }
}
