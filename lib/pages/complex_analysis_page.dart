// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animations/animations.dart';
import 'package:extended_math/extended_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class ComplexAnalysisPage extends StatefulWidget {
  const ComplexAnalysisPage({super.key});

  @override
  State<ComplexAnalysisPage> createState() => _ComplexAnalysisPageState();
}

class _ComplexAnalysisPageState extends State<ComplexAnalysisPage> {
  final TextEditingController _reController = TextEditingController(text: '3');
  final TextEditingController _imController = TextEditingController(text: '5');
  List<Complex> _complexList = [
    const Complex(re: 3, im: 5),
    const Complex(re: 0, im: 5)
  ];
  final TextEditingController _powController = TextEditingController(text: '2');
  final TextEditingController _rootsOfController =
      TextEditingController(text: '3');

  void info() {
    showModal(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Take Note',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Text(
                '1. Add: Adding complex numbers is done by adding their real parts and imaginary parts separately. For example, given two complex numbers z1 = a + bi and z2 = c + di, their sum is z1 + z2 = (a + c) + (b + d)i.\n\n2. Subtract: Subtracting complex numbers is similar to addition. It involves subtracting the real parts and imaginary parts separately. For example, given two complex numbers z1 = a + bi and z2 = c + di, their difference is z1 - z2 = (a - c) + (b - d)i.\n\n3. Multiply: Multiplying complex numbers is done using the distributive property. For example, given two complex numbers z1 = a + bi and z2 = c + di, their product is z1 * z2 = (a*c - b*d) + (a*d + b*c)i.\n\n4. Divide: Dividing complex numbers involves rationalizing the denominator. For example, given two complex numbers z1 = a + bi and z2 = c + di, their division is z1 / z2 = (ac + bd) / (c^2 + d^2) + (bc - ad) / (c^2 + d^2)i.\n\n5. Modulus (Absolute Value): The modulus or absolute value of a complex number z = a + bi is calculated as |z| = sqrt(a^2 + b^2). It represents the distance of the complex number from the origin in the complex plane.\n\n6. Argument (Angle): The argument or angle of a complex number z = a + bi is calculated as arg(z) = atan(b / a), where atan is the arctangent function. It represents the angle formed by the complex number with the positive real axis in the complex plane.\n\n7. Power: Raising a complex number to a power involves multiplying it by itself multiple times. For example, raising a complex number z = a + bi to the power of n is z^n = (a + bi)^n = (a^n * cos(n * arg(z))) + (a^n * sin(n * arg(z)))i, where cos and sin are the cosine and sine functions.\n\n8. Roots Of: Finding the nth roots of a complex number involves finding the values that, when raised to the power of n, yield the given complex number. For example, finding the square roots of a complex number z involves solving the equation w^2 = z to find w1 and w2, where w1 and w2 are the square roots of z.'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _newComplex() {
    Complex c = Complex(
        re: num.tryParse(_reController.text) ?? 0,
        im: num.tryParse(_imController.text) ?? 0);
    setState(() {
      _complexList.add(c);
    });
    _reController.clear();
    _imController.clear();
  }

  void _add() {
    Complex result = _complexList[0];
    for (int i = 1; i < _complexList.length; i++) {
      result = result + _complexList[i];
    }
    setState(() {
      _complexList = [result];
    });
  }

  void _subtract() {
    Complex result = _complexList[0];
    for (int i = 1; i < _complexList.length; i++) {
      result = result - _complexList[i];
    }
    setState(() {
      _complexList = [result];
    });
  }

  void _multiply() {
    Complex result = _complexList[0];
    for (int i = 1; i < _complexList.length; i++) {
      result = result * _complexList[i];
    }
    setState(() {
      _complexList = [result];
    });
  }

  void _divide() {
    Complex result = _complexList[0];
    for (int i = 1; i < _complexList.length; i++) {
      result = result / _complexList[i];
    }
    setState(() {
      _complexList = [result];
    });
  }

  void _module() {
    Complex result = _complexList[0];
    num mod = result.module;
    setState(() {
      _complexList = [Complex(re: mod, im: 0)];
    });
  }

  void _argument() {
    Complex result = _complexList[0];
    num arg = result.argument;
    setState(() {
      _complexList = [Complex(re: arg, im: 0)];
    });
  }

  void _power() {
    Complex result = _complexList[0];
    result = result.pow(int.tryParse(_powController.text) ?? 0);
    setState(() {
      _complexList = [result];
    });
  }

  void _rootsOf() {
    Complex result = _complexList[0];
    List<Complex> roots =
        result.rootsOf(int.tryParse(_rootsOfController.text) ?? 0);
    setState(() {
      _complexList = roots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complex Analysis',
          style: TextStyle(
            fontFamily: 'Berlin',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.warning_rounded),
            onPressed: () => info(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _complexList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      '${_complexList[index]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
            const Text(
              'Please enter a complex number in the form a + bi and press the \'↑\' button to append it to the list above.',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _reController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Math.tex(
                    r'+',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _imController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Math.tex(
                  r'i',
                  textStyle: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: _newComplex,
                  icon: const Icon(Icons.arrow_upward_sharp),
                  splashRadius: 0.1,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _complexList.isNotEmpty ? _add : null,
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: _complexList.isNotEmpty ? _subtract : null,
                    child: const Text('Subtract'),
                  ),
                  ElevatedButton(
                    onPressed: _complexList.isNotEmpty ? _multiply : null,
                    child: const Text('Multiply'),
                  ),
                  ElevatedButton(
                    onPressed: _complexList.isNotEmpty ? _divide : null,
                    child: const Text('Divide'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _complexList.isNotEmpty ? _module : null,
                  child: const Text('Module'),
                ),
                ElevatedButton(
                  onPressed: _complexList.isNotEmpty ? _argument : null,
                  child: const Text('Argument'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _powController,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  ElevatedButton(
                    onPressed: _complexList.isNotEmpty ? _power : null,
                    child: const Text('Power'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _rootsOfController,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                ElevatedButton(
                  onPressed: _complexList.isNotEmpty ? _rootsOf : null,
                  child: const Text('Roots Of'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () => setState(() {
                  _complexList.clear();
                }),
                child: const Text('Clear ALL'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
