import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTestWidget extends StatefulWidget {
  const MapTestWidget({Key? key}) : super(key: key);

  @override
  State<MapTestWidget> createState() => _MapTestWidgetState();
}

class _MapTestWidgetState extends State<MapTestWidget> {

  late GoogleMapController mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.4529442, -47.4801777),
    zoom: 20,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    const marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(-23.4529442, -47.4801777),
    );

    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: _kGooglePlex,
      zoomGesturesEnabled: true,
      markers: markers.values.toSet(),
    );
  }
}