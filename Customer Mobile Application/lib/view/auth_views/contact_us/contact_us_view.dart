import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../shared/size_configuration/text_sizes.dart';
import 'components/ContactUsViewBody.dart';

class ContactUsView extends StatefulWidget {
  ContactUsView({Key key}) : super(key: key);
  static final String routeName = 'ContactUsView';
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(//TODO: refactor aapp bar leading arrow
      appBar: AppBar(
        title: Text('الإتصال بخدمة العملاء',
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.headline6,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15),
                ),leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  navigator.pop();
                },
              ),
      ),
      body: ContactUsViewBody(),
    );
  }
}
