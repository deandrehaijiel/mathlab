import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWidget extends StatelessWidget {
  const OpenContainerWidget(
      {super.key, required this.child, required this.imageName});

  final Widget child;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        transitionType: ContainerTransitionType.fadeThrough,
        openShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        closedColor: Colors.white,
        openColor: Colors.white,
        closedElevation: 10,
        openElevation: 10,
        openBuilder: (BuildContext context, VoidCallback _) {
          return child;
        },
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return InkWell(
            onTap: openContainer,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(imageName),
            ),
          );
        },
      ),
    );
  }
}
