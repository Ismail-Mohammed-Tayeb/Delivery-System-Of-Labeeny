import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  CustomCircularProgressIndicator({Key key}) : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).iconTheme.color,),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          top: 1,
          left: 1,
          child: Container(
            //  color: Colors.white,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(
              'assets/images/Logo_labeeny_black.png',
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        )
      ],
    );
  }
}
