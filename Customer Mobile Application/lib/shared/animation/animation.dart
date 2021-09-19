import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CustomAnimation extends StatefulWidget {
  /// This List Contains Animations Where
  ///
  ///  `0 Is Normal Animation`
  ///
  /// `1 Delayed Animation`
  ///
  /// `2 Match Delayed Animation`
  final int animationIndex;
  final Widget child;
  CustomAnimation({@required this.child, this.animationIndex = 0}) : super();
  @override
  _CustomAnimationState createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with SingleTickerProviderStateMixin {
  Animation animation, delayedanimation, mutchDelayedanimation;
  AnimationController animationController;
  List<Animation> animations;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animations = <Animation>[
      Tween(begin: -1.0, end: .0).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      )),
      Tween(begin: -1.0, end: .0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(.4, 1.0, curve: Curves.fastOutSlowIn),
      )),
      Tween(begin: -1.0, end: .0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
      )),
    ];

    animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.translationValues(
              MediaQuery.of(context).size.width *
                  animations[widget.animationIndex].value,
              .0,
              .0),
          child: widget.child,
        );
      },
    );
  }
}
