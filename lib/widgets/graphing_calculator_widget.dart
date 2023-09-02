import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphingCalculatorWidget extends StatefulWidget {
  const GraphingCalculatorWidget({super.key});

  @override
  State<GraphingCalculatorWidget> createState() =>
      _GraphingCalculatorWidgetState();
}

class _GraphingCalculatorWidgetState extends State<GraphingCalculatorWidget> {
  final TextEditingController _equationController =
      TextEditingController(text: '3 * x - 2');

  String stringPi = pi.toString();

  List<double> _chartData = [];

  @override
  void initState() {
    super.initState();
    _chartData = _getChartData();
  }

  double? _evaluateEquation(double x) {
    String equation = _equationController.text.replaceAll('pi', stringPi);

    try {
      Parser p = Parser();
      Expression exp = p.parse(equation);
      ContextModel cm = ContextModel();
      cm.bindVariable(Variable('x'), Number(x));
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(),
              series: <LineSeries>[
                LineSeries<double, double>(
                  dataSource: _chartData,
                  xValueMapper: (double value, _) => value,
                  yValueMapper: (double value, _) => _evaluateEquation(value),
                ),
              ],
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
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
            ),
            child: Row(
              children: [
                const Text(
                  'y = ',
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                  child: TextField(
                    controller: _equationController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _evaluateEquation(0) != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _evaluateEquation(0) != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _evaluateEquation(0) != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _evaluateEquation(0) != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _evaluateEquation(0) != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _evaluateEquation(0) != null
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      labelText: _evaluateEquation(0) != null
                          ? 'Enter equation'
                          : 'Error',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: _evaluateEquation(0) != null
                            ? Colors.blue
                            : Colors.red,
                      ),
                      hintText: '3 * x - 2',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _chartData = _getChartData();
                    });
                  },
                  icon: const Icon(Icons.draw_rounded),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<double> _getChartData() {
    List<double> data = [];

    double start = _equationController.text.contains('log') ? 0.01 : -10;

    for (double i = start; i <= 10.01; i += 0.01) {
      data.add(i);
    }

    return data;
  }
}
