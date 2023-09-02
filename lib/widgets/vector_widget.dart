// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:extended_math/extended_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VectorWidget extends StatefulWidget {
  const VectorWidget({super.key});

  @override
  State<VectorWidget> createState() => _VectorWidgetState();
}

class _VectorWidgetState extends State<VectorWidget> {
  final TextEditingController _xController = TextEditingController(text: '3');
  final TextEditingController _yController = TextEditingController(text: '5');
  final TextEditingController _zController = TextEditingController(text: '4');
  final TextEditingController _normController =
      TextEditingController(text: '6');
  final List<Vector> _vectorList = [
    const Vector(<num>[3, 5, 4])
  ];
  final List<String> _normList = [];
  final List<String> _productList = [];
  final List<String> _angleBetweenList = [];
  final List<String> _unitList = [];

  void _newVector() {
    final xText = _xController.text;
    final yText = _yController.text;
    final zText = _zController.text;

    final x = xText.isEmpty ? 0.0 : double.parse(xText);
    final y = yText.isEmpty ? 0.0 : double.parse(yText);
    final z = zText.isEmpty ? 0.0 : double.parse(zText);

    final v = Vector(<num>[x, y, z]);

    if (_vectorList.length < 2) {
      setState(() {
        _vectorList.add(v);
      });
    }

    _xController.clear();
    _yController.clear();
    _zController.clear();
  }

  void _remove(BuildContext context, int index) {
    setState(() {
      _vectorList.removeAt(index);
    });
  }

  void _norm() {
    final normText = _normController.text;
    num norm = _vectorList[0].norm(double.parse(normText));
    num euclideanNorm = _vectorList[0].euclideanNorm();
    num maxNorm = _vectorList[0].maxNorm();

    setState(() {
      _normList.clear();

      _normList.add('Norm of Vector 1: $norm');
      _normList.add('Euclidean Norm of Vector 1: $euclideanNorm');
      _normList.add('Max Norm of Vector 1: $maxNorm');
    });
  }

  void _product() {
    if (_vectorList.length != 2) return;

    num dot = _vectorList[0].dot(_vectorList[1]);
    Vector cross = _vectorList[0].cross(_vectorList[1]);
    Vector hadamard = _vectorList[0].hadamard(_vectorList[1]);

    setState(() {
      _productList.clear();

      _productList.add('Dot product: $dot');
      _productList.add('Cross product: $cross');
      _productList.add('Hadamard product: $hadamard');
    });
  }

  void _angleBetween() {
    if (_vectorList.length != 2) return;

    double angleBetween = _vectorList[0].angleBetween(_vectorList[1]);
    double angleBetweenDegree =
        _vectorList[0].angleBetween(_vectorList[1], degrees: true);
    num length0 = _vectorList[0].length;
    num length1 = _vectorList[1].length;

    setState(() {
      _angleBetweenList.clear();

      _angleBetweenList.add('Angle Between (radian): $angleBetween');
      _angleBetweenList.add('Angle Between (degree): $angleBetweenDegree');
      _angleBetweenList.add('Length of Vector 1: $length0');
      _angleBetweenList.add('Length of Vector 2: $length1');
    });
  }

  void _unit() {
    if (_vectorList.length != 2) return;

    bool isUnit1 = _vectorList[0].isUnit();
    bool isUnit2 = _vectorList[1].isUnit();
    bool isOrthogonalTo = _vectorList[0].isOrthogonalTo(_vectorList[1]);
    bool isOrthonormalWith = _vectorList[0].isOrthonormalWith(_vectorList[1]);

    setState(() {
      _unitList.clear();

      _unitList.add(isUnit1 ? 'Vector 1 is unit' : 'Vector 1 is not unit');
      _unitList.add(isUnit2 ? 'Vector 2 is unit' : 'Vector 2 is not unit');
      _unitList.add(isOrthogonalTo
          ? 'Vector 1 is orthogonal to Vector 2'
          : 'Vector 1 is not orthogonal to Vector 2');
      _unitList.add(isOrthonormalWith
          ? 'Vector 1 is orthonormal with Vector 2'
          : 'Vector 1 is not orthonormal with Vector 2');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _vectorList.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (context) => _remove(context, index),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Remove'),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      '${_vectorList[index]}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _normList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    _normList[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _productList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    _productList[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _angleBetweenList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    _angleBetweenList[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _unitList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    _unitList[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Math.tex(
                    r'x: ',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _xController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Math.tex(
                    r'y: ',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _yController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Math.tex(
                    r'z: ',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _zController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: _newVector,
                    icon: const Icon(Icons.arrow_upward_sharp),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _normController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                ElevatedButton(
                  onPressed: _vectorList.isNotEmpty ? _norm : null,
                  child: const Text('Norm'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _vectorList.length >= 2 ? _product : null,
                    child: const Text('Product'),
                  ),
                  ElevatedButton(
                    onPressed: _vectorList.length >= 2 ? _angleBetween : null,
                    child: const Text('Angle Between'),
                  ),
                  ElevatedButton(
                    onPressed: _vectorList.length >= 2 ? _unit : null,
                    child: const Text('Unit'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _vectorList.clear();
                _normList.clear();
                _productList.clear();
                _angleBetweenList.clear();
                _unitList.clear();
              }),
              child: const Text('Clear ALL'),
            ),
          ],
        ),
      ),
    );
  }
}
