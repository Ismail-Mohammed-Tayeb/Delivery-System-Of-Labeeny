// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';

// import '../../../controllers/location_controllers/geo_location_controller.dart';

// class MapsViewBody extends StatefulWidget {
//   /// This Parameter is of type LatLang:
//   ///
//   /// Declaration Method: `LatLang(Latitude,Longitude)`
//   final initialMapPosition;
//   MapsViewBody({
//     @required this.initialMapPosition,
//   }) : super();

//   @override
//   _MapsViewBodyState createState() => _MapsViewBodyState();
// }

// class _MapsViewBodyState extends State<MapsViewBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       child: PlacePicker(
//         onGeocodingSearchFailed: (str) {
//           print(str);
//         },
//         desiredLocationAccuracy: LocationAccuracy.best,
//         enableMapTypeButton: false,
//         apiKey: 'AIzaSyDiKif9h_5F8hNnTIOkqsZwc8GT6IIYYe0',
//         initialPosition: widget.initialMapPosition,
//         useCurrentLocation: true,
//         selectInitialPosition: true,
//         onPlacePicked: (result) async {
//           GeoLocationApiController.latitude.value =
//               result.geometry.location.lat;
//           GeoLocationApiController.longitude.value =
//               result.geometry.location.lng;
//           await GeoLocationApiController.getLocationNameFromCoordinates();
//           Navigator.of(context).pop();
//           setState(() {});
//         },
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:customer_labeeny/controllers/location_controllers/geo_location_controller.dart';
import 'package:customer_labeeny/shared/size_configuration/text_sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsViewBody extends StatefulWidget {
  /// This Parameter is of type LatLang:
  ///
  /// Declaration Method: `LatLang(Latitude,Longitude)`
  final LatLng initialMapPosition;
  MapsViewBody({
    @required this.initialMapPosition,
  }) : super();

  @override
  _MapsViewBodyState createState() => _MapsViewBodyState();
}

class _MapsViewBodyState extends State<MapsViewBody> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng pickedLocation;
  Set<Marker> markers = <Marker>{};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          compassEnabled: true,
          myLocationButtonEnabled: true,
          markers: markers,
          onTap: _mapTaped,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: widget.initialMapPosition, zoom: 15),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        pickedLocation == null ? SizedBox.shrink() : _buildDetailsContainer(),
      ],
    );
  }

  Positioned _buildDetailsContainer() {
    return Positioned(
      bottom: 50,
      left: MediaQuery.of(context).size.width * .5 - 125,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 7,
              color: Colors.black.withOpacity(.3),
              spreadRadius: 2,
            )
          ],
        ),
        height: 80,
        width: 250,
        child: Center(
          child: FutureBuilder<String>(
            future: GeoLocationApiController.getLocationNameFromCoordinates(),
            builder: (context, snapshot) {
              if (snapshot.data == null || !snapshot.hasData) {
                return Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data.toString(),
                    textAlign: TextAlign.center,
                       style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body1,
                                    fontWeight: FontWeight.bold
                                  ),
                  ),
                  Text(
                    ' موقعك: ' +
                        pickedLocation.latitude.toStringAsFixed(2) +
                        ' , ' +
                        pickedLocation.longitude.toStringAsFixed(2),
                    textAlign: TextAlign.center,
                          style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.subtitle1,
                                  ),
                    
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _mapTaped(LatLng location) async {
    print('Chosen LatLng:${location.latitude},${location.longitude}');
    GeoLocationApiController.latitude.value = location.latitude;
    GeoLocationApiController.longitude.value = location.longitude;
    await GeoLocationApiController.getLocationNameFromCoordinates();
    setState(() {
      pickedLocation = location;
      markers.clear();
      markers.add(Marker(markerId: MarkerId('1'), position: location));
    });
  }
}
