import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import 'shared/design_components/theme/dark_theme/dark_theme.dart';
import 'shared/design_components/theme/light_theme/light_theme.dart';
import 'shared/routes/routes.dart';
import 'view/auth_views/login_view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(CustomTheme(savedThemeMode: savedThemeMode));
}

class CustomTheme extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;
  const CustomTheme({this.savedThemeMode}) : super();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AdaptiveTheme(
        light: lightTheme(),
        dark: darkTheme(),
        initial: savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (lightTheme, darkTheme) => GetMaterialApp(
          title: 'Labeeny - Vendor Application',
          textDirection: TextDirection.rtl,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          initialRoute: LoginView.routeName,
          getPages: listGetPage,
        ),
      ),
    );
  }
}
