// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extended_math/extended_math.dart';
import 'package:flutter/material.dart';

class GeneralAlgebraWidget extends StatefulWidget {
  const GeneralAlgebraWidget({super.key});

  @override
  State<GeneralAlgebraWidget> createState() => _GeneralAlgebraWidgetState();
}

class _GeneralAlgebraWidgetState extends State<GeneralAlgebraWidget> {
  final TextEditingController _intController = TextEditingController(text: '6');
  Set<int>? _factors = {2};
  bool? _isPrime = false;

  void _factorize() {
    int? input = int.tryParse(_intController.text);
    _factors = Integer(input).factorizate();
    setState(() {
      _isPrime = Integer(input).isPrime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _intController,
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              _factors = null;
              _isPrime = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: _factorize,
              child: const Text('Factorize'),
            ),
          ),
          const Text(
            'Unique Prime Numbers of the above number:',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          if (_factors != null)
            Flexible(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '$_factors',
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Is Prime Number: ',
                  style: TextStyle(fontSize: 18),
                ),
                if (_isPrime != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          _isPrime! ? 'Yes' : 'No',
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
        ],
      ),
    );
  }
}
