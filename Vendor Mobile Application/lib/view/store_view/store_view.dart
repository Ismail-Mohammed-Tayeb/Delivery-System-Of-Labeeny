import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/store_view_body.dart';

class StoreView extends StatefulWidget {
  StoreView({Key key}) : super(key: key);

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                'المتجر',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
            actions: [
              IconButton(
                tooltip: 'تعديل معلومات المتجر',
                splashRadius: 20,
                hoverColor: Theme.of(context).accentColor.withOpacity(0.1),
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
            ),
          ];
        },
        body: StoreViewBody(),
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
