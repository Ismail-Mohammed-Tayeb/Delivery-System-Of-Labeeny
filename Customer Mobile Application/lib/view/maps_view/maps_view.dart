import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/maps_view_body.dart';

class MapsView extends StatelessWidget {
  //Named Routing Here Isn't possible since the page requires parameters forwarding
  // static String routeName = '/MapsView';
  final LatLng initialMapPosition;
  const MapsView({@required this.initialMapPosition}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الخرائط',
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontFamily: 'Almarai',
              fontSize: TextSizes.headline6,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15),
        ),
        leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  navigator.pop();
                },
              ),
        
      ),
      body: MapsViewBody(initialMapPosition: initialMapPosition),
    );
  }
}
