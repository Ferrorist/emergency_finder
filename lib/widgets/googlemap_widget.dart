import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({super.key, required this.userPosition});

  final Future<Position> userPosition;

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.userPosition,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
              zoom: 12,
            ),
            onMapCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
          );
        } else {
          return const Center(child: Text("Find User Position..."));
        }
      },
    );
  }
}
