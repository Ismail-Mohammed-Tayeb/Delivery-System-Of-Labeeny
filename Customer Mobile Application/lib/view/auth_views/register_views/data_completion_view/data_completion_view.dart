import 'package:flutter/material.dart';

import '../../../../shared/size_configuration/text_sizes.dart';
import 'components/data_completion_view_body.dart';

class DataCompletionView extends StatefulWidget {
  final String phoneNumber;
  DataCompletionView({@required this.phoneNumber}) : super();
  static String routeName = 'DataCompletionView';

  @override
  _DataCompletionViewState createState() => _DataCompletionViewState();
}

class _DataCompletionViewState extends State<DataCompletionView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
        data: Theme.of(context),
        duration: Duration(milliseconds: 500),
        child: Scaffold(
          appBar: AppBar(
            title: Text('إنشاء الحساب',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15)),
          ),
          body: DataCompletionViewBody(phoneNumber: widget.phoneNumber),
        ));
  }
}
