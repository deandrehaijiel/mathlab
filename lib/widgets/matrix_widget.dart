// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:extended_math/extended_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MatrixWidget extends StatefulWidget {
  const MatrixWidget({super.key});

  @override
  State<MatrixWidget> createState() => _MatrixWidgetState();
}

class _MatrixWidgetState extends State<MatrixWidget> {
  final TextEditingController _matrixController =
      TextEditingController(text: '4 6\n7.4 0.687');

  final List<List<List<num>>> _matrixList = [
    [
      <num>[4, 6],
      <num>[7.4, 0.687]
    ]
  ];

  Matrix? _transpose;
  double? _frobeniusNorm;
  bool? _diagonal;
  bool? _square;
  bool? _identity;
  Vector? _mainDiagonal;
  Vector? _collateralDiagonal;
  Matrix? _submatrix;
  Matrix? _gaussianElimination;
  num? _trace;
  int? _rank;
  double? _condition;
  Map<String, Matrix>? _singularValueDecomposition;
  Map<String, Matrix>? _qrDecomposition;
  double? _norm;
  num? _infinityNorm;
  num? _spectralNorm;

  void _parseMatrix(String input) {
    List<List<num>> parsedMatrix = [];
    List<String> rows = input.trim().split('\n');
    for (String row in rows) {
      List<num> parsedRow =
          row.trim().split(' ').map((e) => num.tryParse(e) ?? 0).toList();
      parsedMatrix.add(parsedRow);
    }
    setState(() {
      if (_matrixList.isEmpty) {
        _matrixList.add(parsedMatrix);
      }
    });
  }

  void _removeMatrix(BuildContext context, int index) {
    setState(() {
      _matrixList.removeAt(index);
    });
  }

  void _computeTransposition() {
    Matrix matrix = Matrix(_matrixList[0]);
    _transpose = matrix.transpose();
    setState(() {});
  }

  void _computeFrobeniusNorm() {
    Matrix matrix = Matrix(_matrixList[0]);
    _frobeniusNorm = matrix.frobeniusNorm();
    setState(() {});
  }

  void _computeDiagonal() {
    Matrix matrix = Matrix(_matrixList[0]);
    _diagonal = matrix.isDiagonal();
    setState(() {});
  }

  void _computeSquare() {
    Matrix matrix = Matrix(_matrixList[0]);
    _square = matrix.isSquare();
    setState(() {});
  }

  void _computeIdentity() {
    Matrix matrix = Matrix(_matrixList[0]);
    _identity = matrix.isIdentity();
    setState(() {});
  }

  void _computeDiagonalMain() {
    Matrix matrix = Matrix(_matrixList[0]);
    _mainDiagonal = matrix.mainDiagonal();
    setState(() {});
  }

  void _computeDiagonalCollateral() {
    Matrix matrix = Matrix(_matrixList[0]);
    _collateralDiagonal = matrix.collateralDiagonal();
    setState(() {});
  }

  final TextEditingController _rowFromController =
      TextEditingController(text: '1');

  final TextEditingController _rowToController =
      TextEditingController(text: '1');

  final TextEditingController _colFromController =
      TextEditingController(text: '1');

  final TextEditingController _colToController =
      TextEditingController(text: '1');

  void _computeSubmatrix() {
    Matrix matrix = Matrix(_matrixList[0]);
    int? rowFrom = int.tryParse(_rowFromController.text);
    int? rowTo = int.tryParse(_rowToController.text);
    int? colFrom = int.tryParse(_colFromController.text);
    int? colTo = int.tryParse(_colToController.text);
    _submatrix = matrix.submatrix(rowFrom, rowTo, colFrom, colTo);
    setState(() {});
  }

  void _computeGaussianElimination() {
    Matrix matrix = Matrix(_matrixList[0]);
    _gaussianElimination = matrix.gaussian();
    setState(() {});
  }

  void _computeTrace() {
    Matrix matrix = Matrix(_matrixList[0]);
    _trace = matrix.trace();
    setState(() {});
  }

  void _computeRank() {
    Matrix matrix = Matrix(_matrixList[0]);
    _rank = matrix.rank();
    setState(() {});
  }

  void _computeCondition() {
    Matrix matrix = Matrix(_matrixList[0]);
    _condition = matrix.condition();
    setState(() {});
  }

  void _computeSingularValueDecomposition() {
    Matrix matrix = Matrix(_matrixList[0]);
    _singularValueDecomposition = matrix.svd();
    setState(() {});
  }

  void _computeQRDecomposition() {
    Matrix matrix = Matrix(_matrixList[0]);
    _qrDecomposition = matrix.qr();
    setState(() {});
  }

  final TextEditingController _normController =
      TextEditingController(text: '3');

  void _computeNorm() {
    Matrix matrix = Matrix(_matrixList[0]);
    int? norm = int.tryParse(_normController.text);
    _norm = matrix.norm(norm);
    setState(() {});
  }

  void _computeInfinityNorm() {
    Matrix matrix = Matrix(_matrixList[0]);
    _infinityNorm = matrix.infinityNorm();
    setState(() {});
  }

  void _computeSpectralNorm() {
    Matrix matrix = Matrix(_matrixList[0]);
    _spectralNorm = matrix.spectralNorm();
    setState(() {});
  }

  final TextEditingController _matricesController =
      TextEditingController(text: '4 6\n7.4 0.687');

  final List<List<List<num>>> _matricesList = [
    [
      <num>[4, 6],
      <num>[7.4, 0.687]
    ],
    [
      <num>[6, 3],
      <num>[1.2, 9]
    ]
  ];

  Matrix? _hadamard;
  Matrix? _matrixProduct;

  void _parseMatrices(String input) {
    List<List<num>> parsedMatrices = [];
    List<String> rows = input.trim().split('\n');
    for (String row in rows) {
      List<num> parsedRow =
          row.trim().split(' ').map((e) => num.tryParse(e) ?? 0).toList();
      parsedMatrices.add(parsedRow);
    }
    setState(() {
      if (_matricesList.length < 2) {
        _matricesList.add(parsedMatrices);
      }
    });
  }

  void _removeMatrices(BuildContext context, int index) {
    setState(() {
      _matricesList.removeAt(index);
    });
  }

  void _computeHadamard() {
    Matrix matrices1 = Matrix(_matricesList[0]);
    Matrix matrices2 = Matrix(_matricesList[1]);
    _hadamard = matrices1 * matrices2;
    setState(() {});
  }

  void _computeMatrixProduct() {
    Matrix matrices1 = Matrix(_matricesList[0]);
    Matrix matrices2 = Matrix(_matricesList[1]);
    _matrixProduct = matrices1.matrixProduct(matrices2);
    setState(() {});
  }

  final TextEditingController _squareMatrixController =
      TextEditingController(text: '4 6\n7.4 0.687');

  final List<List<List<num>>> _squareMatrixList = [
    [
      <num>[4, 6],
      <num>[7.4, 0.687]
    ]
  ];

  num? _determinant;
  bool? _singular;
  bool? _symmetric;
  bool? _positiveSemidefinite;
  bool? _negativeSemidefinite;
  bool? _indefinite;
  bool? _orthogonal;
  bool? _upperTriangle;
  bool? _lowerTriangle;
  SquareMatrix? _inverse;
  Map<num, Vector>? _eigenDecomposition;
  Map<String, SquareMatrix>? _luDecomposition;
  SquareMatrix? _choleskyDecomposition;
  Vector? _solveLinearExpressionsUsingGaussianElimination;

  void _parseSquareMatrix(String input) {
    List<List<num>> parsedMatrix = [];
    List<String> rows = input.trim().split('\n');
    for (String row in rows) {
      List<num> parsedRow =
          row.trim().split(' ').map((e) => num.tryParse(e) ?? 0).toList();
      parsedMatrix.add(parsedRow);
    }
    setState(() {
      if (_squareMatrixList.isEmpty) {
        _squareMatrixList.add(parsedMatrix);
      }
    });
  }

  void _removeSquareMatrix(BuildContext context, int index) {
    setState(() {
      _squareMatrixList.removeAt(index);
    });
  }

  void _computeDeterminant() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _determinant = squareMatrix.determinant();
    setState(() {});
  }

  void _computeSingular() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _singular = squareMatrix.isSingular();
    setState(() {});
  }

  void _computeSymmetric() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _symmetric = squareMatrix.isSymmetric();
    setState(() {});
  }

  void _computePositiveSemidefinite() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _positiveSemidefinite = squareMatrix.isPositiveDefinite();
    setState(() {});
  }

  void _computeNegativeSemidefinite() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _negativeSemidefinite = squareMatrix.isNegativeDefinite();
    setState(() {});
  }

  void _computeIndefinite() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _indefinite = squareMatrix.isIndefinite();
    setState(() {});
  }

  void _computeOrthogonal() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _orthogonal = squareMatrix.isOrthogonal();
    setState(() {});
  }

  void _computeUpperTriangle() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _upperTriangle = squareMatrix.isUpperTriangle();
    setState(() {});
  }

  void _computeLowerTriangle() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _lowerTriangle = squareMatrix.isLowerTriangle();
    setState(() {});
  }

  void _computeInverse() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _inverse = squareMatrix.inverse();
    setState(() {});
  }

  void _computeEigenDecomposition() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _eigenDecomposition = squareMatrix.eigen();
    setState(() {});
  }

  void _computeLUDecomposition() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _luDecomposition = squareMatrix.lu();
    setState(() {});
  }

  void _computeCholeskyDecomposition() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    _choleskyDecomposition = squareMatrix.cholesky();
    setState(() {});
  }

  final TextEditingController _eliminateController =
      TextEditingController(text: '1, 2');

  void _computeSolveLinearExpressionsUsingGaussianElimination() {
    SquareMatrix squareMatrix = SquareMatrix(_squareMatrixList[0]);
    List<num?> eliminate = _eliminateController.text
        .split(',')
        .map((value) => num.tryParse(value.trim()) ?? 0)
        .toList();

    _solveLinearExpressionsUsingGaussianElimination =
        squareMatrix.eliminate(eliminate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '1 Matrix',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _matrixList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => _removeMatrix(context, index),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Remove',
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                for (List<num> row in _matrixList[index])
                                  Row(
                                    children: [
                                      for (num item in row)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            child: Text(
                                              item.toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_transpose != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Transpose: $_transpose',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_frobeniusNorm != null)
              Text(
                'Frobenius Norm: $_frobeniusNorm',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_diagonal != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _diagonal == true
                      ? 'Matrix is a diagonal matrix'
                      : 'Matrix is not a diagonal matrix',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_square != null)
              Text(
                _square == true
                    ? 'Matrix is a square matrix'
                    : 'Matrix is not a square matrix',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_identity != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _identity == true
                      ? 'Matrix is a identity matrix'
                      : 'Matrix is not a identity matrix',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_mainDiagonal != null)
              Text(
                'Main Diagonal: $_mainDiagonal',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_collateralDiagonal != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Collateral Diagonal: $_collateralDiagonal',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_gaussianElimination != null)
              Text(
                'Gaussian Elimination: $_gaussianElimination',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_trace != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Trace: $_trace',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_rank != null)
              Text(
                'Rank: $_rank',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_condition != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Condition: $_condition',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_singularValueDecomposition != null)
              Text(
                'Singular Value Decomposition: \n$_singularValueDecomposition',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_qrDecomposition != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'QR Decomposition: \n$_qrDecomposition',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_infinityNorm != null)
              Text(
                'Infinity Norm: $_infinityNorm',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_spectralNorm != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Spectral Norm: $_spectralNorm',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_norm != null)
              Text(
                'Norm: $_norm',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_submatrix != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Submatrix: $_submatrix',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _matrixController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText:
                            'Matrix (separate values by spaces and rows by new lines)',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      _parseMatrix(_matrixController.text),
                      _matrixController.clear(),
                    },
                    icon: const Icon(
                      Icons.arrow_upward_sharp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      _matrixList.isNotEmpty ? _computeTransposition : null,
                  child: const Text('Transposition'),
                ),
                ElevatedButton(
                  onPressed:
                      _matrixList.isNotEmpty ? _computeFrobeniusNorm : null,
                  child: const Text('Frobenius Norm'),
                ),
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeDiagonal : null,
                  child: const Text('Diagonal'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeSquare : null,
                  child: const Text('Square'),
                ),
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeIdentity : null,
                  child: const Text('Identity'),
                ),
                ElevatedButton(
                  onPressed:
                      _matrixList.isNotEmpty ? _computeDiagonalMain : null,
                  child: const Text('Diagonal (Main)'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty
                      ? _computeDiagonalCollateral
                      : null,
                  child: const Text('Diagonal (Collateral)'),
                ),
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty
                      ? _computeGaussianElimination
                      : null,
                  child: const Text('Gaussian Elimination'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeTrace : null,
                  child: const Text('Trace'),
                ),
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeRank : null,
                  child: const Text('Rank'),
                ),
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeCondition : null,
                  child: const Text('Condition'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty
                      ? _computeSingularValueDecomposition
                      : null,
                  child: const Text('Singular Value Decomposition'),
                ),
                ElevatedButton(
                  onPressed:
                      _matrixList.isNotEmpty ? _computeQRDecomposition : null,
                  child: const Text('QR Decomposition'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      _matrixList.isNotEmpty ? _computeInfinityNorm : null,
                  child: const Text('Infinity Norm'),
                ),
                ElevatedButton(
                  onPressed:
                      _matrixList.isNotEmpty ? _computeSpectralNorm : null,
                  child: const Text('Spectral Norm'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
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
                    onPressed: _matrixList.isNotEmpty ? _computeNorm : null,
                    child: const Text('Norm'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _rowFromController,
                        decoration: const InputDecoration(
                          labelText: 'Row From',
                        ),
                      ),
                      TextField(
                        controller: _rowToController,
                        decoration: const InputDecoration(
                          labelText: 'Row To',
                        ),
                      ),
                      TextField(
                        controller: _colFromController,
                        decoration: const InputDecoration(
                          labelText: 'Col From',
                        ),
                      ),
                      TextField(
                        controller: _colToController,
                        decoration: const InputDecoration(
                          labelText: 'Col To',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                ElevatedButton(
                  onPressed: _matrixList.isNotEmpty ? _computeSubmatrix : null,
                  child: const Text('Submatrix'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _matrixList.clear();
                    _transpose = null;
                    _frobeniusNorm = null;
                    _diagonal = null;
                    _square = null;
                    _identity = null;
                    _mainDiagonal = null;
                    _collateralDiagonal = null;
                    _submatrix = null;
                    _gaussianElimination = null;
                    _trace = null;
                    _rank = null;
                    _condition = null;
                    _singularValueDecomposition = null;
                    _qrDecomposition = null;
                    _norm = null;
                    _infinityNorm = null;
                    _spectralNorm = null;
                  }),
                  child: const Text('Clear ALL'),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '2 Matrices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _matricesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) =>
                              _removeMatrices(context, index),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Remove',
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                for (List<num> row in _matricesList[index])
                                  Row(
                                    children: [
                                      for (num item in row)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            child: Text(
                                              item.toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_hadamard != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Hadamard Product: $_hadamard',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_matrixProduct != null)
              Text(
                'Matrix Product: $_matrixProduct',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _matricesController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText:
                            'Matrix (separate values by spaces and rows by new lines)',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      _parseMatrices(_matricesController.text),
                      _matricesController.clear(),
                    },
                    icon: const Icon(
                      Icons.arrow_upward_sharp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      _matricesList.length == 2 ? _computeHadamard : null,
                  child: const Text('Hadamard'),
                ),
                ElevatedButton(
                  onPressed:
                      _matricesList.length == 2 ? _computeMatrixProduct : null,
                  child: const Text('Product'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _matricesList.clear();
                    _hadamard = null;
                    _matrixProduct = null;
                  }),
                  child: const Text('Clear ALL'),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Sqaure Matrix',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _squareMatrixList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) =>
                              _removeSquareMatrix(context, index),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Remove',
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                for (List<num> row in _squareMatrixList[index])
                                  Row(
                                    children: [
                                      for (num item in row)
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            child: Text(
                                              item.toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 3,
                                width: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_determinant != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Determinant: $_determinant',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_singular != null)
              Text(
                _singular == true
                    ? 'Matrix is a singular matrix'
                    : 'Matrix is not a singular matrix',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_symmetric != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _symmetric == true
                      ? 'Matrix is symmetrical'
                      : 'Matrix is not symmetrical',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_positiveSemidefinite != null)
              Text(
                _positiveSemidefinite == true
                    ? 'Matrix is positive (semi)definite'
                    : 'Matrix is not positive (semi)definite',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_negativeSemidefinite != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _negativeSemidefinite == true
                      ? 'Matrix is negative (semi)definite'
                      : 'Matrix is not negative (semi)definite',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_indefinite != null)
              Text(
                _indefinite == true
                    ? 'Matrix is indefinite'
                    : 'Matrix is not indefinite',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_orthogonal != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _orthogonal == true
                      ? 'Matrix is orthogonal'
                      : 'Matrix is not orthogonal',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_upperTriangle != null)
              Text(
                _upperTriangle == true
                    ? 'Matrix is upper triangle'
                    : 'Matrix is not upper triangle',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_lowerTriangle != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  _lowerTriangle == true
                      ? 'Matrix is lower triangle'
                      : 'Matrix is not lower triangle',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_inverse != null)
              Text(
                'Inverse: $_inverse',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_eigenDecomposition != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Eigen Decomposition: $_eigenDecomposition',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_luDecomposition != null)
              Text(
                'LU Decomposition: $_luDecomposition',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            if (_choleskyDecomposition != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Cholesky Decomposition: $_choleskyDecomposition',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Cholesky Decomposition: null',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (_solveLinearExpressionsUsingGaussianElimination != null)
              Text(
                'Solves Linear Expressions Using Gaussian Elimination: \n$_solveLinearExpressionsUsingGaussianElimination',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _squareMatrixController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText:
                            'Matrix (separate values by spaces and rows by new lines)',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      _parseSquareMatrix(_squareMatrixController.text),
                      _squareMatrixController.clear(),
                    },
                    icon: const Icon(
                      Icons.arrow_upward_sharp,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      _squareMatrixList.isNotEmpty ? _computeDeterminant : null,
                  child: const Text('Determinant'),
                ),
                ElevatedButton(
                  onPressed:
                      _squareMatrixList.isNotEmpty ? _computeSingular : null,
                  child: const Text('Singular'),
                ),
                ElevatedButton(
                  onPressed:
                      _squareMatrixList.isNotEmpty ? _computeSymmetric : null,
                  child: const Text('Symmetric'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computePositiveSemidefinite
                      : null,
                  child: const Text('Positive (Semi)definite'),
                ),
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computeNegativeSemidefinite
                      : null,
                  child: const Text('Negative (Semi)definite'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      _squareMatrixList.isNotEmpty ? _computeIndefinite : null,
                  child: const Text('Indefinite'),
                ),
                ElevatedButton(
                  onPressed:
                      _squareMatrixList.isNotEmpty ? _computeOrthogonal : null,
                  child: const Text('Orthogonal'),
                ),
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computeUpperTriangle
                      : null,
                  child: const Text('Upper Triangle'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computeLowerTriangle
                      : null,
                  child: const Text('Lower Triangle'),
                ),
                ElevatedButton(
                  onPressed:
                      _squareMatrixList.isNotEmpty ? _computeInverse : null,
                  child: const Text('Inverse'),
                ),
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computeEigenDecomposition
                      : null,
                  child: const Text('Eigen Decomposition'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computeLUDecomposition
                      : null,
                  child: const Text('LU Decomposition'),
                ),
                ElevatedButton(
                  onPressed: _squareMatrixList.isNotEmpty
                      ? _computeCholeskyDecomposition
                      : null,
                  child: const Text('Cholesky Decomposition'),
                ),
              ],
            ),
            TextField(
              controller: _eliminateController,
              decoration: const InputDecoration(
                labelText: 'Elimination Factor (comma-separated)',
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _squareMatrixList.isNotEmpty
                    ? _computeSolveLinearExpressionsUsingGaussianElimination
                    : null,
                child: const Text(
                    'Solve Linear Expressions Using Gaussian Elimination'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => setState(() {
                  _squareMatrixList.clear();
                  _determinant = null;
                  _singular = null;
                  _symmetric = null;
                  _positiveSemidefinite = null;
                  _negativeSemidefinite = null;
                  _indefinite = null;
                  _orthogonal = null;
                  _upperTriangle = null;
                  _lowerTriangle = null;
                  _inverse = null;
                  _eigenDecomposition = null;
                  _luDecomposition = null;
                  _choleskyDecomposition = null;
                  _solveLinearExpressionsUsingGaussianElimination = null;
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
