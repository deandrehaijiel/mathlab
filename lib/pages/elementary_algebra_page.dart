import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class ElementaryAlgebraPage extends StatefulWidget {
  const ElementaryAlgebraPage({super.key});

  @override
  State<ElementaryAlgebraPage> createState() => _ElementaryAlgebraPageState();
}

class _ElementaryAlgebraPageState extends State<ElementaryAlgebraPage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedTabIndex();
  }

  void _saveSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedEATabIndex', _selectedTabIndex);
  }

  void _loadSelectedTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTabIndex = prefs.getInt('selectedEATabIndex') ?? 0;
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
            'Take Note',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Text(
              '1. Use only the variable "x" in the equation. Other variables are not supported.\n\n2. Use standard mathematical functions such as addition (+), subtraction (-), multiplication (*), and division (/). These functions can be used to combine numbers and variables in the equation.\n\n3. Parentheses can be used to group parts of the equation together. For example, "(3 * x + 2) * 5" is a valid equation.\n\n4. Use standard mathematical functions such as sin(x), cos(x), tan(x), e(x), and log(b, x) to include more complex mathematical operations in the equation.\n\n5. Use the caret (^) symbol to indicate exponents. For example, "x ^ 2" represents "x squared".\n\n6. Use only numbers and mathematical operators when inputting the equation. Special characters and symbols are not supported.\n\n7. Make sure the equation is entered correctly and without any typos. Any errors in the equation will result in an error message.\n\n8. Remember to use the correct syntax for the mathematical functions used in the equation. Incorrect syntax will result in an error message.\n\n9. Coefficient of x ^ 2 for quadratic and x ^ 3 for cubic should not be equal to zero.',
            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Elementary Algebra',
          style: TextStyle(
            fontFamily: 'Berlin',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        actions: [
          _selectedTabIndex < 2
              ? IconButton(
                  icon: const Icon(Icons.warning_rounded),
                  onPressed: () => info(),
                )
              : const SizedBox()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: PageTransitionSwitcher(
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
              ? const QuadraticEquationWidget()
              : _selectedTabIndex == 1
                  ? const CubicEquationWidget()
                  : const HypotenuseWidget(),
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
            label: 'Quadratic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Cubic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions_rounded, size: 0),
            label: 'Hypotenuse',
          ),
        ],
      ),
    );
  }
}
