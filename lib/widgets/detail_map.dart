import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapScreen({required this.latitude, required this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 300,
      height: 400,
      child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 15,
          ),
          onMapCreated: (controller) {
            setState(() {
              _mapController = controller;
            });
          },
          markers: {
            Marker(
              markerId: MarkerId('location'),
              position: LatLng(widget.latitude, widget.longitude),
            ),
          },
        ),
    );
  }
}
