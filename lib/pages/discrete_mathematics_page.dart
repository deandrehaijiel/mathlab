// ignore_for_file: unnecessary_string_escapes

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class DiscreteMathematicsPage extends StatefulWidget {
  const DiscreteMathematicsPage({super.key});

  @override
  State<DiscreteMathematicsPage> createState() =>
      _DiscreteMathematicsPageState();
}

class _DiscreteMathematicsPageState extends State<DiscreteMathematicsPage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedTabIndex();
  }

  void _saveSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedDMTabIndex', _selectedTabIndex);
  }

  void _loadSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTabIndex = prefs.getInt('selectedDMTabIndex') ?? 0;
    });
  }

  void info() {
    showModal(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            _selectedTabIndex == 0 ? 'Information' : 'Take Note',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(_selectedTabIndex == 0
                ? 'Unique prime numbers refer to prime numbers that are distinct and not repeated. Prime numbers are positive integers greater than 1 that have no divisors other than 1 and themselves.\n\nHere is an explanation of unique prime numbers:\n\n1. Prime Numbers: Prime numbers are numbers that are divisible only by 1 and themselves. For example, 2, 3, 5, 7, 11, 13, and so on, are prime numbers because they cannot be divided evenly by any other number.\n\n2. Distinct Prime Numbers: Distinct prime numbers are prime numbers that are different from each other. Each distinct prime number has its own unique value. For example, 2 and 3 are distinct prime numbers because they have different values and are not repeated.\n\n3. Non-Repeated Prime Numbers: Non-repeated prime numbers are prime numbers that are not duplicated or repeated in a given set or sequence. In a list of prime numbers, each prime number appears only once. There are no duplicates or repetitions of the same prime number.\n\nIn summary, unique prime numbers are prime numbers that are distinct and non-repeated. They are positive integers greater than 1 that have no divisors other than 1 and themselves, and each unique prime number has its own unique value.'
                : _selectedTabIndex == 1
                    ? '1. Norm (Magnitude): The norm, also known as the magnitude or length, of a vector represents its size or magnitude. It is calculated using various methods, such as the Euclidean norm or the L2 norm. The norm of a vector is denoted by ||v|| or |v|, where v represents the vector. For a 2D vector (x, y), the Euclidean norm is calculated as ||v|| = sqrt(x^2 + y^2), giving the length of the vector.\n\n2. Product: In the context of vectors, there are several types of products that can be computed:\n\n• Dot Product: The dot product (also known as the scalar product or inner product) of two vectors is a scalar value obtained by multiplying the corresponding components of the vectors and summing them. It is denoted by v · w or v · w = ||v|| ||w|| cosθ, where v and w are vectors and θ is the angle between them. The dot product provides information about the similarity or orthogonality of vectors.\n\n• Cross Product: The cross product (also known as the vector product) of two vectors in three-dimensional space produces a new vector that is perpendicular to both of the original vectors. It is denoted by v × w or v × w = ||v|| ||w|| sinθ n, where v, w are vectors, θ is the angle between them, and n is a unit vector perpendicular to the plane containing v and w. The cross product is useful in calculating areas, determining the direction of a vector perpendicular to a plane, and solving problems in physics and geometry.\n\n3. Angle Between: The angle between two vectors refers to the measure of the angle formed between the vectors when they are placed tail-to-tail or head-to-head. It is denoted by θ. The angle between two vectors can be calculated using the dot product formula: θ = arccos((v · w) / (||v|| ||w||)). The resulting angle value indicates the deviation or separation between the vectors.\n\n4. Unit Vector: A unit vector is a vector with a magnitude of 1. It represents the direction of a vector without considering its magnitude. Unit vectors are often used to describe the direction or orientation of a vector. To obtain a unit vector, divide a vector by its norm: u = v / ||v||. The resulting unit vector has the same direction as the original vector but with a magnitude of 1.'
                    : '1 Matrix\n\n1. Transposition:\nTransposition is an operation that involves flipping a matrix over its main diagonal. For an \(m \times n\) matrix, the transpose results in an \(n \times m\) matrix, where the rows become columns and vice versa. The transpose of a matrix \(A\) is denoted as \(A^T\) or \(A\'\).\n\n2. Frobenius Norm:\nThe Frobenius norm is a way to measure the size of a matrix. For an \(m \times n\) matrix \(A\), the Frobenius norm is calculated as the square root of the sum of the squares of all the elements in the matrix: \(\|A\|_F = \sqrt{\sum_{i=1}^{m}\sum_{j=1}^{n} |a_{ij}|^2}\).\n\n3. Diagonal:\nA diagonal of a matrix consists of elements that lie on a straight line from the top-left to the bottom-right of the matrix. There are two types of diagonals in a matrix: the main diagonal (elements with equal row and column indices) and the collateral diagonal (elements with row and column indices that add up to a constant)\n\n4. Square Matrix:\nA square matrix is a matrix where the number of rows is equal to the number of columns (\(m = n\)). In other words, it has the same number of rows and columns.\n\n5. Identity Matrix:\nAn identity matrix is a special type of square matrix where all the diagonal elements are 1 and all other elements are 0. It is denoted as \(I\) and has the property that when multiplied with any square matrix \(A\), it results in the same matrix \(A\).\n\n6. Main Diagonal:\nThe main diagonal of a matrix consists of elements with equal row and column indices. For example, in a square matrix, the main diagonal is the set of elements from the top-left to the bottom-right.\n\n7. Collateral Diagonal:\nThe collateral diagonal of a matrix consists of elements with row and column indices that add up to a constant. It is also known as the antidiagonal. For example, in a square matrix, the collateral diagonal is the set of elements from the top-right to the bottom-left.\n\n8. Gaussian Elimination:\nGaussian Elimination is a method used to solve systems of linear equations by transforming the augmented matrix of the system into a reduced row-echelon form.\n\n9. Trace:\nThe trace of a square matrix is the sum of its main diagonal elements. It is denoted as \(\text{tr}(A)\).\n\n10. Rank:\nThe rank of a matrix is the maximum number of linearly independent rows or columns in the matrix.\n\n11. Condition:\nThe condition number of a matrix measures the sensitivity of the matrix\'s output to changes in its input. It provides a measure of how well-conditioned or ill-conditioned a matrix is.\n\n12. Singular Value Decomposition (SVD):\nSVD is a factorization method that decomposes a matrix into three matrices: \(A = U \Sigma V^T\), where \(U\) and \(V\) are orthogonal matrices, and \(\Sigma\) is a diagonal matrix containing the singular values of \(A\).\n\n13. QR Decomposition:\nQR decomposition is another factorization method that decomposes a matrix into the product of an orthogonal matrix \(Q\) and an upper triangular matrix \(R\).\n\n14. Infinity Norm:\nThe infinity norm (also known as the maximum norm) of a matrix is the maximum absolute row sum of the matrix. It is denoted as \(\|A\|_{\infty}\).\n\n15. Spectral Norm:\nThe spectral norm of a matrix is the square root of the largest eigenvalue of the matrix\'s Hermitian transpose multiplied by the matrix itself. It is denoted as \(\|A\|_2\).\n\n2 Matrices\n\n1. Hadamard Product (Element-wise Multiplication)\nThe Hadamard product, also known as element-wise multiplication, is an operation between two matrices of the same size. Given two matrices \(A\) and \(B\) of the same dimensions (both \(m \times n\)), the Hadamard product \(C\) (denoted as \(C = A \circ B\)) is obtained by multiplying corresponding elements of \(A\) and \(B\) together to form a new matrix \(C\) with the same dimensions.\nExample:\n Let \(A = \begin{bmatrix} 2 & 4 \\ 6 & 8 \end{bmatrix}\) and \(B = \begin{bmatrix} 1 & 3 \\ 5 & 7 \end{bmatrix}\). The Hadamard product \(C\) is:\n\(C = A \circ B = \begin{bmatrix} 2 \cdot 1 & 4 \cdot 3 \\ 6 \cdot 5 & 8 \cdot 7 \end{bmatrix} = \begin{bmatrix} 2 & 12 \\ 30 & 56 \end{bmatrix}\).\n\n2. Matrix Product (Dot Product):\nThe matrix product is an operation between two matrices that results in a new matrix with different dimensions. It is also known as matrix multiplication or dot product. Given two matrices \(A\) and \(B\) with dimensions \(m \times p\) and \(p \times n\), respectively, the matrix product \(C\) (denoted as \(C = A \cdot B\)) is obtained by multiplying corresponding elements of the rows of \(A\) and the columns of \(B\), and summing up the results.\nThe number of columns in matrix \(A\) must be equal to the number of rows in matrix \(B\) for the matrix product to be defined. The resulting matrix \(C\) will have dimensions \(m \times n\).\nExample:\nLet \(A = \begin{bmatrix} 2 & 4 \\ 6 & 8 \end{bmatrix}\) and \(B = \begin{bmatrix} 1 & 3 \\ 5 & 7 \end{bmatrix}\). The matrix product \(C\) is:\n\(C = A \cdot B = \begin{bmatrix} 2 \cdot 1 + 4 \cdot 5 & 2 \cdot 3 + 4 \cdot 7 \\ 6 \cdot 1 + 8 \cdot 5 & 6 \cdot 3 + 8 \cdot 7 \end{bmatrix} = \begin{bmatrix} 22 & 34 \\ 46 & 62 \end{bmatrix}\).\nNote that the dimensions of \(A\) are \(2 \times 2\) and the dimensions of \(B\) are \(2 \times 2\). The resulting matrix \(C\) has dimensions \(2 \times 2\) as well.\n\nSquare Matrix\n\n1. Determinant:\nThe determinant is a scalar value associated with a square matrix. For a square matrix \(A\) of size \(n \times n\), the determinant is denoted as \(\text{det}(A)\) or \(|A|\). It represents a signed volume (or area in 2D) of the parallelepiped spanned by the column vectors of the matrix. The determinant has various applications, such as determining invertibility, solving systems of linear equations, and measuring how much a transformation scales the volume.\n\n2. Singular Matrix:\nA square matrix is singular if its determinant is zero. A singular matrix is non-invertible, and its columns are linearly dependent, meaning that one column can be written as a linear combination of other columns.\n\n3. Symmetric Matrix:\nA symmetric matrix is a square matrix that is equal to its transpose. Formally, \(A\) is symmetric if \(A = A^T\). Symmetric matrices have real eigenvalues and orthogonal eigenvectors.\n\n4. Positive Semi(definite) Matrix:\nA symmetric matrix \(A\) is positive semi(definite) if all its eigenvalues are non-negative (positive). Formally, for all nonzero vectors \(x\), \(x^T A x \geq 0\) (\(x^T A x > 0\) for positive definite).\n\n5. Negative Semi(definite) Matrix:\nA symmetric matrix \(A\) is negative semi(definite) if all its eigenvalues are non-positive (negative). Formally, for all nonzero vectors \(x\), \(x^T A x \leq 0\) (\(x^T A x < 0\) for negative definite).\n\n6. Indefinite Matrix:\nA symmetric matrix \(A\) is indefinite if it has both positive and negative eigenvalues. It means \(x^T A x\) can take both positive and negative values for some nonzero vector \(x\).\n\n7. Orthogonal Matrix:\nAn orthogonal matrix is a square matrix whose columns are orthonormal, i.e., the dot product of any two columns is zero, and each column has a unit norm. Orthogonal matrices preserve lengths and angles, and their inverse is equal to their transpose.\n\n8. Upper Triangle (Upper Triangular) Matrix:\nAn upper triangular matrix is a square matrix in which all elements below the main diagonal are zero.\n\n9. Lower Triangle (Lower Triangular) Matrix:\nA lower triangular matrix is a square matrix in which all elements above the main diagonal are zero.\n\n10. Inverse:\nThe inverse of a square matrix \(A\) (denoted as \(A^{-1}\)) is a matrix that, when multiplied by \(A\), gives the identity matrix. Only non-singular (invertible) square matrices have inverses.\n\n11. Eigen Decomposition (Eigendecomposition):\nEigen decomposition is a factorization of a square matrix \(A\) into three matrices: \(A = P \Lambda P^{-1}\), where \(P\) is a matrix of eigenvectors of \(A\), and \(\Lambda\) is a diagonal matrix of corresponding eigenvalues.\n\n12. LU Decomposition (LU Factorization):\nLU decomposition factors a square matrix \(A\) into the product of a lower triangular matrix \(L\) and an upper triangular matrix \(U\). It is useful for solving systems of linear equations and calculating determinants.\n\n13. Cholesky Decomposition:\nCholesky decomposition is a specialized form of LU decomposition for symmetric positive definite matrices. It factors the matrix \(A\) into the product of a lower triangular matrix \(L\) and its transpose \(L^T\).\n\n14. Solves Linear Expressions Using Gaussian Elimination:\nGaussian elimination is a method for solving systems of linear equations represented by matrices. It involves transforming the augmented matrix (matrix containing both coefficient matrix and constant vector) to row-echelon form and then back-substituting to find the unknown variables.'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _selectedTabIndex == 0
                  ? const Text('How Exciting!')
                  : const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discrete Math',
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
            icon: _selectedTabIndex == 0
                ? const Icon(Icons.info_rounded)
                : const Icon(Icons.warning_rounded),
            onPressed: () => info(),
          )
        ],
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        reverse: _selectedTabIndex == 2,
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
        child: _selectedTabIndex == 0
            ? const GeneralAlgebraWidget()
            : _selectedTabIndex == 1
                ? const VectorWidget()
                : const MatrixWidget(),
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
            label: 'General Algebra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Vector',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Matrix',
          ),
        ],
      ),
    );
  }
}
