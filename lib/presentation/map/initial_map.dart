// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTestWidget extends StatefulWidget {
  const MapTestWidget({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  final double latitude;
  final double longitude;

  @override
  State<MapTestWidget> createState() => _MapTestWidgetState();
}

class _MapTestWidgetState extends State<MapTestWidget> {

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    Marker marker = Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(widget.latitude, widget.longitude),
    );

    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  
  @override
  Widget build(BuildContext context) {

    final CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 20,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CEP'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: kGooglePlex,
        zoomGesturesEnabled: true,
        markers: markers.values.toSet(),
      ),
    );
  }
}