import 'package:flutter/material.dart';

import '../../../shared/design_components/animation/animation.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';
import 'components/login_view_body.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);
  static String routeName = 'LoginView';
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    SizeConfiguration.init(context);

    return AnimatedTheme(
        data: Theme.of(context),
        duration: Duration(milliseconds: 500),
        child: Scaffold(
          appBar: AppBar(
            title: CustomAnimation(
              child: Text('تسجيل الدخول',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.headline6,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15)),
            ),
          ),
          body: LoginViewBody(),
        ));
  }
}
