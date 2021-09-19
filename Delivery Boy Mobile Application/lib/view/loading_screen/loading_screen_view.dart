import 'package:delivery_boy_application/shared/size_configuration/size_config.dart';
import 'package:delivery_boy_application/view/loading_screen/components/loading_screen_view_body.dart';
import 'package:flutter/material.dart';

class LoadingScreenView extends StatefulWidget {
  static const String routeName = '/LoadingScreenView';
  LoadingScreenView({Key key}) : super(key: key);

  @override
  _LoadingScreenViewState createState() => _LoadingScreenViewState();
}

class _LoadingScreenViewState extends State<LoadingScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfiguration.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoadingScreenViewBody(),
    );
  }
}
