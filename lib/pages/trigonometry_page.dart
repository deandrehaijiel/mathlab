import 'dart:math';

import 'package:animations/animations.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:fraction/fraction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/widgets.dart';

class TrigonometryPage extends StatefulWidget {
  const TrigonometryPage({super.key});

  @override
  State<TrigonometryPage> createState() => _TrigonometryPageState();
}

class _TrigonometryPageState extends State<TrigonometryPage> {
  double _amplitude = 10;
  double _frequency = 1;
  double _phase = 0.0;
  double _a = 1;
  double _b = 1;
  int _selectedTabIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadSelectedTabIndex();
  }

  final List<String> _title = [
    'Sine Wave',
    'Cosine Wave',
    'Exponential',
    'Natural Logarithm',
    'Graphing Calculator'
  ];

  final List<String> _formula = [
    r'y = \sin(2\pi ft + \theta)',
    r'y = \cos(2\pi ft + \theta)',
    r'y = a e^{bx}',
    r'y = a \ln(bx)',
  ];

  final List<Text> _information = const [
    Text(
        'A sine wave is like a pattern that goes up and down smoothly, just like the ball going up and down. We use this pattern a lot in math and science to help us understand things like triangles, circles, and vectors.\n\nIn a triangle, if you know one of the angles and how long one of the sides is, you can use the sine wave to figure out how long the other sides are. This is really helpful when you need to build things, like a treehouse or a bridge.\n\nIn a circle, if you want to figure out where a point on the circle is, you can use the sine wave to help you! This is like magic because you can figure out where something is without even measuring it!\n\nIn vectors, which are like arrows that show you which way something is going, you can use the sine wave to figure out how fast it\'s going in different directions. This is helpful when you need to know how to aim a ball or a toy airplane.\n\nAnd did you know that sine waves are also used in our daily lives? They are used in things like music and sound waves, which help us hear different sounds. They are also used in light waves, which help us see different colors.\n\nSo, that\'s what a sine wave is! It\'s a cool pattern that goes up and down smoothly, and we use it in lots of different ways to help us understand things in math and science, and even in our daily lives!'),
    Text(
        'A cosine wave is a special kind of pattern that goes up and down smoothly. It\'s also really useful in math and science, just like the sine wave!\n\nIn a triangle, you can use the cosine wave to figure out how long the sides are, just like the sine wave. But the cosine wave is especially helpful when you know one of the angles and you want to figure out how long the side next to that angle is.\n\nIn a circle, the cosine wave helps us figure out where a point on the circle is, just like the sine wave. But the cosine wave is especially helpful when you want to know the x-coordinate of the point on the circle. That\'s because the cosine wave gives us information about how far to the left or right the point is from the center of the circle.\n\nIn vectors, the cosine wave helps us figure out how fast something is going in different directions, just like the sine wave. But the cosine wave is especially helpful when we need to know how much of the speed is going to the left or right.\n\nLike the sine wave, the cosine wave is also used in our daily lives! It\'s used in things like music and sound waves, which help us hear different sounds. It\'s also used in light waves, which help us see different colors.'),
    Text(
        'Exponential is a big word that means when something gets bigger and bigger very quickly. Think about how when you blow up a balloon, it gets bigger and bigger very quickly until it pops. That\'s like exponential growth!\n\nNow, "natural exponential" is a type of exponential that has a special number called "e". "e" is like a superpower number that helps us understand how things grow and change over time. We use "e" a lot in math and science because it helps us describe things like waves, sound, and electricity.\n\nIn circles and vectors, we use "e" to help us understand how things spin and turn. We can use "e" to describe the way something moves around in a circle, or the way an object changes direction in space.\n\nIn math and science, we use "e" to help us solve problems and understand how things change over time. For example, we can use "e" to describe the way a population of animals grows over time, or the way a chemical reaction happens in a test tube.\n\nIn our daily lives, we might not use "e" directly, but we use things that rely on "e". For example, our phones and computers use "e" to transmit information through the internet. We also use "e" indirectly when we listen to music, because sound waves are described using "e".'),
    Text(
      'Imagine you have a toy car that moves really fast. You want to know how far it goes after each second. At first, it moves a short distance, like 1 meter. Then after one second, it moves a little farther, like 2 meters. After another second, it moves even farther, like 4 meters. And after another second, it moves even farther, like 8 meters.\n\nThe natural logarithm is like a special tool that helps us figure out how much time it takes for the toy car to move a certain distance. It tells us how many times we need to multiply a certain number, like 1 or 2 or 4, by itself to get the distance the car moved.\n\nIn math and science, we use the natural logarithm to help us solve problems that involve things changing over time. For example, we can use it to understand how long it takes for a medicine to leave our body, or how fast a rocket travels through space. It also helps us understand how things like light and sound waves change as they move through the air or water.\n\nIn our daily lives, we may not use the natural logarithm directly, but it\'s used in many areas that affect us. For example, in finance, it\'s used to calculate compound interest on loans and investments. In computer science, it\'s used in algorithms and data analysis. It\'s also used in fields like physics, biology, and engineering to model and understand various natural phenomena and processes.',
    ),
    Text(
      '1. Use only the variable "x" in the equation. Other variables are not supported.\n\n2. Use standard mathematical functions such as addition (+), subtraction (-), multiplication (*), and division (/). These functions can be used to combine numbers and variables in the equation.\n\n3. Parentheses can be used to group parts of the equation together. For example, "(3 * x + 2) * 5" is a valid equation.\n\n4. Use standard mathematical functions such as sin(x), cos(x), tan(x), e(x), and log(b, x) to include more complex mathematical operations in the equation.\n\n5. Use the caret (^) symbol to indicate exponents. For example, "x ^ 2" represents "x squared".\n\n6. Use only numbers and mathematical operators when inputting the equation. Special characters and symbols are not supported.\n\n7. Make sure the equation is entered correctly and without any typos. Any errors in the equation will result in an error message.\n\n8. Remember to use the correct syntax for the mathematical functions used in the equation. Incorrect syntax will result in an error message.',
    ),
  ];

  void _saveSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedTrigoTabIndex', _selectedTabIndex);
  }

  void _loadSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTabIndex = prefs.getInt('selectedTrigoTabIndex') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Fraction phase = Fraction.fromDouble(_phase / pi);

    final List<String> displayFunction = [
      'y = ${_amplitude.toStringAsFixed(0)} sin(2π ${_frequency.toStringAsFixed(0)}t + $phaseπ)',
      'y = ${_amplitude.toStringAsFixed(0)} cos(2π ${_frequency.toStringAsFixed(0)}t + $phaseπ)',
      'y = ${_amplitude.toStringAsFixed(0)} tan(2π ${_frequency.toStringAsFixed(0)}t + $phaseπ)',
      'y = ${_a.toStringAsFixed(0)} e^ ${_b.toStringAsFixed(0)}x',
      'y = ${_a.toStringAsFixed(0)} ln ${_b.toStringAsFixed(0)}x',
    ];

    void info() {
      showModal(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: _selectedTabIndex <= 3
                ? const Text(
                    'Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : const Text(
                    'Take Note',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
            content:
                SingleChildScrollView(child: _information[_selectedTabIndex]),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _selectedTabIndex <= 3
                    ? const Text('How Exciting!')
                    : const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _title[_selectedTabIndex],
          style: const TextStyle(
            fontFamily: 'Berlin',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: _selectedTabIndex <= 3
                ? const Icon(Icons.info_rounded)
                : const Icon(Icons.warning_rounded),
            onPressed: () => info(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 500),
              reverse: _selectedTabIndex == 4,
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  fillColor: Colors.white,
                  child: child,
                );
              },
              child: _selectedTabIndex <= 3
                  ? Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 5,
                            ),
                            child: Math.tex(
                              _formula[_selectedTabIndex],
                              textStyle: const TextStyle(fontSize: 30),
                            ),
                          ),
                          SizedBox(
                            height: 400,
                            child: SfCartesianChart(
                              primaryXAxis: NumericAxis(
                                minimum: _selectedTabIndex != 2 ? 0 : -5,
                                maximum: _selectedTabIndex <= 1
                                    ? 1
                                    : _selectedTabIndex == 2
                                        ? 5
                                        : 10,
                                interval: _selectedTabIndex <= 1 ? 0.125 : 1,
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                labelFormat: '{value}',
                                axisLine: const AxisLine(width: 3),
                              ),
                              primaryYAxis: NumericAxis(
                                minimum: _selectedTabIndex <= 1
                                    ? -11
                                    : _selectedTabIndex == 2
                                        ? 0
                                        : -5,
                                maximum: _selectedTabIndex <= 2 ? 11 : 5,
                                interval: 1,
                                labelFormat: '{value}',
                                axisLine: const AxisLine(width: 3),
                              ),
                              series: _getSeries(),
                              trackballBehavior: TrackballBehavior(
                                enable: true,
                                lineType: TrackballLineType.vertical,
                                activationMode: ActivationMode.longPress,
                                lineColor: Colors.grey[400],
                              ),
                              enableAxisAnimation: true,
                              zoomPanBehavior: ZoomPanBehavior(
                                enablePinching: true,
                                enablePanning: true,
                              ),
                            ),
                          ),
                          Text(
                            displayFunction[_selectedTabIndex],
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 240,
                            child: _selectedTabIndex <= 2
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Amplitude (m): ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            child: Slider(
                                              value: _amplitude,
                                              min: -10,
                                              max: 10,
                                              divisions: 20,
                                              onChanged: (value) {
                                                setState(() {
                                                  _amplitude = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Frequency (Hz): ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            child: Slider(
                                              value: _frequency,
                                              min: 0,
                                              max: 10,
                                              divisions: 10,
                                              onChanged: (value) {
                                                setState(() {
                                                  _frequency = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Phase (rad): ',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            child: Slider(
                                              value: _phase,
                                              min: -2 * pi,
                                              max: 2 * pi,
                                              divisions: 48,
                                              onChanged: (value) {
                                                setState(() {
                                                  _phase = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 80,
                                              child: Text(
                                                'a: ',
                                                style: TextStyle(fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Slider(
                                                value: _a,
                                                min: 0,
                                                max: 10,
                                                divisions: 10,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _a = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 80,
                                              child: Text(
                                                'b: ',
                                                style: TextStyle(fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Slider(
                                                value: _b,
                                                min: 0,
                                                max: 10,
                                                divisions: 10,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _b = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                          ),
                        ],
                      ),
                    )
                  : const GraphingCalculatorWidget(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
            _saveSelectedTabIndex();
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'sin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'cos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'e',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'ln',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded, size: 0),
            label: 'Explore',
          ),
        ],
      ),
    );
  }

  List<double> _getTrigoData() {
    final List<double> data = [];
    for (double i = 0; i <= 1; i += 0.01) {
      data.add(i);
    }
    return data;
  }

  List<double> _getExpData() {
    final List<double> data = [];
    for (double i = -5; i <= 5; i += 0.1) {
      data.add(i);
    }
    return data;
  }

  List<double> _getLogData() {
    final List<double> data = [];
    for (double i = 0.001; i <= 10; i += 0.01) {
      data.add(i);
    }
    return data;
  }

  List<LineSeries<double, double>> _getSeries() {
    late List<LineSeries<double, double>> series;
    switch (_selectedTabIndex) {
      case 0:
        series = [
          LineSeries<double, double>(
            dataSource: _getTrigoData(),
            xValueMapper: (data, _) => data,
            yValueMapper: (data, _) =>
                _amplitude * sin(2 * pi * _frequency * data + _phase),
            width: 2,
          ),
        ];
        break;
      case 1:
        series = [
          LineSeries<double, double>(
            dataSource: _getTrigoData(),
            xValueMapper: (data, _) => data,
            yValueMapper: (data, _) =>
                _amplitude * cos(2 * pi * _frequency * data + _phase),
            width: 2,
          )
        ];
        break;
      case 2:
        series = [
          LineSeries<double, double>(
            dataSource: _getExpData(),
            xValueMapper: (data, _) => data,
            yValueMapper: (data, _) => _a * exp(_b * data),
            width: 2,
          )
        ];
        break;
      case 3:
        series = [
          LineSeries<double, double>(
            dataSource: _getLogData(),
            xValueMapper: (data, _) => data,
            yValueMapper: (data, _) => _a * log(_b * data),
            width: 2,
          )
        ];
        break;
    }
    return series;
  }
}
