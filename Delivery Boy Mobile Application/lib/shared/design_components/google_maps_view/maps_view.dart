import 'dart:async';

import 'package:delivery_boy_application/shared/design_components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCreatorWrapper extends StatefulWidget {
  final bool fromCurrentLocation;

  ///If Source Is Provided As Null Than the meaning is draw line from current Location
  ///
  ///To Target LatLng
  final LatLng sourceLocation;
  final LatLng destLocation;
  MapCreatorWrapper(
      {@required this.fromCurrentLocation,
      @required this.sourceLocation,
      @required this.destLocation})
      : super();
  @override
  _MapCreatorWrapperState createState() => _MapCreatorWrapperState();
}

class _MapCreatorWrapperState extends State<MapCreatorWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.fromCurrentLocation
        ? FutureBuilder<Position>(
            future: Geolocator.getCurrentPosition(),
            builder: (context, snapshot) {
              if (snapshot.data == null || !snapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('عرض الخريطة'),
                    centerTitle: true,
                  ),
                  body: Center(
                    child: CustomCircularProgressIndicator(),
                  ),
                );
              }
              return MapsView(
                sourceLocation:
                    LatLng(snapshot.data.latitude, snapshot.data.longitude),
                destLocation: widget.destLocation,
              );
            },
          )
        : MapsView(
            sourceLocation: widget.sourceLocation,
            destLocation: widget.destLocation,
          );
    ;
  }
}

class MapsView extends StatefulWidget {
  ///If Source Is Provided As Null Than the meaning is draw line from current Location
  ///
  ///To Target LatLng
  final LatLng sourceLocation;
  final LatLng destLocation;
  MapsView({
    @required this.sourceLocation,
    @required this.destLocation,
  }) : super();

  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  static double cameraZoom = 5;
  static double cameraTilt = 0;
  static double cameraBearing = 30;

  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDiKif9h_5F8hNnTIOkqsZwc8GT6IIYYe0";
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/maps_icons/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/maps_icons/destination_map_marker.png');
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: cameraZoom,
        bearing: cameraBearing,
        tilt: cameraTilt,
        target: widget.sourceLocation);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('عرض الخريطة'),
          centerTitle: true,
        ),
        body: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            onMapCreated: onMapCreated),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    // controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: widget.sourceLocation,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: widget.destLocation,
          icon: destinationIcon));
    });
  }

  setPolylines() async {
    try {
      debugPrint("Entered Set PolyLines");
      PolylineResult result = await polylinePoints?.getRouteBetweenCoordinates(
          googleAPIKey,
          PointLatLng(
              widget.sourceLocation.latitude, widget.sourceLocation.longitude),
          PointLatLng(
              widget.destLocation.latitude, widget.destLocation.longitude));
      if (result.points.isNotEmpty) {
        // loop through all PointLatLng points and convert them
        // to a list of LatLng, required by the Polyline
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    } catch (e) {
      debugPrint("Error Occured : ${e.message}");
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
