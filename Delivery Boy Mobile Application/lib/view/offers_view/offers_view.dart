import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/offer_view_body.dart';

class OffersView extends StatefulWidget {
  OffersView() : super();

  @override
  _OffersViewState createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              'العروض',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.headline6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
            ),
          ),
          SliverToBoxAdapter(
            child: OfferViewBody(),
          ),
        ],
      ),
    );
  }
}
