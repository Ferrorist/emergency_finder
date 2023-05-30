import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({super.key, required this.position});

  final Future<Position> position;

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  // GoogleMapController :
  // GoogleMap widget과 지도 서비스 사이의 다리 역할을 함.
  late GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.position,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
              zoom: 14.3,
            ),
            // 지도에 파란 점으로 사용자의 현재 위치 표시
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
