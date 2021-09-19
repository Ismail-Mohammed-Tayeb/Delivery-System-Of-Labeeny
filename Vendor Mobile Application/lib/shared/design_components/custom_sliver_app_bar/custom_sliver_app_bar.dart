import 'package:flutter/material.dart';

import '../../size_configuration/size_config.dart';

class CustomSliverAppBar extends StatefulWidget {
  CustomSliverAppBar({
    Key key,
    this.title,
    this.icon,
    this.onPressed,
    this.actions,
  }) : super();
  final Widget title;
  final Widget icon;
  final List<Widget> actions;
  final Function onPressed;
  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      actions: widget.actions,
      snap: false,
      floating: true,
      brightness: Theme.of(context).brightness,
      foregroundColor: Colors.red,
      backgroundColor: Theme.of(context).colorScheme.primary,
      expandedHeight: getProportionateScreenWidth(40),
      title: SizedBox(child: widget.title),
      backwardsCompatibility: false,
    );
  }
}
