// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

class UniformDistributionWidget extends StatefulWidget {
  const UniformDistributionWidget({Key? key}) : super(key: key);

  @override
  State<UniformDistributionWidget> createState() =>
      _UniformDistributionWidgetState();
}

class _UniformDistributionWidgetState extends State<UniformDistributionWidget> {
  final TextEditingController _shapeParameterController =
      TextEditingController(text: '3');
  final TextEditingController _upperLimitController =
      TextEditingController(text: '45');
  final TextEditingController _lowerLimitController =
      TextEditingController(text: '-9');
  final TextEditingController _centralMomentController =
      TextEditingController(text: '3');
  final TextEditingController _momentController =
      TextEditingController(text: '3');

  String? density;
  String? cdf;
  String? centralMoment;
  String? moment;

  UniformDistribution parseNum() {
    String shapeParameterText = _shapeParameterController.text;
    String lowerLimitText = _lowerLimitController.text;
    String upperLimitText = _upperLimitController.text;

    num shapeParameter = num.tryParse(shapeParameterText) ?? 3;
    num lowerLimit = num.tryParse(lowerLimitText) ?? -9;
    num upperLimit = num.tryParse(upperLimitText) ?? 45;

    final p = UniformDistribution(shapeParameter, l: lowerLimit, u: upperLimit);

    return p;
  }

  void calculateDensity() {
    UniformDistribution p = parseNum();
    num density = p.density();

    setState(() {
      this.density = density.toString();
    });
  }

  void calculateCDF() {
    UniformDistribution p = parseNum();
    num cdf = p.cdf();

    setState(() {
      this.cdf = cdf.toString();
    });
  }

  void calculateCentralMoment() {
    UniformDistribution p = parseNum();
    num centralMoment = p.centralMoment();

    setState(() {
      this.centralMoment = centralMoment.toString();
    });
  }

  void calculateMoment() {
    UniformDistribution p = parseNum();
    num moment = p.moment();

    setState(() {
      this.moment = moment.toString();
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
            controller: _shapeParameterController,
            decoration: const InputDecoration(labelText: 'Shape Parameter'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              density = null;
              cdf = null;
              centralMoment = null;
              moment = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _upperLimitController,
              decoration: const InputDecoration(labelText: 'Upper Limit'),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => setState(() {
                density = null;
                cdf = null;
                centralMoment = null;
                moment = null;
              }),
            ),
          ),
          TextField(
            controller: _lowerLimitController,
            decoration: const InputDecoration(labelText: 'Lower Limit'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              density = null;
              cdf = null;
              centralMoment = null;
              moment = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: _centralMomentController,
              decoration:
                  const InputDecoration(labelText: 'Order of Central Moment'),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) => setState(() {
                density = null;
                cdf = null;
                centralMoment = null;
                moment = null;
              }),
            ),
          ),
          TextField(
            controller: _momentController,
            decoration: const InputDecoration(labelText: 'Order of Moment'),
            style: const TextStyle(fontSize: 18),
            onChanged: (value) => setState(() {
              density = null;
              cdf = null;
              centralMoment = null;
              moment = null;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: calculateDensity,
                  child: const Text('Density'),
                ),
                ElevatedButton(
                  onPressed: calculateCDF,
                  child: const Text('Cumulative Distribution Function'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: calculateCentralMoment,
                child: const Text('Central Moment'),
              ),
              ElevatedButton(
                onPressed: calculateMoment,
                child: const Text('Moment'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Text(
                  'Density: ',
                  style:
                      density != 'Equation must contain at least one variable'
                          ? const TextStyle(fontSize: 18)
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                ),
                if (density != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$density',
                          textStyle: density !=
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
                'Cumulative Distribution Function: ',
                style: cdf != 'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (cdf != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$cdf',
                        textStyle:
                            cdf != 'Equation must contain at least one variable'
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
                  'Central Moment: ',
                  style: centralMoment !=
                          'Equation must contain at least one variable'
                      ? const TextStyle(fontSize: 18)
                      : const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                ),
                if (centralMoment != null)
                  Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '$centralMoment',
                          textStyle: centralMoment !=
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
                'Moment: ',
                style: moment != 'Equation must contain at least one variable'
                    ? const TextStyle(fontSize: 18)
                    : const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
              ),
              if (moment != null)
                Flexible(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$moment',
                        textStyle: moment !=
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
