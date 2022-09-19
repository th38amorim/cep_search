// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OverviewMapPage extends StatefulWidget {
  const OverviewMapPage({Key? key, required this.latitude, required this.longitude, required this.cep}) : super(key: key);

  final String cep;
  final double latitude;
  final double longitude;

  @override
  State<OverviewMapPage> createState() => _OverviewMapPageState();
}

class _OverviewMapPageState extends State<OverviewMapPage> {

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
        title: Text('CEP: ${widget.cep}'),
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