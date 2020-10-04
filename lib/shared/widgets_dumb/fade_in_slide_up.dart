import 'package:flutter/material.dart';

class SharedFadeInSlideUp_Dumb extends StatefulWidget {
  final Widget child;

  SharedFadeInSlideUp_Dumb({
    @required this.child,
  });

  @override
  SharedFadeInSlideUp_DumbState createState() =>
      SharedFadeInSlideUp_DumbState();
}

class SharedFadeInSlideUp_DumbState extends State<SharedFadeInSlideUp_Dumb>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationFade;
  Animation<Offset> animationPosition;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 240),
      vsync: this,
    );

    animationFade = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animationPosition = Tween<Offset>(
      begin: Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animationPosition,
      child: FadeTransition(
        opacity: animationFade,
        child: widget.child,
      ),
    );
  }
}
