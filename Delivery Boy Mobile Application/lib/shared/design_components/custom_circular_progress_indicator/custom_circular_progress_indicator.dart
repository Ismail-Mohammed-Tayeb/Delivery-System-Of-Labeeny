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
                Theme.of(context).colorScheme.secondary),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          top: 1,
          left: 1,
          child: Container(
            //  color: Colors.white,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAXpuFIYjnV9wCZbL92W25VnAoUQeH2ghbpA&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle),
          ),
        )
      ],
    );
  }
}
