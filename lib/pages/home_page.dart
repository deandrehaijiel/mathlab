import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationUp;
  late Animation<Offset> _animationDown;
  late Animation<Offset> _animationLeft;
  late Animation<Offset> _animationRight;
  late Animation<double> _animationScale;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    _animationUp = Tween<Offset>(
      begin: const Offset(0.0, -10.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationDown = Tween<Offset>(
      begin: const Offset(0.0, 10.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationLeft = Tween<Offset>(
      begin: const Offset(-10.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationRight = Tween<Offset>(
      begin: const Offset(10.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Hero(
            tag: 'title',
            child: DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'Berlin',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Colors.white,
              ),
              child: Text(
                'MathLab',
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            FadingEdgeScrollView.fromSingleChildScrollView(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 100, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _animationUp,
                      child: const Align(
                        alignment: Alignment(-0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/wave.png',
                          child: TrigonometryPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationRight,
                      child: const Align(
                        alignment: Alignment(0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/calculus.png',
                          child: DifferentiationIntegrationPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationLeft,
                      child: const Align(
                        alignment: Alignment(-0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/elementary_algebra.png',
                          child: ElementaryAlgebraPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationRight,
                      child: const Align(
                        alignment: Alignment(0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/complex_analysis.png',
                          child: ComplexAnalysisPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationLeft,
                      child: const Align(
                        alignment: Alignment(-0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/discrete_mathematics.png',
                          child: DiscreteMathematicsPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationRight,
                      child: const Align(
                        alignment: Alignment(0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/numerical_analysis.png',
                          child: NumericalAnalysisPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationLeft,
                      child: const Align(
                        alignment: Alignment(-0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/probability_theory.png',
                          child: ProbabilityTheoryPage(),
                        ),
                      ),
                    ),
                    SlideTransition(
                      position: _animationDown,
                      child: const Align(
                        alignment: Alignment(0.5, 0.0),
                        child: OpenContainerWidget(
                          imageName: 'assets/image/statistics.png',
                          child: StatisticsPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: const ShapeDecoration(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                ),
                color: Colors.blue,
                shadows: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 10,
                    blurRadius: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ScaleTransition(
          scale: _animationScale,
          child: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              heroTag: 'ChatGPT',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatGPTPage(),
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/image/ai.png',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
