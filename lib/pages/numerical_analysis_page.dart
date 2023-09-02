import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class NumericalAnalysisPage extends StatefulWidget {
  const NumericalAnalysisPage({super.key});

  @override
  State<NumericalAnalysisPage> createState() => _NumericalAnalysisPageState();
}

class _NumericalAnalysisPageState extends State<NumericalAnalysisPage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedTabIndex();
  }

  void _saveSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedNATabIndex', _selectedTabIndex);
  }

  void _loadSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTabIndex = prefs.getInt('selectedNATabIndex') ?? 0;
    });
  }

  void info() {
    showModal(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Information',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(_selectedTabIndex == 0
                ? 'The secant method is a root-finding algorithm used in numerical analysis to approximate the roots of a continuous function. It is an iterative method that builds upon the concept of secant lines to approximate the location of a root.\n\nThe basic idea behind the secant method is to start with two initial guesses, x0 and x1, that are close to the root. The method then generates a sequence of approximations, xn, by intersecting secant lines through the points (x0, f(x0)) and (x1, f(x1)), with the x-axis. The intersection point of the secant line with the x-axis provides an improved estimate of the root. This process is repeated iteratively until a desired level of accuracy is achieved.\n\nThe formula for calculating the next approximation xn+1 using the secant method is:\n\nxn+1 = xn - f(xn) * (xn - xn-1) / (f(xn) - f(xn-1))\n\nwhere f(xn) and f(xn-1) represent the values of the function at xn and xn-1, respectively.\n\nThe secant method is based on the principle that the secant line passing through two points approaches the tangent line at the root, and the root can be approximated by finding the x-intercept of the secant line.\n\nThe advantages of the secant method include simplicity of implementation and faster convergence compared to other root-finding methods like the bisection method. However, the secant method may not always converge or may converge to a different root if multiple roots exist in the vicinity of the initial guesses.\n\nTo use the secant method, you need to provide an initial guess, x0 and x1, that are close to the root, as well as the function f(x) for which you want to find the root. The method iteratively refines the approximation until the desired level of accuracy is achieved or a maximum number of iterations is reached.'
                : 'Newton\'s method, also known as the Newton-Raphson method, is a root-finding algorithm used in numerical analysis to approximate the roots of a function. It is an iterative method that relies on the principle of using tangent lines to approximate the location of a root.\n\nThe basic idea behind Newton\'s method is to start with an initial guess, x0, that is close to the root. The method then generates a sequence of approximations, xn, by intersecting the tangent line to the function at the point (xn, f(xn)) with the x-axis. The intersection point of the tangent line with the x-axis provides an improved estimate of the root. This process is repeated iteratively until a desired level of accuracy is achieved.\n\nThe formula for calculating the next approximation xn+1 using Newton\'s method is:\n\nxn+1 = xn - f(xn) / f\'(xn)\n\nwhere f(xn) represents the value of the function at xn, and f\'(xn) represents the derivative of the function at xn.\n\nNewton\'s method leverages the fact that the tangent line to a function provides a good approximation of the function near a root. By iteratively updating the approximation using the tangent line, the method converges towards the root with increasing accuracy.\n\nThe advantages of Newton\'s method include fast convergence and efficiency for functions with well-behaved derivatives. It can converge quadratically, which means that the number of accurate digits approximately doubles with each iteration. However, the method may fail to converge or converge to a different root if the initial guess is far from the root or encounters other convergence issues.\n\nTo use Newton\'s method, you need to provide an initial guess, x0, that is close to the root, as well as the function f(x) and its derivative f\'(x). The method iteratively refines the approximation until the desired level of accuracy is achieved or a maximum number of iterations is reached. It is important to note that the derivative of the function needs to be well-defined and non-zero in the vicinity of the root for Newton\'s method to work effectively.'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('How Exciting!'),
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
          'Numerical Analysis',
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
            icon: const Icon(Icons.info_rounded),
            onPressed: () => info(),
          )
        ],
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        reverse: _selectedTabIndex == 1,
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
            ? const SecantMethodWidget()
            : const NewtonsMethodWidget(),
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
            label: 'Secant Method',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Newton\'s Method',
          ),
        ],
      ),
    );
  }
}
